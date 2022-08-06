import logging
import time

import requests

"""
########################################################################################################################################################
# CONSTANT_JENKINS_WEBHOOK_QUERY_URL : Jenkins Webhook URL required to trigger the jenkins jobs via HTTP requests
########################################################################################################################################################
"""
CONSTANT_JENKINS_WEBHOOK_QUERY_URL = "https://jenkins.mycompany.com/generic-webhook-trigger/invoke"

"""
########################################################################################################################################################
# CONSTANT_JENKINS_SUFFIX_SECRET_STAGE : Jenkins webhook secret for stage environment. Required to trigger the stage jobs
########################################################################################################################################################
"""
CONSTANT_JENKINS_SUFFIX_SECRET_STAGE = "-somesecret23492304"

"""
########################################################################################################################################################
# CONSTANT_JENKINS_SUFFIX_SECRET_DEV : Jenkins webhook secret for dev environment. Required to trigger the dev jobs
########################################################################################################################################################
"""
CONSTANT_JENKINS_SUFFIX_SECRET_DEV = "-someaslkdjf23423"

"""
########################################################################################################################################################
# CONSTANT_JENKINS_SUFFIX_SECRET_PROD : Jenkins webhook secret for prod environment. Required to trigger the prod jobs
########################################################################################################################################################
"""
CONSTANT_JENKINS_SUFFIX_SECRET_PROD = "-asdfjk23423slkdjf0293isomethingnotworking"

class JenkinsRelease(object):
    """
    ########################################################################
    #  JenkinsRelease CLASS
    # --> This class will contain Jenkins related operations
    ########################################################################
    """
    secret_suffix_stage = ""
    secret_suffix_dev = ""
    secret_suffix_prod = ""
    query_url_jenkins = ""

    def __init__(self, secret_dev, secret_stage, secret_prod, query_url):
        logging.info("----------------------INFO----------------------------------------------------JenkinsRelease constructor ----------------------------------------")
        self.secret_suffix_dev = secret_dev
        self.secret_suffix_stage = secret_stage
        self.secret_suffix_prod = secret_prod
        self.query_url_jenkins = query_url

    def invoke_jenkins_job(self, secret):
        """
        invoke_jenkins_job : to invoke the jenkins job using webhook
        :param secret: secret required to invoke the webhook
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------JenkinsRelease get_git_log_of_branch ----------------------------------------")
        query_url = self.query_url_jenkins
        params = {
            'token': f'{secret}'
        }
        response_dict = requests.get(query_url, params=params)
        print(response_dict.content)
        time.sleep(2)

    def release_on_stage(self, repo_list):
        """
        release_on_stage : to release the repositories mentioned in repo_list on stage
        :param repo_list: list containing the repositories
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------JenkinsRelease release_on_stage ----------------------------------------")
        secret_suffix_stage = self.secret_suffix_stage
        for repo in repo_list:
            self.invoke_jenkins_job(repo + secret_suffix_stage)

    def release_on_prod(self, repo_list):
        """
        release_on_prod : to release the repositories mentioned in repo_list to PROD enviroment
        :param repo_list: list containing the repositories
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------JenkinsRelease release_on_prod ----------------------------------------")
        secret_suffix_prod = self.secret_suffix_prod
        for repo in repo_list:
            self.invoke_jenkins_job(repo + secret_suffix_prod)

    def release_on_dev(self, repo_list):
        """
        release_on_dev : to release the repositories mentioned in repo_list to DEV environment
        :param repo_list: list containing the repositories
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------JenkinsRelease release_on_dev ----------------------------------------")
        secret_suffix_dev = self.secret_suffix_dev
        for repo in repo_list:
            self.invoke_jenkins_job(repo + secret_suffix_dev)





jenkins_tasks_obj = JenkinsRelease(CONSTANT_JENKINS_SUFFIX_SECRET_DEV, CONSTANT_JENKINS_SUFFIX_SECRET_STAGE, CONSTANT_JENKINS_SUFFIX_SECRET_PROD, CONSTANT_JENKINS_WEBHOOK_QUERY_URL)
