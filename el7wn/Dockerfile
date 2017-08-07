FROM centos:7
MAINTAINER spiga spiga@pg.infn.it

# wn metapackage: https://twiki.cern.ch/twiki/bin/view/LCG/EL7WNMiddleware 

RUN yum install -y wget

WORKDIR /etc/yum.repos.d
RUN wget http://repository.egi.eu/community/software/preview.repository/2.0/releases/repofiles/centos-7-x86_64.repo && \
    wget http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo 

WORKDIR /root
# Add the extra system stuff we need
RUN yum install -y yum-plugin-ovl \
                   epel-release && \
    yum install -y singularity \
                   wn \
                   fetch-crl && \
    yum update -y && \
    yum clean all
