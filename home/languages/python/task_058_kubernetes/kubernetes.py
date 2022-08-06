import kubernetes
# import time
import os
from kubernetes import config
# import logging

from task_052_utility.utility import *
from task_053_slack.slack import *


VAR_ENVIRONMENT_IN_CONSIDERATION = ""

class KubernetesTasks(object):
    kubeconfig_location = ""
    api_instance = None

    def __init__(self, environment):
        logging.info("----------------------INFO----------------------------------------------------KubernetesTasks constructor ----------------------------------------")
        dir_path = os.path.dirname(os.path.realpath(__file__))
        if environment == "dev":
            self.kubeconfig_location = dir_path + "/../../../" + "/kubeconf/" + "dev" + "/kubeconfig"
        elif environment == "stage":
            self.kubeconfig_location = dir_path + "/../../../" + "/kubeconf/" + "stage" + "/kubeconfig"
        elif environment == "prod":
            self.kubeconfig_location = dir_path + "/../../../" + "/kubeconf/" + "prod" + "/kubeconfig"
        config.load_kube_config(self.kubeconfig_location)
        self.api_instance = kubernetes.client.CoreV1Api()

    def get_deployed_image_hash(self, repo_name):
        """
        get_deployed_image_hash : to check the image hash of currently deployed image for repository repo_name
        :param repo_name: the repository in consideration
        :param branch_name: the branch name in consideration
        :return: String image hash of the currently deployed image
        """
        logging.info("----------------------INFO----------------------------------------------------KubernetesTasks get_deployed_image_hash ----------------------------------------")
        app_name = ""
        actual_sha = "Not Found"
        pod_list = self.api_instance.list_pod_for_all_namespaces(watch=False)
        # https://kubetest.readthedocs.io/en/latest/_modules/kubernetes/client/models/v1_pod.html
        if pod_list.items is not None:
            for listEle in pod_list.items:
                if 'metadata' in listEle.to_dict():
                    if 'labels' in listEle.to_dict()['metadata']:
                        labels_dic = listEle.metadata.labels
                        if labels_dic is not None:
                            for key, value in labels_dic.items():
                                if key == "app":
                                    app_name = value
                                    break
                        if app_name != repo_name:
                            continue
                if 'status' in listEle.to_dict():
                    if 'container_statuses' in listEle.to_dict()['status']:
                        if isinstance(listEle.status.container_statuses, list):
                            for element in listEle.status.container_statuses:
                                if 'image_id' in element.to_dict():
                                    actual_sha = element.image_id
                                    actual_sha = actual_sha.split(":")
                                    if len(actual_sha) == 3:
                                        actual_sha = actual_sha[2]
        return actual_sha

    def is_image_deployed(self, repo_name, branch_name, dockerhub_tasks_obj):
        """
        is_image_deployed : to check if the image of repository repo_name and branch branch_name has been deployed to environment
        :param repo_name: the repository in consideration
        :param branch_name: the branch in consideration
        :param dockerhub_tasks_obj: the docker hub task object required to get the latest image tag of repository repo_name and branch branch_name
        :return: True or False
        """
        logging.info("----------------------INFO----------------------------------------------------KubernetesTasks is_image_deployed ----------------------------------------")
        is_image_deployed = False
        is_changes_live = False
        app_name = ""
        req_sha = dockerhub_tasks_obj.get_sha_version_of_latest_docker_image(repo_name, branch_name)
        req_sha = req_sha.split(":")[1]
        pod_list = self.api_instance.list_pod_for_all_namespaces(watch=False)
        # https://kubetest.readthedocs.io/en/latest/_modules/kubernetes/client/models/v1_pod.html
        if pod_list.items is not None:
            for listEle in pod_list.items:
                if 'status' in listEle.to_dict():
                    if 'conditions' in listEle.to_dict()['status']:
                        if listEle.status.conditions is not None:
                            for condition in listEle.status.conditions:
                                if 'type' in condition.to_dict() and 'status' in condition.to_dict():
                                    # https://jashandeep-sohik8s-python.readthedocs.io/en/latest/kubernetes.client.models.html
                                    if condition.type == "ContainersReady" and str(condition.status) == "True":
                                        is_changes_live = True
                if 'metadata' in listEle.to_dict():
                    if 'labels' in listEle.to_dict()['metadata']:
                        labels_dic = listEle.metadata.labels
                        if labels_dic is not None:
                            for key, value in labels_dic.items():
                                if key == "app":
                                    app_name = value
                                    break
                            if app_name != repo_name:
                                continue
                if 'status' in listEle.to_dict():
                    if 'container_statuses' in listEle.to_dict()['status']:
                        # https://stackoverflow.com/questions/707674/how-to-compare-type-of-an-object-in-python , is the API response object contains instance of class type None
                        if isinstance(listEle.status.container_statuses, list):
                            for element in listEle.status.container_statuses:
                                if 'image_id' in element.to_dict():
                                    actual_sha = element.image_id
                                    actual_sha = actual_sha.split(":")
                                    if len(actual_sha) == 3:
                                        actual_sha = actual_sha[2]
                                        if actual_sha == req_sha:
                                            is_image_deployed = True
        return is_image_deployed and is_changes_live

    def is_all_image_deployed(self, repo_list, branch_name, dockerhub_tasks_obj):
        """
        is_all_image_deployed : to check if all the images of repo_list have been deployed to environment
        :param repo_list: the list of repositories
        :param branch_name: the branch in consideration
        :param dockerhub_tasks_obj: the dockerhub_task object required to get the latest image tag for any repository
        :return:
        """
        logging.info("----------------------INFO----------------------------------------------------KubernetesTasks is_all_image_deployed ----------------------------------------")
        slack_logging_class_obj = SlackClass(CONSTANT_LOGGING_SLACK_CHANNEL, CONSTANT_SLACK_TOKEN)
        slack_logging_class_obj.update_on_slack_channel("----------------------INFO----------------------------------------------------KubernetesTasks is_all_image_deployed --------------")
        slack_class_obj = SlackClass(CONSTANT_LOGGING_SLACK_CHANNEL, CONSTANT_SLACK_TOKEN)
        slack_class_obj.update_on_slack_channel("\n *Image Deployment validation for environment " + branch_name + "* \n")
        slack_message = ""
        index = 0
        global CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS
        while len(repo_list) > 0 and Utility.time_now() < CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS:
            logging.info("Status of list :  " + str(repo_list))
            repo_name = repo_list[index]
            slack_logging_class_obj.update_on_slack_channel("Deployment validation remaining for :  " + str(repo_list) + "\n" + str(Utility.time_now()) + " ----------->  " + str(CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS))
            logging.info("Considering : " + repo_name)
            if self.is_image_deployed(repo_name, branch_name, dockerhub_tasks_obj):
                print("SUCCESS - Repository : " + str(repo_name) + " Deployed")
                slack_message = slack_message + "\n" + "`SUCCESS` - Repository : `" + str(repo_name) + "`" + " deployed and ready"
                del repo_list[index]
            else:
                print("Repository : " + repo_name + " image not deployed yet")
            time.sleep(1)
            if slack_message != "":
                slack_class_obj.update_on_slack_channel_success(slack_message)
                slack_message = ""
            index = index + 1
            if index >= len(repo_list):
                index = 0
        if len(repo_list) != 0:
            slack_class_obj.update_on_slack_channel("\n Image `NOT` deployed for following repositories. Please check")
            for repo_name in repo_list:
                slack_class_obj.update_on_slack_channel("\n `" + repo_name + "`")
        CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS = time.time() + \
                                                           CONSTANT_10_MINUTES_TO_SECONDS

    def get_all_deployed_image_sha(self, list_all_repos):
        """
        get_all_deployed_image_sha : This method takes list of repos and argument and returns a dictionary containing the SHA version of the deployed images
                                     of the repositories
        :param list_all_repos: the list of repositories in consideration
        :return: dictionary containing the repo names as keys and the corresponding deployed SHA as values
        """
        ret_dict_repo_and_deployed_sha = {}
        for repo in list_all_repos:
            ret_dict_repo_and_deployed_sha[repo] = self.get_deployed_image_hash(repo)
        return ret_dict_repo_and_deployed_sha


k8s_tasks_obj = KubernetesTasks(VAR_ENVIRONMENT_IN_CONSIDERATION)
