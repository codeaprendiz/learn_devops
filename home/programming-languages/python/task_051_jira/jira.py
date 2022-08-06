import logging
from jira.client import JIRA
from jira import JIRAError

"""
########################################################################################################################################################
# CONSTANT_JIRA_TOKEN : JIRA token required for authentication with the JIRA server
########################################################################################################################################################
"""
CONSTANT_JIRA_TOKEN = ""

"""
########################################################################################################################################################
# CONSTANT_JIRA_SERVER_ADDRESS : JIRA server address
########################################################################################################################################################
"""
CONSTANT_JIRA_SERVER_ADDRESS = "https://mycompany.atlassian.net"


"""
########################################################################################################################################################
# CONSTANT_JIRA_EMAIL_ADDRESS : JIRA email address associated with the account
########################################################################################################################################################
"""
CONSTANT_JIRA_EMAIL_ADDRESS = "admin@mycompany.com"

class JIRATasks(object):
    """

    """
    api_token = ""
    server_address = ""
    basic_auth_email = ""
    jira = None

    def __init__(self, jira_token, jira_server_address, jira_basic_auth_email):
        logging.info("----------------------INFO---------------------------------------------------- CONSTRUCTOR JIRA-------------------------------")
        self.api_token = jira_token
        self.server_address = jira_server_address
        self.basic_auth_email = jira_basic_auth_email
        try:
            self.jira = JIRA(options={'server': self.server_address},
                             basic_auth=(self.basic_auth_email, self.api_token))
        except JIRAError as e:
            logging.info("Caught JIRAError Exception : " + e.text)
        except Exception as e:
            logging.info("Caught Exception : " + e.__doc__)
            logging.info("Exception occurred while the creation of JIRA object. Exiting!!!!!!!")
            raise SystemExit(e)

    def get_issue_title(self, issue_id):
        issue_title = "Ticket Not Found"
        try:
            issue = self.jira.issue(issue_id)
            for field_name in issue.raw['fields']:
                if field_name == 'summary':
                    issue_title = issue.raw['fields'][field_name]
        except JIRAError as e:
            logging.info("Caught JIRAError Exception : " + e.text)
            logging.info("Exception was raised by the issue_id :" + issue_id)

        return issue_title

    def get_issue_status(self, issue_id):
        """
        get_issue_status: The function would take the issue_id as an argument and then return the status of the JIRA ticket
        :param issue_id: The ticket number string
        :return: The status of the JIRA ticket
        """
        issue_status = "Status Not Found"
        try:
            issue = self.jira.issue(issue_id)
            if 'fields' in issue.raw:
                if 'status' in issue.raw['fields']:
                    if 'name' in issue.raw['fields']['status']:
                        issue_status = issue.raw['fields']['status']['name']
        except JIRAError as e:
            logging.info("Caught JIRAError Exception: " + e.text)
            logging.info("The exception was cause by " + str(issue_id))
        return issue_status

    def get_issue_status_from_link(self, jira_link):
        """
        get_issue_status_from_link:
        :param jira_link:
        :return:
        """
        jira_id = jira_link.replace("https://mycompany.atlassian.net/browse/", "")
        return self.get_issue_status(jira_id)

    def get_title_from_jira_links(self, jira_link_list):
        jira_title = []
        # https://mycompany.atlassian.net/browse/BT-9
        for link in jira_link_list:
            jira_id = link.replace("https://mycompany.atlassian.net/browse/", "")
            jira_title.append(self.get_issue_title(jira_id))
        return jira_title


jira_object = JIRATasks(CONSTANT_JIRA_TOKEN, CONSTANT_JIRA_SERVER_ADDRESS, CONSTANT_JIRA_EMAIL_ADDRESS)


