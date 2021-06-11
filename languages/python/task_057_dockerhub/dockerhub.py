# import datetime
# import logging
#
# import requests
#
# from task_052_utility.utility import *
# from task_053_slack.slack import *
from task_055_github.github import *


class DockerHubTasks(object):
    """
    ########################################################################
    #  DockerHubTasks CLASS
    # --> This class will contain Dockerhub related operations
    ########################################################################
    """
    token = None

    def __init__(self):
        logging.info("----------------------INFO----------------------------------------------------DockerHubTasks constructor ----------------------------------------")
        query_url = "https://hub.docker.com/v2/users/login/"
        headers = {'Content-Type': 'application/json'
                   }
        data = {
            "username": "someuser",
            "password": "nicetry"
        }
        response_dict = requests.post(query_url, json=data, headers=headers)
        json_obj = response_dict.json()
        self.token = json_obj['token']

    def get_last_updated_timestamp_of_latest_docker_image(self, repo_name, branch):
        """
        get_last_updated_timestamp_of_latest_docker_image : To get the last updated time stamp of latest docker image of repository repo_name and branch branch
        :param repo_name: the repository in consideration
        :param branch: the branch in consideration
        :return: last updated time stamp
        """
        logging.info("----------------------INFO----------------------------------------------------DockerHubTasks get_last_updated_timestamp_of_latest_docker_image ----------------------------------------")
        query_url = f'https://hub.docker.com/v2/repositories/somecompany/{repo_name}/tags/?page_size=1&name={branch}-'
        headers = {'Content-Type': 'application/json',
                   'Authorization': 'JWT ' + self.token
                   }
        response_dict = requests.get(query_url, headers=headers)
        json_obj = response_dict.json()
        last_updated = json_obj['results'][0]['last_updated']
        return last_updated

    def get_sha_version_of_latest_docker_image(self, repo_name, branch):
        """
        get_sha_version_of_latest_docker_image : to get the sha version of the latest docker image of repository repo_name and branch name as branch
        :param repo_name: the repository in consideration
        :param branch: the branch in consideration
        :return: the SHA version
        """
        logging.info("----------------------INFO----------------------------------------------------DockerHubTasks get_sha_version_of_latest_docker_image ----------------------------------------")
        query_url = f'https://hub.docker.com/v2/repositories/somecompany/{repo_name}/tags/?page_size=1&name={branch}-'
        headers = {'Content-Type': 'application/json',
                   'Authorization': 'JWT ' + self.token
                   }
        response_dict = requests.get(query_url, headers=headers)
        json_obj = response_dict.json()
        sha = json_obj['results'][0]['images'][0]['digest']
        return sha

    def get_name_of_latest_docker_image(self, repo_name, branch):
        """
        get_name_of_latest_docker_image : to get the name of the latest docker image
        :param repo_name: the repository in consideration
        :param branch: the branch in consideration
        :return: String name of the latest docker image
        """
        logging.info("----------------------INFO----------------------------------------------------DockerHubTasks get_name_of_latest_docker_image ----------------------------------------")
        query_url = f'https://hub.docker.com/v2/repositories/somecompany/{repo_name}/tags/?page_size=1&name={branch}-'
        headers = {'Content-Type': 'application/json',
                   'Authorization': 'JWT ' + self.token
                   }
        response_dict = requests.get(query_url, headers=headers)
        json_obj = response_dict.json()
        name = json_obj['results'][0]['name']
        return name

    def print_info_docker_hub(self, repo_list, branch):
        """
        print_info_docker_hub : to print the information about the dockerhub tags and other information
        :param repo_list: the repository list
        :param branch: the branch in consideration
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------DockerHubTasks print_info_docker_hub ----------------------------------------")
        for repo in repo_list:
            print("Repository " + repo + " and Branch " + branch)
            print(self.get_name_of_latest_docker_image(repo, branch))
            print(self.get_last_updated_timestamp_of_latest_docker_image(repo, branch))
            print(self.get_sha_version_of_latest_docker_image(repo, branch))

    def is_image_uploaded_in_last_60_mins(self, repo_name, branch_name):
        """
        is_image_uploaded_in_last_60_mins : to check if the docker images has been uploaded in last 60 mins
        :param repo_name: the repository in consideration
        :param branch_name: the branch in consideration
        :return: True or False
        """
        logging.info("----------------------INFO----------------------------------------------------DockerHubTasks is_image_uploaded_in_last_60_mins ----------------------------------------")
        no_seconds = CONSTANT_60_MINUTES_TO_SECONDS
        # no_seconds = 500000
        last_updated_timestamp = self.get_last_updated_timestamp_of_latest_docker_image(repo_name, branch_name)
        last_updated_timestamp_date_obj = datetime.strptime(last_updated_timestamp, "%Y-%m-%dT%H:%M:%S.%fZ")
        time_diff = Utility.time_difference(last_updated_timestamp_date_obj, Utility.time_now_utc())
        # print(str(repo_name) + "   " + str(no_seconds) + "  " + str(time_diff) + "   " + str(last_updated_timestamp))
        if time_diff < no_seconds:
            return True
        else:
            return False

    def is_all_image_uploaded_in_last_60_mins(self, repo_list, branch_name):
        """
        is_all_image_uploaded_in_last_60_mins : to check if the all the images mentioned in the repo_list have been uploaded in last 60 minutes
        :param repo_list: list of repositories
        :param branch_name: the branch name in consideration
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------DockerHubTasks is_all_image_uploaded_in_last_60_mins ----------------------------------------")
        slack_class_obj = SlackClass(CONSTANT_LOGGING_SLACK_CHANNEL, CONSTANT_SLACK_TOKEN)
        slack_class_obj.update_on_slack_channel("\n *DockerImage Upload updates for environment " + branch_name + "* \n")
        index = 0
        slack_message = ""
        while len(repo_list) > 0 and Utility.time_now() < CONSTANT_IMAGE_UPLOAD_THRESHOLD_SECONDS:
            print(str(Utility.time_now()) + " ----------->  " + str(CONSTANT_IMAGE_UPLOAD_THRESHOLD_SECONDS))
            print(repo_list)
            print(index)
            repo_name = repo_list[index]
            if self.is_image_uploaded_in_last_60_mins(repo_name, branch_name):
                print("SUCCESS - Repository : " + str(repo_name) + " image was uploaded successfully")
                slack_message = slack_message + "\n" + "`SUCCESS` - Repository : `" + str(repo_name) + "` branch `" + branch_name + "` image was uploaded successfully"
                del repo_list[index]
            else:
                print("Repository : " + repo_name + " image not uploaded yet")
            if Utility.is_30_seconds_passed():
                if slack_message != "":
                    slack_class_obj.update_on_slack_channel(slack_message)
                    slack_message = ""
            index = index + 1
            if index >= len(repo_list):
                index = 0
        if len(repo_list) != 0:
            slack_class_obj.update_on_slack_channel("\n Image was `NOT` uploaded for following repositories. Maybe build didn't get triggered as there was no change. Please check")
            for repo_name in repo_list:
                slack_class_obj.update_on_slack_channel("\n `" + repo_name + "`")


docker_hub_tasks_obj = DockerHubTasks()
