import logging
import re
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

"""
# CONSTANT_URL_REGEX : Regular expression for finding URL in strings
# https://stackoverflow.com/questions/839994/extracting-a-url-in-python
"""
CONSTANT_URL_REGEX = r"\b((?:https?://)?(?:(?:www\.)?(?:[\da-z\.-]+)\.(?:[a-z]{2,6})|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:(?:[0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(?:ffff(?::0{1,4}){0,1}:){0,1}(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])))(?::[0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])?(?:/[\w\.-]*)*/?)\b"

"""
########################################################################################################################################################
# SMTP Related Constants required for automated emails
# Elastic Emails - https://help.elasticemail.com/en/articles/2446055-what-are-sending-limits-for-new-account
########################################################################################################################################################
"""

CONSTANT_SMTP_HOST = "smtp.somedomain.com"
CONSTANT_SMTP_PORT = "2525"
CONSTANT_SMTP_USERNAME = "ankit.rathi@mycompany.com"
CONSTANT_SMTP_PASSWORD = "somepassword"

class Email(object):
    """
    ########################################################################################################################################################
    # Email CLASS
    #  --> Contains methods to send email messages to different DLs
    ########################################################################################################################################################
    """
    smtp_host = ""
    smtp_port = ""
    smtp_username = ""
    smtp_password = ""
    server = None

    def __init__(self, host, port, username, password):
        logging.info("----------------------INFO---------------------------------------------------- CONSTRUCTOR Email-------------------------------")
        logging.info("")
        self.smtp_host = host
        self.smtp_port = port
        self.smtp_username = username
        self.smtp_password = password
        try:
            self.server = smtplib.SMTP(self.smtp_host, self.smtp_port)
            self.server.starttls()
            self.server.login(self.smtp_username, self.smtp_password)
        except smtplib.SMTPException as e:
            logging.info("Caught smtplib.SMTPException while creating object of Email class: " + str(e.__doc__))
            logging.info("Exiting!!!")
            raise SystemExit(e)
        except Exception as e:
            print("Caught Exception while creating object of Email class: " + str(e.__doc__))
            print("Exiting!!!")
            raise SystemExit(e)

    @staticmethod
    def return_body_string():
        """
        return_body_string : The function returns the body string used in the email sent to DLs
        :return: the body string content which will be sent to DLs
        """
        logging.info("----------------------INFO------------------------------------------------------return_body_string-----------------------------")
        body_string = """
      Hi Team, <br><br>
      Please find the change log for the automated release: <br>

      """

        return body_string

    @staticmethod
    def return_style_css_string():
        """
        return_style_css_string : The function would return the CSS string which will be used in the HTML format email sent the DLs
        :return: the CSS string used in HTML format email sent to the DLs
        """
        logging.info("----------------------INFO------------------------------------------------------return_body_string-----------------------------")
        css_string = """
    <style type="text/css">
      table {
        background: white;
        border-radius:3px;
        border-collapse: collapse;
        height: auto;
        max-width: 900px;
        padding:5px;
        width: 100%;
        animation: float 5s infinite;
      }
      th {
        color:#D5DDE5;;
        background:#1b1e24;
        border-bottom: 4px solid #9ea7af;
        font-size:14px;
        font-weight: 300;
        padding:10px;
        text-align:center;
        vertical-align:middle;
        width:250px;
      }
      tr {
        border-top: 1px solid #C1C3D1;
        border-bottom: 1px solid #C1C3D1;
        border-left: 1px solid #C1C3D1;
        color:#666B85;
        font-size:16px;
        font-weight:normal;
      }
      tr:hover td {
        background:#008080;
        color:#FFFFFF;
        border-top: 1px solid #22262e;
      }
      td {
        background:#FFFFFF;
        padding:10px;
        text-align:left;
        vertical-align:top;
        font-weight:300;
        font-size:14px;
        border-right: 1px solid #C1C3D1;
      }
      body {
      font-size: 16px;
      }
    </style>
    """

        return css_string

    @staticmethod
    def convert_link_text_to_hyperlink(input_string):
        """
        convert_link_text_to_hyperlink : The function takes a string as argument and convert the link string to HTML hyperlink
        :param input_string:
        :return: String with link text converted to hyperlinks
        """
        ret_string = input_string
        logging.info("---------------- INFO ---------------------------------------------Email convert_link_text_to_hyperlink ------------------------------------------------ ")
        all_links = re.findall(CONSTANT_URL_REGEX, input_string)
        all_links = set(all_links)
        logging.info("all links list " + str(all_links))
        logging.info("The input string is : " + input_string)
        for link in all_links:
            if "mycompanydomain.atlassian.net" in link:
                pass
            else:
                link = link + " "
            # href_text = "click me"
            if "files" in link:
                href_text = link.split("/")[-2:][0]
            else:
                href_text = link.split("/")[-1:][0]
            # <a href="https://mycompanydomain.atlassian.net/browse/BCDST-793">BCDST-793</a>
            ret_string = re.sub(link, '<a href=\"' + link + '\">' + ' ' + href_text + ' ' + '</a>', ret_string)
        return ret_string

    @staticmethod
    def convert_list_strings_to_bold(list_strings, input_string):
        """
        convert_list_strings_to_bold: The function will take list of strings and html type input_string as arguments and convert each occurrence of string from list_string in input_string BOLD type
        :param list_strings: the list of strings to be searched for in input_string
        :param input_string: the input_string is of HTML type
        :return: returns input_string with all occurances of list_strings made bold
        """
        ret_string = input_string
        logging.info("---------------- INFO ---------------------------------------------Email convert_list_strings_to_bold ------------------------------------------------ ")
        for string_to_bold in list_strings:
            ret_string = re.sub(string_to_bold, "<b>" + string_to_bold + "</b>", ret_string)
        return ret_string

    def send_email(self, send_to, send_from, subject, message_body, table_data):
        """
        send_email : The function is used to send email
        :param send_to: Email address where the email is being sent to
        :param send_from: : Email address of the sender
        :param subject: : The subject of the email
        :param message_body: : The message body of the email
        :param table_data: : The email contains a HTML table, the table data is being manipulated using object table_data
        :return: None
        """
        logging.info("---------------- INFO --------------------------------------------- send_email ------------------------------------------------ ")
        t_data = table_data.get_html_string()
        msg = MIMEMultipart()
        msg['From'] = send_from
        msg['To'] = send_to
        msg['Subject'] = subject
        sender = [send_from]
        receivers = [send_to]
        # Create the body of the message (a plain-text and an HTML version).
        text = message_body
        html = """
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    {style_css_snippet}
  </head>
  <body>
    {body_snippet}
    <br>
      {table_snippet}
    <br>
    Thank you, <br>
    DevOps Team
    <br>
  </body>
</html>
  """.format(style_css_snippet=Email.return_style_css_string(), body_snippet=Email.return_body_string(), table_snippet=t_data)  # Email.return_table_snippet())

        html = self.convert_link_text_to_hyperlink(html)
        html = self.convert_list_strings_to_bold(['Repo:', 'Type:', 'Github Diff :', 'Docker Image SHA', 'Jira tasks:', 'GitHub pull requests:',
                                                  'Open', 'Ready for Dev Review', 'Backlog', 'Ready for Prod', 'Done', 'Build Status: ', 'Deployment status:',
                                                  'DEPLOYED TO DEV', 'Ready to Test', 'Code Review', 'Test Failed', 'Ready For Test', 'READY TO TEST'], html)
        print(html)
        # Record the MIME types of both parts - text/plain and text/html.
        part1 = MIMEText(text, 'plain')
        part2 = MIMEText(html, 'html')

        # Attach parts into message container.
        # According to RFC 2046, the last part of a multipart message, in this case
        # the HTML message, is best and preferred.
        msg.attach(part1)
        msg.attach(part2)

        try:
            self.server.sendmail(sender, receivers, msg.as_string())
            print("Successfully sent email")
        except smtplib.SMTPException:
            print("Error: unable to send email" + str(smtplib.SMTPException))


email_object = Email(CONSTANT_SMTP_HOST, CONSTANT_SMTP_PORT, CONSTANT_SMTP_USERNAME, CONSTANT_SMTP_PASSWORD)
