FROM spiga/cmsel7wn
LABEL name="DODAS Worker Node for CMS on EL 7"
LABEL build-date="20170729"
LABEL maintainer="Daniele Spiga"

RUN  useradd -ms /bin/bash condor  

# HTCondor
#https://get.onedata.org/oneclient.sh

WORKDIR /etc/yum.repos.d
RUN     wget http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel7.repo && \
        wget http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo && \
        wget http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \
        rpm --import RPM-GPG-KEY-HTCondor && \
        wget -O onedata.rpm http://onedata-dev-packages.cloud.plgrid.pl/yum/centos/7x/x86_64/oneclient-17.06.0.rc4-1.el7.centos.x86_64.rpm

RUN     yum install -y condor-all && \
        yum -y localinstall onedata.rpm && \
        yum clean all


RUN     ln -s /usr/lib64/condor /usr/lib/condor; \
        ln -s /usr/libexec/condor /usr/lib/condor/libexec

ADD     condorconfig /etc/condor/
ADD     config.d /etc/condor/config.d/

WORKDIR /root

ADD     dodas_bin  /usr/local/bin/

RUN     chmod +x /usr/local/bin/dodasexe_pre.sh && \
        chmod +x /usr/local/bin/dodasexe.sh && \
        chmod +x /usr/local/bin/dodas.sh 

# onedata directory needed for mount

RUN     mkdir -p /mnt/onedata/ \
                 /var/log/dodas
