from pathlib import Path
import os
import shutil
import git
import logging



class SCMRepo(object):
    """
    ########################################################################
    #  SCMRepo CLASS
    # --> This will contain the Github related operations which we usually
    #     do with git commands
    ########################################################################
    """
    repo_url = ""
    repo_name = ""
    repo_clone_dir = ""
    repo_home_dir = ""
    repo_obj = None

    def __init__(self, r_name, r_clone_dir):
        logging.info("----------------------INFO---------------------------------------------------- CONSTRUCTOR SCM Repo-------------------------------")
        self.repo_url = f"git@github.com:mycompany/{r_name}.git"  # git@github.com:mycompany/search.git
        self.repo_name = r_name
        self.repo_clone_dir = r_clone_dir
        self.repo_home_dir = r_clone_dir + "/" + self.repo_name
        if os.path.isdir(self.repo_clone_dir) and os.path.isdir(self.repo_home_dir) and len(os.listdir(self.repo_home_dir)) != 0:
            self.repo_obj = git.Repo.init(self.repo_home_dir)
            logging.info("Active Local Branch : " + self.repo_obj.active_branch.name)
            self.git_pull()
        else:
            Path(r_clone_dir).mkdir(parents=True, exist_ok=True)
            git.Git(r_clone_dir).clone(self.repo_url)
        self.repo_obj = git.Repo.init(r_clone_dir + "/" + self.repo_name)

    def git_checkout(self, r_branch_name):
        """
        git_checkout : to checkout a git repoistory
        :param r_branch_name: branch to be checked out
        :return: None
        """
        logging.info("----------------------INFO---------------------------------------------------SCMRepo GIT_CHECKOUT ----------------------------------------")
        self.repo_obj.git.checkout(r_branch_name)

    def git_pull(self):
        """
        git_pull : to pull the changes from remote to local git repository
        :return: None
        """
        logging.info("----------------------INFO---------------------------------------------------SCMRepo git_pull ----------------------------------------")
        current = self.repo_obj.head.commit
        self.repo_obj.remotes.origin.pull()
        if current != self.repo_obj.head.commit:
            logging.info("Pulled the changes from remote as local was behind")
        else:
            logging.info("No git pull required as local up to date with remote")

    # def git_reset(self, reset_to_branch_name):
    #   self.repo_obj.git.reset('--hard', reset_to_branch_name)
    #
    # def git_push(self):
    #   origin = self.repo_obj.remote(name='origin')
    #   origin.push()

    def git_rev_list(self, r_branch_name):
        """
        git_rev_list : To return the number of commits done to a given branch from begining
        :param r_branch_name: branch in consideration
        :return: Integer count of number of commits
        """
        logging.info("----------------------INFO----------------------------------------------------SCMRepo git_rev_list ----------------------------------------")
        self.git_checkout(r_branch_name)
        self.git_pull()
        count = self.repo_obj.git.rev_list('--count', r_branch_name)
        return count

    def git_log(self):
        """
        git_log : to return the commit log of git repository with given checked out branch
        :return: String Log
        """
        logging.info("----------------------INFO----------------------------------------------------SCMRepo git_log ----------------------------------------")
        if os.path.isdir("/tmp/" + self.repo_name):
            repository_path = "/tmp/" + self.repo_name
            git_obj = git.Git(repository_path)
            log_info = git_obj.log()
            print(type(log_info))
            print(log_info)
        else:
            print("Repo path does not exist")

    def git_log_diff(self, branch1, branch2):
        """
        git_log_diff : the give the difference in commit logs of two branches of git repository
        :param branch1: branch 1 in consideration
        :param branch2: branch 2 in consideration
        :return: String Log difference
        """
        logging.info("----------------------INFO----------------------------------------------------SCMRepo git_log_diff ----------------------------------------")
        if os.path.isdir("/tmp/tmp/" + self.repo_name):
            repository_path = "/tmp/tmp/" + self.repo_name
            git_obj = git.Git(repository_path)
            git_obj.pull()
            log_info = git_obj.log('%s..%s' % (branch1, branch2), '--pretty=format:%ad %an - %s', '--abbrev-commit')
            print(type(log_info))
            print(log_info)
            return log_info

    def git_exec(self, command, **kwargs):
        """Execute git commands"""

        command.insert(0, self.git)
        if kwargs.pop('no_verbose', False):  # used when git output isn't helpful to user
            verbose = False
        else:
            verbose = self.verbose

        if not self.fake:
            result = self.repo.git.execute(command, **kwargs)
        else:
            if 'with_extended_output' in kwargs:
                result = (0, '', '')
            else:
                result = ''
        return result

    @staticmethod
    def get_scm_object(repository_url):
        """
        get_scm_object : to get the SCM object initialized with repository_url
        :param repository_url: the git repository URL for the SCM object
        :return: SCM object
        """
        logging.info("----------------------INFO----------------------------------------------------SCMRepo get_scm_object ----------------------------------------")
        repository_name = repository_url.split("/")[1].replace(".git", "")
        if os.path.isdir("/tmp/" + repository_name):
            shutil.rmtree("/tmp/" + repository_name.replace(".git", ""))
        scm_object = SCMRepo(repository_url, repository_name)
        scm_object.git_clone("/tmp/")
        return scm_object

    @staticmethod
    def reset_repositories_stage_branches_to_dev(scm_object):
        """
        reset_repositories_stage_branches_to_dev : to reset the repository state from stage branch to dev branch state
        :param scm_object: scm object
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------SCMRepo reset_repositories_stage_branches_to_dev ----------------------------------------")
        scm_object.git_checkout("stage")
        scm_object.git_reset("origin/develop")
        scm_object.git_push()

    @staticmethod
    def get_git_log_of_branch(scm_object, branch_name):
        """
        get_git_log_of_branch : to get the commit log of a given git repository branch
        :param scm_object: SCM object handle for repository
        :param branch_name: branch name
        :return: None
        """
        logging.info("----------------------INFO----------------------------------------------------SCMRepo get_git_log_of_branch ----------------------------------------")
        scm_object.git_checkout(branch_name)
        scm_object.git_log()