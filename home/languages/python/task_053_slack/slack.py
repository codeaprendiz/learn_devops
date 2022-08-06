from slack import WebClient
from slack.errors import SlackApiError
import logging


"""
########################################################################################################################################################
# CONSTANT_SLACK_CHANNEL : The slack channel name where the updates would be sent
########################################################################################################################################################
"""

CONSTANT_LOGGING_SLACK_CHANNEL = "test-private"

"""
########################################################################################################################################################
# CONSTANT_SLACK_TOKEN : Slack token required to send msg to any given channel
# https://howchoo.com/python/python-send-slack-messages-slackclient
# https://api.slack.com/reference/surfaces/formatting
########################################################################################################################################################
"""
CONSTANT_SLACK_TOKEN = "iaminvalidtokenabcd-203458234085-09234852039845-alskdfk20934lksdjf09r"

class SlackClass(object):
    """
    ########################################################################################################################################################
    # SLACK CLASS
    #  --> Contains methods to send slack messages to slack channel in different formats
    ########################################################################################################################################################
    """
    slack_token = ""
    channel_name = ""
    client = None

    def __init__(self, channel_name, slack_token):
        logging.info("---------------- INFO ---------------------------------------------SLACKCLASS constuctor ------------------------------------------------ ")
        self.channel_name = channel_name
        self.slack_token = slack_token
        self.client = WebClient(token=self.slack_token)

    def update_on_slack_channel_neutral(self, message):
        """
        update_on_slack_channel_neutral : Will be used to give neutral message on slack channel
        :param message: The message to be conveyed
        :return: None
        """
        logging.info("---------------- INFO ---------------------------------------------SLACKCLASS update_on_slack_channel_neutral ------------------------------------------------ ")
        try:
            self.client.chat_postMessage(
                channel=self.channel_name,
                attachments=[
                    {
                        "color": "#FF8C00",
                        "text": message,
                    }
                ]
            )
        except SlackApiError as e:
            print(e.response["error"])
            assert e.response["error"]  # str

    # https://api.slack.com/reference/messaging/attachments
    def update_on_slack_channel_success(self, message):
        """
        update_on_slack_channel_success : To give success message on the slack channel
        :param message: The message to be conveyed
        :return:None
        """
        logging.info("---------------- INFO ---------------------------------------------SLACKCLASS update_on_slack_channel_neutral ------------------------------------------------ ")
        try:
            self.client.chat_postMessage(
                channel=self.channel_name,
                attachments=[
                    {
                        "color": "#36a64f",
                        "text": message,
                    }
                ]
            )
        except SlackApiError as e:
            print(e.response["error"])
            assert e.response["error"]  # str

    def update_on_slack_channel_failure(self, message):
        """
        update_on_slack_channel_success : To give success message on the slack channel
        :param message: The message to be conveyed
        :return:None
        """
        logging.info("---------------- INFO ---------------------------------------------SLACKCLASS update_on_slack_channel_neutral ------------------------------------------------ ")
        try:
            self.client.chat_postMessage(
                channel=self.channel_name,
                attachments=[
                    {
                        "color": "#FF0000",
                        "text": message,
                    }
                ]
            )
        except SlackApiError as e:
            print(e.response["error"])
            assert e.response["error"]  # str

    def update_on_slack_channel(self, message):
        """
        update_on_slack_channel : Used to update on the slack channel
        :param message: The message to be converyed to the slack channel
        :return: None
        """
        logging.info("---------------- INFO ---------------------------------------------SLACKCLASS update_on_slack_channel_neutral ------------------------------------------------ ")
        try:
            self.client.chat_postMessage(
                channel=self.channel_name,
                blocks=[
                    {
                        "type": "section",
                        "text": {
                            "type": "mrkdwn",
                            "text": message,
                        }
                    }
                ]
            )
        except SlackApiError as e:
            print(e.response["error"])
            assert e.response["error"]  # str


slack_logging_class_obj = SlackClass(CONSTANT_LOGGING_SLACK_CHANNEL, CONSTANT_SLACK_TOKEN)
