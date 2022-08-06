
"""
########################################################################################################################################################
# ENVIRONMENT : The environment for which the script will execute
########################################################################################################################################################
"""
import logging

import requests
from requests.auth import HTTPDigestAuth

ENVIRONMENT = ""

"""
########################################################################################################################################################
# ATLAS_API_PRIVATE_KEY: MONGODB ATLAS API private key
########################################################################################################################################################
"""

ATLAS_API_PRIVATE_KEY = ""


"""
########################################################################################################################################################
# ATLAS_API_PUBLIC_KEY: MONGODB ATLAS API public key
########################################################################################################################################################
"""

ATLAS_API_PUBLIC_KEY = ""

"""
########################################################################################################################################################
# ATLAS_API_PRIVATE_KEY_STAGE: MONGODB ATLAS API private key for stage env
########################################################################################################################################################
"""

ATLAS_API_PRIVATE_KEY_STAGE = ""

"""
########################################################################################################################################################
# ATLAS_API_PUBLIC_KEY_STAGE: MONGODB ATLAS API public key for stage env
########################################################################################################################################################
"""

ATLAS_API_PUBLIC_KEY_STAGE = ""

MONGODB_ATLAS_CREATE_USER_PAYLOAD = '''
{
  "databaseName": "admin",
  "password": "_PASSWORD_TO_SET",
  "roles": [
    {
      "databaseName": "_DATABASE_NAME",
      "roleName": "_ROLE_NAME"
    }],
  "scopes": [{
    "name": "_CLUSTER_NAME",
    "type": "CLUSTER"
  }],
  "username": "_USER_NAME"
}
'''



"""
########################################################################################################################################################
# DEV_DB_HOSTNAME: MONGODB ATLAS DEV Hostname
# DEV_DB_PROJECT_NAME: The Project names that show up on the UI console. We have dev, stage projects
# DEV_DB_PROJECT_ID: Each project like dev, stage has a unique ID. Every project can have multiple mongo db clusters.
# DEV_DB_CLUSTER_NAME: The mongo db cluster name that shows up on the UI inside a given project
########################################################################################################################################################
"""

DEV_DB_HOSTNAME = ""
DEV_DB_PROJECT_NAME = "xyz"
DEV_DB_PROJECT_ID = "123412341234"
DEV_DB_CLUSTER_NAME = "abc"

"""
########################################################################################################################################################
# STAGE_DB_HOSTNAME: MONGODB ATLAS STAGE Hostname
# STAGE_DB_PROJECT_NAME: The Project names that show up on the UI console. We have dev, stage projects
# STAGE_DB_PROJECT_ID: Each project like dev, stage has a unique ID. Every project can have multiple mongo db clusters.
# STAGE_DB_CLUSTER_NAME: The mongo db cluster name that shows up on the UI inside a given project
########################################################################################################################################################
"""
STAGE_DB_HOSTNAME = ""
STAGE_DB_PROJECT_NAME = "abc"
STAGE_DB_PROJECT_ID = "1298340928374132"
STAGE_DB_CLUSTER_NAME = "xbs"

"""
########################################################################################################################################################
# DATABASE_USERS_QUERY_URL: Query URL to for the database users
########################################################################################################################################################
"""
DATABASE_USERS_QUERY_URL = f'https://cloud.mongodb.com/api/atlas/v1.0/groups/REPLACE_WITH_PROJECT_ID/databaseUsers'


class Utility(object):
    """
    ########################################################################
    #  UTILITY CLASS
    # --> This will contain the Utility functions
    ########################################################################
    """

    @staticmethod
    def show_usage():
        """
          show_usage : The function shows the usage of the script.
          :return:
          """
        print("Usage python3 create-user.py <environment/mongodb clustername> <username> <password> <databaseName> <access-type>")


    @staticmethod
    def print_connection_string(file_path, file_name):
        """

        :param file_path:
        :return:
        """
        file_handle = open(file_path + file_name, 'r')
        lines = file_handle.readlines()
        list_of_string = []
        for line in lines:
            if "databaseName" in line:
                list_of_string.append(line.replace("- databaseName:", "").rstrip().lstrip().lstrip("\"").rstrip("\""))
            elif "username" in line:
                list_of_string.append(line.replace("username:", "").rstrip().lstrip().lstrip("\"").rstrip("\""))
            elif "password" in line:
                list_of_string.append(line.replace("password:", "").rstrip().lstrip().lstrip("\"").rstrip("\""))

        count = 0
        while count < len(list_of_string):
            db = list_of_string[count]
            username = list_of_string[count + 1]
            password = list_of_string[count + 2]
            """
            """

            print(f'\'{db}\' => [ \'user\' => \'{username}\' , \'password\' => \'{password}\',],')
            # print(f'mongo "mongodb+srv://youhost.name/{db}" --username {username} --password {password}')
            count = count + 3


class MONGODB_ATLAS(object):
    """
    ########################################################################
    #  MONGODB_ATLAS_CLUSTER CLASS
    # --> This will contain the MONGODB_ATLAS_CLUSTER functions
    ########################################################################
    """
    db_host_name = ""
    db_atlas_project_name = ""
    db_atlas_project_id = ""
    db_atlas_cluster_name = ""

    def __init__(self, db_host_name, db_atlas_project_name, db_atlas_project_id, db_atlas_cluster_name):
        logging.info("----------------------INFO----------------------------------------------------MONGODB_ATLAS constructor ----------------------------------------")
        self.db_host_name = db_host_name
        self.db_atlas_project_name = db_atlas_project_name
        self.db_atlas_project_id = db_atlas_project_id
        self.db_atlas_cluster_name = db_atlas_cluster_name

    def patch_database_user(self, username, password, database_name, role_name, user_permission_scope_on_cluster, api_public_key, api_private_key):
        """

        :param username:
        :param password:
        :param database_name:
        :param role_name:
        :param user_permission_scope_on_cluster:
        :return:
        """
        logging.info("----------------------INFO----------------------------------------------------MONGODB_ATLAS path_database_user ----------------------------------------")
        query_url = DATABASE_USERS_QUERY_URL.replace('REPLACE_WITH_PROJECT_ID', self.db_atlas_project_id) + "/" + "admin" + "/" + username
        headers = {'Accept': 'application/json',
                   'Content-Type': 'application/json'
                   }

        data = MONGODB_ATLAS_CREATE_USER_PAYLOAD.replace('_PASSWORD_TO_SET', password) \
            .replace('_USER_NAME', username) \
            .replace('_DATABASE_NAME', database_name) \
            .replace('_ROLE_NAME', role_name) \
            .replace('_CLUSTER_NAME', user_permission_scope_on_cluster)
        response_dict = requests.patch(query_url, data=data, headers=headers, auth=HTTPDigestAuth(api_public_key, api_private_key))
        print(response_dict.status_code)

    def create_database_user(self, username, password, database_name, role_name, user_permission_scope_on_cluster,api_public_key, api_private_key):
        """

        :param username:
        :param password:
        :param database_name:
        :param role_name:
        :param user_permission_scope_on_cluster:
        :return:
        """
        logging.info("----------------------INFO----------------------------------------------------MONGODB_ATLAS create_database_user ----------------------------------------")
        query_url = DATABASE_USERS_QUERY_URL.replace('REPLACE_WITH_PROJECT_ID', self.db_atlas_project_id)
        headers = {'Accept': 'application/json',
                   'Content-Type': 'application/json'
                   }

        data = MONGODB_ATLAS_CREATE_USER_PAYLOAD.replace('_PASSWORD_TO_SET', password) \
            .replace('_USER_NAME', username) \
            .replace('_DATABASE_NAME', database_name) \
            .replace('_ROLE_NAME', role_name) \
            .replace('_CLUSTER_NAME', user_permission_scope_on_cluster)
        response_dict = requests.post(query_url, data=data, headers=headers, auth=HTTPDigestAuth(api_public_key, api_private_key))
        print(response_dict.status_code)
        if response_dict.status_code == 409:
            logging.info("The user already exists. Patching the user with new details provided.")
            self.patch_database_user(username, password, database_name, role_name, user_permission_scope_on_cluster, api_public_key, api_private_key)


##############################################################################
#
#                      Main module starts here
#
###############################################################################
# total number of arguments

db_object = MONGODB_ATLAS(DEV_DB_HOSTNAME, DEV_DB_PROJECT_NAME, DEV_DB_PROJECT_ID, DEV_DB_CLUSTER_NAME)
db_object.create_database_user("someuser", "somepassword", "somedb", "ReadWrite", "Clustername", ATLAS_API_PUBLIC_KEY, ATLAS_API_PRIVATE_KEY)
