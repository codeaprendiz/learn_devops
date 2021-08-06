FROM jenkins/inbound-agent:4.6-1

# Switch to root
USER root
RUN passwd --delete jenkins

# Install Ansible
# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
RUN DEBIAN_FRONTEND=noninteractive
RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" > /etc/apt/sources.list.d/ansible.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt update
RUN apt install sudo systemd-container python3 python3-pip ansible apt-transport-https gnupg2 ca-certificates curl zip -y
RUN usermod -aG sudo jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

RUN rm -f /etc/apt/sources.list.d/google-cloud-sdk.list
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

RUN apt update
RUN apt-get install -y  mongodb-org-tools mongodb-org-shell default-mysql-client kubectl google-cloud-sdk awscli

# https://stackoverflow.com/questions/64596394/importerror-cannot-import-name-docevents-from-botocore-docs-bcdoc-in-aws-co
RUN pip3 install botocore==1.20.86
RUN pip3 install awscli==1.19.86
RUN ansible-galaxy collection install amazon.aws

# copy github ssh key on root
RUN /bin/bash -l -c "mkdir /root/.ssh"
# ADD ssh/private_key /root/.ssh/private_key
# RUN chmod 700 /root/.ssh/private_key
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# copy github ssh key on jenkins
RUN /bin/bash -l -c "mkdir /home/jenkins/.ssh"
# ADD ssh/private_key /home/jenkins/.ssh/private_key
# RUN chmod 700 /home/jenkins/.ssh/private_key
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /home/jenkins/.ssh/config

# COPY _ansible_repository /opt/_ansiblerepo/
# RUN sudo chmod -R 400 /opt/_ansible/ssh/

USER jenkins