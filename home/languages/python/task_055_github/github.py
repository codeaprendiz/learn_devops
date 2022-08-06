import json
# import re
# import datetime
# from datetime import datetime
# import time
# import logging

from github import Github

from prettytable import PrettyTable
from task_052_utility.utility import *
from task_050_emails.emails import *
from task_051_jira.jira import *
from task_053_slack.slack import *
from task_054_SCMRepo.scmrepo import *


"""
########################################################################################################################################################
# CONSTANT_GITHUB_TOKEN : Github token required authenticate for private repositories and execute actions authorized by the token priviledges
########################################################################################################################################################
"""
CONSTANT_GITHUB_TOKEN = ""

"""
########################################################################################################################################################
# CONSTANT_ORGANIZATION_NAME : Github Organization name
########################################################################################################################################################
"""
CONSTANT_ORGANIZATION_NAME = "testorg"


"""
##################################################################
# VAR_ENVIRONMENT_IN_CONSIDERATION
##################################################################
"""

VAR_ENVIRONMENT_IN_CONSIDERATION = ""


CONSTANT_EMAIL_RELEASE_DL = "releaseteam@mycompany.com"
CONSTANT_TEST_DL = "team-ops@mycompany.com"
CONSTANT_FROM_DL = 'ankit.rathi@mycompany.com'

"""
##################################################################
# COLUMN_APPLICATION_DETAILS : The application details column in the email table
##################################################################
"""
COLUMN_APPLICATION_DETAILS = "Application Details"

""" 
##################################################################
# COLUMN_JIRA_LINK : The jira link column in the email table
##################################################################
"""
COLUMN_JIRA_LINKS_AND_PR_DETAILS = "JIRA Link And PR Details"


"""
########################################################################################################################################################
# CONSTANT_BUILD_STATUS_IN_PROGRESS : Github API response keyword for in-progress workflows
########################################################################################################################################################
"""
CONSTANT_BUILD_STATUS_IN_PROGRESS = "in_progress"

"""
########################################################################################################################################################
# CONSTANT_BUILD_STATUS_COMPLETED : Github API response keyword for completed workflows
########################################################################################################################################################
"""
CONSTANT_BUILD_STATUS_COMPLETED = "completed"


"""
########################################################################################################################################################
# CONSTANTS_SCRIPT_START_TIME : At what time the script was started like 1603628003.0897448. This is required to calculate other threshold time limite
#                               like how long should we check for build completion, how long should we check for docker image upload etc
########################################################################################################################################################
"""
CONSTANTS_SCRIPT_START_TIME = time.time()

"""
########################################################################################################################################################
# CONSTANT_BUILD_TRIGGER_WAIT_THRESHOLD_SECONDS : Till what time the script should keep on checking for build trigger
########################################################################################################################################################
"""
CONSTANT_BUILD_TRIGGER_WAIT_THRESHOLD_SECONDS = CONSTANTS_SCRIPT_START_TIME + CONSTANT_30_MINUTES_TO_SECONDS

"""
########################################################################################################################################################
# CONSTANT_BUILD_COMPLETION_THRESHOLD_SECONDS : Till what time the script should keep on checking for build completion
########################################################################################################################################################
"""
## Testing
CONSTANT_BUILD_COMPLETION_THRESHOLD_SECONDS = CONSTANTS_SCRIPT_START_TIME + \
                                              CONSTANT_30_MINUTES_TO_SECONDS
#   CONSTANT_3_MINUTE_TO_SECONDS
"""
########################################################################################################################################################
# CONSTANT_IMAGE_UPLOAD_THRESHOLD_SECONDS : Till what time the script should keep on checking for docker image upload
########################################################################################################################################################
"""
CONSTANT_IMAGE_UPLOAD_THRESHOLD_SECONDS = CONSTANTS_SCRIPT_START_TIME + CONSTANT_45_MINUTES_TO_SECONDS

"""
########################################################################################################################################################
# CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS : Till what time the script should keep on checking if the deployment is completed and changes
                                                     reflected
########################################################################################################################################################
"""
CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS = CONSTANTS_SCRIPT_START_TIME + CONSTANT_45_MINUTES_TO_SECONDS




class GitHubTasks(object):
    """
    ########################################################################
    #  GITHUB CLASS
    # --> This will contain the Github related operations
    ########################################################################
    """
    token = ""
    github_obj = None
    owner = None

    def __init__(self, g_token, g_owner):
        self.token = g_token
        self.github_obj = Github(g_token)
        self.owner = g_owner

    def get_repository_handle(self, repository_name):
        """
        get_repository_handle : the function would give a handle on the repository, using this handle we can fetch informtion about the repo
        :param repository_name: the name of the repository
        :return: handle on the repository
        """
        logging.info("---------------- INFO ---------------------------------------------GITHUBTASKS get_repository_handle ------------------------------------------------ ")
        return self.github_obj.get_repo(repository_name)

    def get_last_commit_time(self, repository_name, page_num):
        """
        get_last_commit_time : The function gives you when the last commit was done to a repository
        :param page_num: page_number for the api call
        :param repository_name: the name of the repository in consideration
        :return: the last commit time
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.get_last_commit_time-------------------------------")
        logging.info("API call for page_number : " + str(page_num))
        created_at = None
        found_commit_time = False
        query_url = f"https://api.github.com/repos/{self.owner}/{repository_name}/events"
        headers = {'Authorization': f'token {self.token}'
                   }
        params = {'page': page_num}

        response_dict = Utility.invoke_http_request(query_url, headers, params)
        index = 0
        json_array = response_dict.json()
        if isinstance(json_array, list):
            while index < len(json_array):
                json_object = json_array[index]
                event_type = json_object['type']
                if event_type == "PushEvent":
                    created_at = json_object['created_at']
                    found_commit_time = True
                    break
                index = index + 1
        logging.info("The time stamp of last commit is " + str(created_at))
        if found_commit_time:
            return created_at
        else:
            created_at = self.get_last_commit_time(repository_name, page_num + 1)
        return created_at

    def get_github_action_workflow_type(self, repository_name, workflow_id):
        """
        get_github_action_workflow_type : To get the workflow type identified by workflow id for any github action
        :param repository_name: the name of the repository in consideration
        :param workflow_id: the workflow id
        :return: String giving type of workflow
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.get_github_action_workflow_type-------------------------------")
        query_url = f"https://api.github.com/repos/{self.owner}/{repository_name}/actions/workflows/{workflow_id}"
        headers = {'Authorization': f'token {self.token}'}
        params = {}
        response_dict = Utility.invoke_http_request(query_url, headers, params)
        json_obj = response_dict.json()
        if "name" in json_obj:
            return json_obj['name']
        else:
            return "None"

    def get_latest_commit_hash(self, repository_name, branch_name):
        """
        get_latest_commit_hash : To get the last commit hash of the commit done on branch branch_name of repository repository_name
        :param repository_name: the repository in consideration
        :param branch_name: the branch name in consideration
        :return: the commit hash string
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.get_latest_commit_hash-------------------------------")
        # https://api.github.com/repos/mycompany/k8s-microservice-account/commits/master
        query_url = f"https://api.github.com/repos/{self.owner}/{repository_name}/commits/{branch_name}"
        headers = {'Authorization': f'token {self.token}'
                   }
        params = {}
        response_dict = Utility.invoke_http_request(query_url, headers, params)
        json_obj = response_dict.json()
        if "sha" in json_obj:
            return json_obj['sha']
        else:
            return "None"

    def get_closed_pr_description(self, repo_name, pr_number, page_number):
        """
        get_closed_pr_description : The function would return the PR description of the PR identified by pr_number
        :param page_number: The page_number for the api-call
        :param repo_name: the repository in consideration
        :param pr_number: the pr number
        :return: String - the description of PR
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.get_closed_pr_description-------------------------------")
        logging.info("Page number being considered " + str(page_number))
        found_pr_description = False
        # https://api.github.com/repos/mycompany/k8s-microservice-backoffice/pulls\?state\=closed
        query_url = f"https://api.github.com/repos/{self.owner}/{repo_name}/pulls"
        headers = {'Authorization': f'token {self.token}'}
        params = {'state': 'closed',
                  'page': page_number,
                  'per_page': 100
                  }
        description = ""
        response_dict = Utility.invoke_http_request(query_url, headers, params)
        json_array = response_dict.json()
        for json_obj in json_array:
            if str(json_obj['number']) == str(pr_number):
                logging.info("PR description of " + str(pr_number) + " is " + str(json_obj['body']))
                description = str(json_obj['body'])
                found_pr_description = True
        if found_pr_description:
            return description
        else:
            description = self.get_closed_pr_description(repo_name, pr_number, page_number + 1)
        return description

    def get_closed_pr_title(self, repo_name, pr_number, page_number):
        """
        get_closed_pr_title : The function would return the PR title when the PR number is passed as an argument
        :param page_number: The page number for the api call
        :param repo_name: The repository in consideration
        :param pr_number: The PR number in consideration
        :return: String denoting the description of the PR
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.get_closed_pr_title-------------------------------")
        logging.info("The page number being considered : " + str(page_number))
        # https://api.github.com/repos/mycompany/k8s-microservice/pulls\?state\=closed
        query_url = f"https://api.github.com/repos/{self.owner}/{repo_name}/pulls"
        headers = {'Authorization': f'token {self.token}'}
        params = {'state': 'closed',
                  'page': page_number,
                  'per_page': 100
                  }
        title = ""
        found_pr_title = False
        response_dict = Utility.invoke_http_request(query_url, headers, params)
        json_array = response_dict.json()
        for json_obj in json_array:
            if 'number' in json_obj:
                if str(json_obj['number']) == str(pr_number):
                    logging.info("The title of PR is : " + str(pr_number) + " is " + str(json_obj['title']))
                    title = str(json_obj['title'])
                    found_pr_title = True
        if found_pr_title:
            return title
        else:
            title = self.get_closed_pr_title(repo_name, pr_number, page_number + 1)
        return title

    def from_last_n_commits_of_branch_return_pr_numbers_for_only_merge_commit(self, repo_name, branch_name, n, page_number):
        """
        from_last_n_commits_of_branch_return_pr_numbers_for_only_merge_commit  : The function would take as number n as input for repository repo_name and branch branch_name. Here n is telling to consider
                                                                                 only last n commits It would return list of PR numbers from those commits which were made as a result of squash and merge
                                                                                 done to branch branch_name
        :param page_number: The page number for the api call
        :param repo_name: the repository in consideration
        :param branch_name: the branch in consideration
        :param n: number of commits to be traversed
        :return: list of PR numbers corresponding to merge commits i.e. PR numbers which were merged by squash and merge
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.from_last_n_commits_of_branch_return_pr_numbers_for_only_merge_commit-------------------------------")
        logging.info("The page number being called " + str(page_number))
        # https://api.github.com/repos/mycompany/k8s-microservice/commits\?sha\=develop
        list_of_pr_numbers = []
        if n == 0:
            return list_of_pr_numbers
        query_url = f"https://api.github.com/repos/{self.owner}/{repo_name}/commits"
        headers = {'Authorization': f'token {self.token}'}
        params = {'sha': branch_name,
                  'page': page_number,
                  'per_page': 100
                  }
        response_dict = Utility.invoke_http_request(query_url, headers, params)
        json_array = response_dict.json()
        iteration = 0
        for json_obj in json_array:
            iteration = iteration + 1
            if iteration == 0:
                break
            message = json_obj['commit']['message']
            logging.info("Commit message " + str(message))
            if "(#" in message:
                # https://www.regextester.com/94730
                # https://stackoverflow.com/questions/4666973/how-to-extract-the-substring-between-two-markers
                match = re.search('(\(\#.*?\))', message)
                if match:
                    logging.info("Matched PR Title " + match.group(1))
                    pr_number_found = match.group(1).split('(#')[1].split(')')[0]
                    list_of_pr_numbers.append(pr_number_found)
                    logging.info("Found PR : " + str(pr_number_found))
            if iteration == n:
                break
        if iteration < n:
            list_of_pr_numbers = list_of_pr_numbers + self.from_last_n_commits_of_branch_return_pr_numbers_for_only_merge_commit(repo_name, branch_name, n - iteration, page_number + 1)
        return list_of_pr_numbers

    @staticmethod
    def prepare_email_from_file_input(filename):
        """
        prepare_email_from_file_input : This function would take the filename as input and then prepare the email to be sent to the Relase DL using the data read from
                                        the file.
        :param filename: The file from which the data is to be read
        :return: will prepare the email content to be sent to the release DL
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.prepare_email_from_file_input-------------------------------")
        file_handle = open(filename, "r")
        data = json.load(file_handle)
        tabular_fields = [COLUMN_JIRA_LINKS_AND_PR_DETAILS, COLUMN_APPLICATION_DETAILS]
        tabular_table = PrettyTable()
        tabular_table.field_names = tabular_fields
        for data_object in data:
            if not isinstance(data_object, list):
                application_details_column_data = data_object[COLUMN_APPLICATION_DETAILS]
                jira_link_column_data = data_object[COLUMN_JIRA_LINKS_AND_PR_DETAILS]
                tabular_table.add_row([jira_link_column_data, application_details_column_data])
        file_handle.close()
        email_object = Email(CONSTANT_SMTP_HOST, CONSTANT_SMTP_PORT, CONSTANT_SMTP_USERNAME, CONSTANT_SMTP_PASSWORD)
        subject_of_email = "Notification : Auto " + VAR_ENVIRONMENT_IN_CONSIDERATION + " Deployment " + str(datetime.today().strftime('%Y-%m-%d-%H:%M:%S'))
        email_object.send_email(
            # CONSTANT_EMAIL_RELEASE_DL
            CONSTANT_TEST_DL
            , CONSTANT_FROM_DL, subject_of_email, "", tabular_table)

    def prepare_email_content(self, repo_list, branch_name):
        """
          prepare_email_content : The function is used to prepare the email content that will be sent to DLs
          :param repo_list: The list of repositories which need to be considered
          :param branch_name: The branch name in consideration
          :return: Email content string
          """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.prepare_email_content-------------------------------")
        jira_object = JIRATasks(CONSTANT_JIRA_TOKEN, CONSTANT_JIRA_SERVER_ADDRESS, CONSTANT_JIRA_EMAIL_ADDRESS)
        tabular_fields = [COLUMN_JIRA_LINKS_AND_PR_DETAILS, COLUMN_APPLICATION_DETAILS]
        tabular_table = PrettyTable()
        tabular_table.field_names = tabular_fields

        for repo in repo_list:
            email_content = ""
            logging.info("Repo : " + str(repo))
            scm_obj = SCMRepo(repo, "/tmp/workspace")
            number_of_commits_to_traverse = int(scm_obj.git_rev_list(Utility.get_base_branch(branch_name))) - int(scm_obj.git_rev_list(branch_name))
            if number_of_commits_to_traverse < 0:
                number_of_commits_to_traverse = 0
            ## Testing
            # number_of_commits_to_traverse = 10
            logging.info("number of commits to traverse : " + str(number_of_commits_to_traverse))
            pr_numbers_to_check = self.from_last_n_commits_of_branch_return_pr_numbers_for_only_merge_commit(repo, Utility.get_base_branch(branch_name), number_of_commits_to_traverse, 1)
            pr_links_string = ""
            for pr in pr_numbers_to_check:
                pr_links_string = pr_links_string + " https://github.com/mycompany/" + repo + "/pull/" + str(pr) + "/files " + str(self.get_closed_pr_title(repo, pr, 1)) + "\n"
            logging.info("PR numbers to check " + str(pr_numbers_to_check))
            if len(pr_numbers_to_check) > 0:
                for pr_number in pr_numbers_to_check:
                    logging.info("PR number " + str(pr_number))
                    pr_desc = self.get_closed_pr_description(repo, pr_number, 1)
                    jira_links = GitHubTasks.parse_jira_link(pr_desc)
                    if len(jira_links) > 0:
                        index = 0
                        jira_title_list = jira_object.get_title_from_jira_links(jira_links)
                        jira_title_string = ""

                        for ticket_title in jira_title_list:
                            if index >= 1:
                                jira_title_string = jira_title_string + "\n"
                            link_to_jira = jira_links[index]
                            ticket_status = jira_object.get_issue_status_from_link(link_to_jira)
                            jira_title_string = jira_title_string + link_to_jira + " " + " (" + ticket_status + ") " + ticket_title
                            index = index + 1
                        email_content = email_content + "\n" + str(jira_title_string)
            if email_content != "":
                application_details_column_data = "Repo: https://github.com/mycompany/" + repo + " \n" + \
                                                  " Github Diff : https://github.com/mycompany/" + repo + "/compare/" + str(self.get_latest_commit_hash(repo, branch_name))[0:7] + "..." + \
                                                  str(self.get_latest_commit_hash(repo, Utility.get_base_branch(branch_name)))[0:7] + " "
                # https://github.com/mycompany/www/compare/abee93471aac1a27e2cc19f701e6c2d48b68...663527f8b046a301ae3fbbad04868ab4c32
                jira_link_column_data = "Jira tasks:" + email_content + "\n\nGitHub pull requests:\n" + pr_links_string

                tabular_table.add_row([jira_link_column_data, application_details_column_data])
                # tabular_table.add_row(
                #   [datetime.today().strftime('%Y-%m-%d'), repo, application_type, email_content, str(self.get_latest_commit_hash(repo, Utility.get_base_branch(branch_name)))[0:7], str(self.get_latest_commit_hash(repo, branch_name))[0:7],
                #    pr_links_string])
        email_object = Email(CONSTANT_SMTP_HOST, CONSTANT_SMTP_PORT, CONSTANT_SMTP_USERNAME, CONSTANT_SMTP_PASSWORD)
        subject_of_email = "Notification : Auto " + VAR_ENVIRONMENT_IN_CONSIDERATION + " Deployment " + str(datetime.today().strftime('%Y-%m-%d-%H:%M:%S'))
        ## Testing : Replace the RELEASE DL with the TEST DL to test the email notifications
        Utility.write_release_state_to_file(tabular_table)
        email_object.send_email(
            # CONSTANT_EMAIL_RELEASE_DL
            CONSTANT_TEST_DL
            , CONSTANT_FROM_DL, subject_of_email, "", tabular_table)

    @staticmethod
    def parse_jira_link(pr_desc):
        """
        parse_jira_link : This function takes the PR description as an argument and parses the JIRA link from the same.
        :param pr_desc:
        :return:
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.parse_jira_link-------------------------------")
        all_links = re.findall(CONSTANT_URL_REGEX, pr_desc)
        jira_links = []
        for link in all_links:
            logging.info("Considering link " + str(link))
            if "mycompany.atlassian.net" in link:
                jira_links.append(link)
        if len(jira_links) > 0:
            return jira_links
        return []

    @staticmethod
    def get_application_type(repository_name):
        """
        get_application_type : the function returns the application type of a given github repository given as argument like if it is Frontend or API
        :param repository_name: the name of the repository in consideration
        :return: String denoting the type of application
        """
        if "web" in repository_name:
            return "Frontend"
        if "k8s-microservice" in repository_name:
            return "API"
        return "None"

    def is_build_in_progress(self, repository_name, branch_name):
        """
        is_build_in_progress : The function tells you whether the build for repository repository_name of branch branch_name is in progress or not
        :param repository_name: the repository in consideration
        :param branch_name: branch name in consideration
        :return: True of False
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.is_build_in_progress-------------------------------")
        query_url = f"https://api.github.com/repos/{self.owner}/{repository_name}/actions/runs"
        headers = {'Authorization': f'token {self.token}'
                   }
        status = ""
        params = {}
        response_dict = Utility.invoke_http_request(query_url, headers, params)
        index = 0
        json_array = []
        if 'workflow_runs' in response_dict.json():
            json_array = response_dict.json()['workflow_runs']
        while index < len(json_array):
            json_obj = json_array[index]
            event = json_obj['event']
            workflow_id = json_obj['workflow_id']
            workflow_type = self.get_github_action_workflow_type(repository_name, workflow_id)
            if event != "push" and workflow_type != "build-docker-image":
                index = index + 1
                continue
            head_branch = json_obj['head_branch']
            created_at = json_obj['created_at']  # 2020-10-15T08:19:04Z
            date_object = datetime.strptime(created_at, "%Y-%m-%dT%H:%M:%SZ")
            time_diff = Utility.time_difference(date_object, Utility.time_now_utc())
            status = json_obj['status']
            if event == "push" and head_branch == branch_name:
                break
            index = index + 1
        if str(status) == str(CONSTANT_BUILD_STATUS_IN_PROGRESS):
            if time_diff > CONSTANT_30_MINUTES_TO_SECONDS:
                return False
            else:
                print("Build for " + str(repository_name) + " is still in progress")
                return True
        return False

    def is_build_state_reached(self, repository_name, branch_name, req_status, req_conclusion):
        """
        is_build_state_reached : The function tells you whether the build for repository repository_name of branch branch_name is completed or not
        :param repository_name: the repository in consideration
        :param branch_name: the branch in consideration
        :param req_status: the required status is "COMPLETED" when the build is in completed state
        :param req_conclusion: the required conclusion state like success or failure
        :return: True or False
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.is_build_state_reached-------------------------------")
        if self.is_build_in_progress(repository_name, branch_name):
            return False
        query_url = f"https://api.github.com/repos/{self.owner}/{repository_name}/actions/runs"
        headers = {'Authorization': f'token {self.token}'
                   }
        params = {}
        response_dict = Utility.invoke_http_request(query_url, headers, params)
        index = 0
        status = ""
        time_diff = 0
        json_array = []
        if 'workflow_runs' in response_dict.json():
            json_array = response_dict.json()['workflow_runs']
        while index < len(json_array):
            json_obj = json_array[index]
            event = json_obj['event']
            workflow_id = json_obj['workflow_id']
            workflow_type = self.get_github_action_workflow_type(repository_name, workflow_id)
            if event != "push" and workflow_type != "build-docker-image":
                index = index + 1
                continue
            status = json_obj['status']
            conclusion = json_obj['conclusion']
            head_branch = json_obj['head_branch']
            created_at = json_obj['created_at']  # 2020-10-15T08:19:04Z
            date_object = datetime.strptime(created_at, "%Y-%m-%dT%H:%M:%SZ")
            time_diff = Utility.time_difference(date_object, Utility.time_now_utc())
            ## If you find a success build but it was done more than 30 mins ago
            if status == "completed" and conclusion == "success":
                if time_diff > CONSTANT_30_MINUTES_TO_SECONDS:
                    print("Build not completed in last " + str(CONSTANT_30_MINUTES_TO_SECONDS) + " seconds for " + repository_name)
                    return False
            if status == CONSTANT_BUILD_STATUS_IN_PROGRESS:
                print("Build is in progress for " + repository_name)
            if event == "push" and head_branch == branch_name:
                break
            index = index + 1
        if status == req_status and conclusion == req_conclusion and head_branch == branch_name and time_diff < CONSTANT_30_MINUTES_TO_SECONDS:
            return True
        else:
            logging.info(str(repository_name) + " build state " + req_conclusion + " NOT REACHED in last " + str(time_diff / 60) + " mins")
            return False

    def is_all_builds_completed(self, repo_list, branch_name):
        """
        is_all_builds_completed : The function takes repository list as argument and checks if the builds are in completed for each of those repositories
        :param repo_list: the list of repositories to be considered
        :param branch_name: the branch name in consideration
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------GITHUBTASKS.is_all_builds_completed-------------------------------")
        flag_check_for_commit_hash = False
        slack_logging_class_obj = SlackClass(CONSTANT_LOGGING_SLACK_CHANNEL, CONSTANT_SLACK_TOKEN)
        slack_logging_class_obj.update_on_slack_channel("----------------------INFO----------------------------------------------------GITHUBTASKS.is_all_builds_completed-------------------------------")
        slack_class_obj = SlackClass(CONSTANT_LOGGING_SLACK_CHANNEL, CONSTANT_SLACK_TOKEN)
        slack_class_obj.update_on_slack_channel("\n *Auto - Release updates for environment " + branch_name + "* \n")
        index = 0
        slack_message = ""
        while len(repo_list) > 0 and Utility.time_now() < CONSTANT_BUILD_COMPLETION_THRESHOLD_SECONDS:
            logging.info(str(Utility.time_now()) + " ----------->  " + str(CONSTANT_BUILD_COMPLETION_THRESHOLD_SECONDS))
            logging.info("Repo List status " + str(repo_list))
            slack_logging_class_obj.update_on_slack_channel("Build remaining for " + str(repo_list) + "\n" + str(Utility.time_now()) + " ----------->  " + str(CONSTANT_BUILD_COMPLETION_THRESHOLD_SECONDS))
            repo_name = repo_list[index]
            if self.is_build_state_reached(repo_name, branch_name, "completed", "success"):
                print("SUCCESS - Repository : " + repo_name + " build completed")
                slack_message = slack_message + "\n" + "`SUCCESS` - Repository : `" + str(repo_name) + "` branch `" + branch_name + "` build completed"
                del repo_list[index]
                if len(repo_list) == 0:
                    break
            if self.is_build_state_reached(repo_name, branch_name, "completed", "failure"):
                print("FAILURE - Repository : " + repo_name + " build failed")
                slack_class_obj.update_on_slack_channel_failure("\n" + "`FAILURE` - Repository : `" + str(repo_name) + "` branch `" + branch_name + "` build failed")
                del repo_list[index]
                if len(repo_list) == 0:
                    break
            ## Testing: is_1_min_passed, Actual: is_15_mins_passed()
            if Utility.is_15_mins_passed():
                flag_check_for_commit_hash = True
            if flag_check_for_commit_hash:
                if str(self.get_latest_commit_hash(repo_name, branch_name)) == str(self.get_latest_commit_hash(repo_name, Utility.get_base_branch(branch_name))) and not self.is_build_in_progress(repo_name, branch_name):
                    print("No Build required for " + str(repo_name) + ". No new commits " + str(self.get_latest_commit_hash(repo_name, branch_name)) + " and " + str(self.get_latest_commit_hash(repo_name, Utility.get_base_branch(branch_name))))
                    slack_message = slack_message + "\n" + "Build `NOT REQUIRED` required for `" + str(repo_name) + "` . No new commits "
                    print(repo_list)
                    print(index)
                    del repo_list[index]
                    if len(repo_list) == 0:
                        break
            if Utility.is_30_seconds_passed():
                if slack_message != "":
                    slack_class_obj.update_on_slack_channel(slack_message)
                    slack_message = ""
            index = index + 1
            if index >= len(repo_list):
                index = 0
        if slack_message != "":
            slack_class_obj.update_on_slack_channel(slack_message)
        if len(repo_list) != 0:
            slack_class_obj.update_on_slack_channel("\n Build was not triggered for following repositories. Maybe the " + branch_name + " was already reset to the target state. Please check")
            for repo_name in repo_list:
                slack_class_obj.update_on_slack_channel("\n `" + repo_name + "`")
        global CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS
        ## Testing
        CONSTANT_DEPLOYMENT_VALIDATION_THRESHOLD_SECONDS = time.time() + \
                                                           CONSTANT_10_MINUTES_TO_SECONDS
        #  CONSTANT_3_MINUTE_TO_SECONDS

    @staticmethod
    def send_final_email_after_deployment(repo_and_deployed_sha):
        """
        send_final_email_after_deployment : this functions will send the final email by consolidating the details that have been gathered in a file and other details like
                                            deployed sha of images
        :param repo_and_deployed_sha: the dictionary of repositories and the corresponding deployed images
        :return: send the final email with all the info which is required
        """
        logging.info("---------------- INFO ---------------------------------------------GitHubTasks send_final_email_after_deployment ------------------------------------------------ ")
        f = open("statefile.json", "r")
        data = json.load(f)
        index = 0
        for data_object in data:
            if not isinstance(data_object, list):
                application_details_string = data_object[COLUMN_APPLICATION_DETAILS]
                all_links = re.findall(CONSTANT_URL_REGEX, application_details_string)
                repo_name = all_links[0].split("/")[-1]
                if repo_name in repo_and_deployed_sha:
                    deployed_image_sha = repo_and_deployed_sha[repo_name]
                    data[index][COLUMN_APPLICATION_DETAILS] = data[index][COLUMN_APPLICATION_DETAILS] + "\n" + "Docker Image SHA: " + str(deployed_image_sha)
            index = index + 1
        f.close()
        with open('updated.json', 'w', encoding='utf-8') as file:
            json.dump(data, file, ensure_ascii=False, indent=4)
        GitHubTasks.prepare_email_from_file_input("updated.json")

github_task_obj = GitHubTasks(CONSTANT_GITHUB_TOKEN, CONSTANT_ORGANIZATION_NAME)
