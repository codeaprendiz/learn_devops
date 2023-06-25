//install_plugins.groovy

Jenkins.instance.pluginManager.plugins.each{
    plugin -> println ("${plugin.getShortName()}")
}

import jenkins.model.*

import java.util.logging.Logger

def logger = Logger.getLogger("")
def installed = false
def initialized = false

def plugins = [
        'ace-editor',
        'ansible',
        'ansicolor',
        'ant',
        'antisamy-markup-formatter',
        'apache-httpcomponents-client-4-api',
        'authentication-tokens',
        'authorize-project',
        'bouncycastle-api',
        'branch-api',
        'build-name-setter',
        'build-timeout',
        'build-with-parameters',
        'cloudbees-folder',
        'collapsing-console-sections',
        'command-launcher',
        'conditional-buildstep',
        'config-file-provider',
        'console-badge',
        'console-column-plugin',
        'console-navigation',
        'console-tail',
        'credentials',
        'credentials-binding',
        'dashboard-view',
        'display-console-output',
        'display-url-api',
        'docker-commons',
        'docker-java-api',
        'docker-plugin',
        'docker-workflow',
        'durable-task',
        'dynamic-search-view',
        'email-ext',
        'embeddable-build-status',
        'extended-choice-parameter',
        'extensible-choice-parameter',
        'external-monitor-job',
        'extra-columns',
        'generic-webhook-trigger',
        'git',
        'git-changelog',
        'git-client',
        'git-server',
        'github',
        'github-api',
        'github-branch-source',
        'github-oauth',
        'github-pullrequest',
        'google-login',
        'gradle',
        'handlebars',
        'hudson-pview-plugin',
        'icon-shim',
        'jackson2-api',
        'javadoc',
        'jdk-tool',
        'job-dsl',
        'jobConfigHistory',
        'jquery',
        'jquery-detached',
        'jquery-ui',
        'jsch',
        'junit',
        'ldap',
        'lockable-resources',
        'mailer',
        'mapdb-api',
        'matrix-auth',
        'matrix-combinations-parameter',
        'matrix-project',
        'maven-plugin',
        'mission-control-view',
        'momentjs',
        'nodejs',
        'nodelabelparameter',
        'pam-auth',
        'parameter-separator',
        'parameterized-trigger',
        'pipeline-build-step',
        'pipeline-github-lib',
        'pipeline-graph-analysis',
        'pipeline-input-step',
        'pipeline-milestone-step',
        'pipeline-model-api',
        'pipeline-model-declarative-agent',
        'pipeline-model-definition',
        'pipeline-model-extensions',
        'pipeline-rest-api',
        'pipeline-stage-step',
        'pipeline-stage-tags-metadata',
        'pipeline-stage-view',
        'plain-credentials',
        'rebuild',
        'resource-disposer',
        'role-strategy',
        'run-condition',
        'scm-api',
        'script-security',
        'show-build-parameters',
        'simple-theme-plugin',
        'slack',
        'ssh-agent',
        'ssh-credentials',
        'ssh-slaves',
        'structs',
        'subversion',
        'throttle-concurrents',
        'timestamper',
        'token-macro',
        'trilead-api',
        'view-job-filters',
        'windows-slaves',
        'workflow-aggregator',
        'workflow-api',
        'workflow-basic-steps',
        'workflow-cps',
        'workflow-cps-global-lib',
        'workflow-durable-task-step',
        'workflow-job',
        'workflow-multibranch',
        'workflow-scm-step',
        'workflow-step-api',
        'workflow-support',
        'ws-cleanup'
]

def instance = Jenkins.getInstance()
def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()
uc.updateAllSites()

plugins.each {
    logger.info("Checking ${it}")
    if (!pm.getPlugin(it)) {
        logger.info("Looking UpdateCenter for ${it}")
        if (!initialized) {
            uc.updateAllSites()
            initialized = true
        }
        def plugin = uc.getPlugin(it)
        if (plugin) {
            logger.info("Installing ${it}")
            plugin.deploy()
            installed = true
        }
    }
}

if (installed) {
    logger.info("Plugins installed, initializing a   restart!")
    instance.save()
    instance.doSafeRestart()
}

