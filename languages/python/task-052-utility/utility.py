import datetime
from datetime import datetime
import time
import requests
import logging
import base64

"""
########################################################################################################################################################
# MODULE_LISTS
########################################################################################################################################################
"""
CONSTANT_BACKEND_MODULES_LIST = []
CONSTANT_FRONTEND_MODULES_LIST = []
CONSTANT_CLI_LIST = []
CONSTANT_MODULE_LIST_ALL = []

"""
########################################################################################################################################################
# CONSTANT_15_SECONDS : Number of seconds as constant for easier understanding of logic
########################################################################################################################################################
"""
CONSTANT_15_SECONDS = 15  # 10 * 60  # 15 # testing value
CONSTANT_30_SECONDS = 30
CONSTANT_60_MINUTES_TO_SECONDS = 60 * 60  # * 24
CONSTANT_1_MINUTE_TO_SECONDS = 60
CONSTANT_3_MINUTE_TO_SECONDS = 4 * 60
CONSTANT_30_MINUTES_TO_SECONDS = 30 * 60
CONSTANT_10_MINUTES_TO_SECONDS = 10 * 60
CONSTANT_15_MINUTES_TO_SECONDS = 15 * 60
CONSTANT_45_MINUTES_TO_SECONDS = 45 * 60
CONSTANT_24_HOURS_TO_SECONDS = 24 * 60 * 60


"""
########################################################################################################################################################
# VAR_TIME_ONE_LAST_CHECK : base timestamp when the last check was done to check if 15 seconds have passed/ 15 mins have passed / 1 mins has passed
########################################################################################################################################################
"""
VAR_TIME_ONE_LAST_CHECK = time.time()
VAR_TIME_ON_LAST_CHECK_15_MINS = time.time()
VAR_TIME_ON_LAST_CHECK_1_MINS = time.time()

class Utility(object):
    """
    ########################################################################
    #  UTILITY CLASS
    # --> This will contain the Utility functions
    ########################################################################
    """

    @staticmethod
    def set_application_list(input_string):
        """
        set_application_list : The function would take the list of repositories separated comma as argument and set the global variable accordingly
        :param input_string: The list of repositories separated by comma
        :return: Only sets the global variables as per the input
        """
        global CONSTANT_MODULE_LIST_ALL
        global CONSTANT_FRONTEND_MODULES_LIST
        global CONSTANT_BACKEND_MODULES_LIST
        global CONSTANT_CLI_LIST
        CONSTANT_MODULE_LIST_ALL = input_string.split(",")
        for repo_name in CONSTANT_MODULE_LIST_ALL:
            if "web-app" in repo_name:
                CONSTANT_FRONTEND_MODULES_LIST.append(repo_name)
            elif "module-app" in repo_name or "tool-app" in repo_name:
                CONSTANT_BACKEND_MODULES_LIST.append(repo_name)

    @staticmethod
    def set_application_lists_using_encoded(base64_input):
        # base64_input = sys.argv[3]
        base64_bytes = base64_input.encode('ascii')
        input_bytes = base64.b64decode(base64_bytes)
        applications = input_bytes.decode('ascii')
        # Format the ansible list as python input list
        applications = applications.replace("[", "").replace("]", "").replace("\n", "")
        applications = applications.split(', ')

        # Add application names to the lists
        for app in applications:
            app = app.replace('"', '')
            CONSTANT_MODULE_LIST_ALL.append(app)
            if "web" in app:
                CONSTANT_FRONTEND_MODULES_LIST.append(app)
            elif "module" in app or "cli" in app or "tool" in app:
                CONSTANT_BACKEND_MODULES_LIST.append(app)

        logging.info("All Applications List")
        logging.info(CONSTANT_MODULE_LIST_ALL)
        logging.info("All Frontend Applications List")
        logging.info(CONSTANT_FRONTEND_MODULES_LIST)
        logging.info("All Backend Applications List")
        logging.info(CONSTANT_BACKEND_MODULES_LIST)

    @staticmethod
    def time_now():
        logging.info("---------------- INFO ---------------------------------------------UTILITY time_now ------------------------------------------------ ")
        """
        time_now : will return the current time on the system
        :return: return the current timestamp on the system
        """
        return time.time()

    @staticmethod
    def is_30_seconds_passed():
        """
        is_30_seconds_passed : to check if 30 seconds have passed since the last time the function was called
        :return: True or False
        """
        logging.info("---------------- INFO ---------------------------------------------UTILITY is_30_seconds_passed ------------------------------------------------ ")
        global VAR_TIME_ONE_LAST_CHECK
        now = Utility.time_now()
        if now - VAR_TIME_ONE_LAST_CHECK > CONSTANT_30_SECONDS:
            VAR_TIME_ONE_LAST_CHECK = now
            return True
        else:
            return False

    @staticmethod
    def is_1_min_passed():
        """
        is_1_min_passed : to check if 1 minute has passed since the last time the function was called
        :return: True or False
        """
        logging.info("---------------- INFO ---------------------------------------------UTILITY is_1_min_passed ------------------------------------------------ ")
        global VAR_TIME_ON_LAST_CHECK_1_MINS
        now = Utility.time_now()
        if now - VAR_TIME_ON_LAST_CHECK_1_MINS > CONSTANT_1_MINUTE_TO_SECONDS:
            VAR_TIME_ON_LAST_CHECK_1_MINS = now
            return True
        else:
            return False

    @staticmethod
    def is_15_mins_passed():
        """
        is_15_mins_passed : to check if 15 minutes have passed since the last time the function was called
        :return: True or False
        """
        logging.info("---------------- INFO ---------------------------------------------UTILITY is_15_mins_passed ------------------------------------------------ ")
        global VAR_TIME_ON_LAST_CHECK_15_MINS
        now = Utility.time_now()
        if now - VAR_TIME_ON_LAST_CHECK_15_MINS > CONSTANT_15_MINUTES_TO_SECONDS:
            VAR_TIME_ON_LAST_CHECK_15_MINS = now
            return True
        else:
            return False

    @staticmethod
    def time_now_utc():
        """
        time_now_utc : to return the current UTC time
        :return: the current UTC time
        """
        logging.info("---------------- INFO ---------------------------------------------UTILITY time_now_utc ------------------------------------------------ ")
        return datetime.utcnow()

    @staticmethod
    def time_difference(date_a, date_b):
        """
        time_difference: to return the time difference between two date objects
        :param date_a: first date object
        :param date_b: second date object
        :return: the time difference in seconds between first and second data object
        """
        logging.info("---------------- INFO ---------------------------------------------UTILITY time_difference ------------------------------------------------ ")
        return (date_b - date_a).total_seconds()

    @staticmethod
    def get_environment(branch):
        """
        get_environment : the function takes the branch name as argument and returns the corresponding environment
        :param branch: the branch name in consideration
        :return: String environment name
        """
        logging.info("---------------- INFO ---------------------------------------------UTILITY get_environment ------------------------------------------------ ")
        if branch == "develop":
            return "dev"
        elif branch == "stage":
            return "stage"
        elif branch == "master":
            return "prod"
        else:
            print("Wrong branch name provided. Exiting!!!!!!")
            exit(0)

    @staticmethod
    def get_base_branch(branch):
        """
        get_base_branch : returns the base branch for any given branch.
                          Like the base branch for stage is develop.
                          The base branch for master is stage
        :param branch: the branch in consideration
        :return: String, the base branch
        """
        if branch == "develop":
            return "develop"
        elif branch == "stage":
            return "develop"
        elif branch == "master":
            return "stage"

    @staticmethod
    def show_usage():
        """
        show_usage : The function shows the usage of the script.
        :return:
        """
        print("Usage python3 deploy.py <branch_name> <action> <base64 list of applications>")
        print("Example 1 : Sending mail for the stage branch")
        print("python3 deploy.py stage sendemail <base64 list of applications>")
        print("Example 2 : python3 Sending mail for the master branch")
        print("python3 deploy.py master sendemail <base64 list of applications>")
        print("Example 3 : Do a deployment on the stage branch")
        print("python3 deploy.py stage deploy <base64 list of applications>")
        print("Example 4 : Do a deployment on the master branch")
        print("python3 deploy.py master deploy <base64 list of applications>")
        print("Example 5 : To test a single functionality")
        print("python3 deploy.py stage test <base64 list of applications>")

    @staticmethod
    def write_release_state_to_file(table_data):
        """
        write_release_state_to_file :
        :param table_data:
        :return:
        """
        logging.info("---------------- INFO ---------------------------------------------Utility write_release_state_to_file ------------------------------------------------ ")
        logging.info(table_data.get_json_string())
        f = open("statefile.json", "w")
        f.write(table_data.get_json_string())
        f.close()

    @staticmethod
    def invoke_http_request(query_url, headers, params):
        logging.info("----------------------INFO----------------------------------------------------Utility.invoke_http_request-------------------------------")
        if bool(headers) and bool(params):     # if headers dictionary is non empty AND if params dictionary is non empty
            try:
                response_dict = requests.get(query_url, headers=headers, params=params)
                return response_dict
            except requests.exceptions.HTTPError as e:
                logging.error("Exception requests.exceptions.HTTPError: ", str(e.__doc__))
            except requests.exceptions.ConnectionError as e:
                logging.error("Exception requests.exceptions.ConnectionError: ", str(e.__doc__))
            except requests.exceptions.Timeout as e:
                logging.error("Exception requests.exceptions.Timeout : " + str(e.__doc__))
            except requests.exceptions.TooManyRedirects as e:
                logging.error("Exception requests.exceptions.TooManyRedirects: " + str(e.__doc__))
            except requests.exceptions.RequestException as e:
                logging.error("Exception requests.exceptions.RequestException: " + str(e.__doc__))

        if bool(headers) and not bool(params):  # if headers dict is non empty AND if params dict is emtpy
            try:
                response_dict = requests.get(query_url, headers=headers)
                return response_dict
            except requests.exceptions.HTTPError as e:
                logging.error("Exception requests.exceptions.HTTPError: ", str(e.__doc__))
            except requests.exceptions.ConnectionError as e:
                logging.error("Exception requests.exceptions.ConnectionError: ", str(e.__doc__))
            except requests.exceptions.Timeout as e:
                logging.error("Exception requests.exceptions.Timeout : " + str(e.__doc__))
            except requests.exceptions.TooManyRedirects as e:
                logging.error("Exception requests.exceptions.TooManyRedirects: " + str(e.__doc__))
            except requests.exceptions.RequestException as e:
                logging.error("Exception requests.exceptions.RequestException: " + str(e.__doc__))

        if not bool(headers) and not bool(params):  # if both headers dict and params dict and empty
            try:
                response_dict = requests.get(query_url)
                return response_dict
            except requests.exceptions.HTTPError as e:
                logging.error("Exception requests.exceptions.HTTPError: ", str(e.__doc__))
            except requests.exceptions.ConnectionError as e:
                logging.error("Exception requests.exceptions.ConnectionError: ", str(e.__doc__))
            except requests.exceptions.Timeout as e:
                logging.error("Exception requests.exceptions.Timeout : " + str(e.__doc__))
            except requests.exceptions.TooManyRedirects as e:
                logging.error("Exception requests.exceptions.TooManyRedirects: " + str(e.__doc__))
            except requests.exceptions.RequestException as e:
                logging.error("Exception requests.exceptions.RequestException: " + str(e.__doc__))

        logging.warning("No http method was called. Please check the inputs " + str(query_url) + str(headers) + str(params))
        return None

