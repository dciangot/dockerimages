#!/bin/bash

# let's avoid black holes
cmd="ls /cvmfs/cms.cern.ch/cmsset_default.sh"
timeout 10 $cmd
if [ $? -ne 0 ]; then
    echo "CVMFS Problems. CVMFS Must run to allow job execution"
    if [ $? -eq 124 ]; then
        echo "Actually timeout occurred"
    fi
    echo "Going ahead is pointless.. shutting down container already now " 
    exit 9
fi

yum -y install ca-policy-egi-core
yum -y install ca-policy-lcg
/usr/sbin/fetch-crl -q

wget -O /etc/yum.repos.d/ca_CMS-TTS-CA.repo https://ci.cloud.cnaf.infn.it/job/cnaf-mw-devel-jobs/job/ca_CMS-TTS-CA/job/master/lastSuccessfulBuild/artifact/ca_CMS-TTS-CA.repo
yum -y install ca_CMS-TTS-CA

resp=0
until [  $resp -eq 200 ]; do
    resp=$(curl -s \
        -w%{http_code} \
        $PROXY_CACHE/cgi-bin/get_proxy -o /root/gwms_proxy)
done
#############

chmod 600 /root/gwms_proxy

export X509_USER_PROXY=/root/gwms_proxy
export X509_CERT_DIR=/etc/grid-security/certificates
grid-proxy-info

if [ $? -eq 0 ]; then
    echo "proxy certificate is OK"

    ### Configure condor
    str1=$(grep "GLIDEIN_Site =" /etc/condor/config.d/99_DODAS_local)
    sed -i -e "s/$str1/GLIDEIN_Site = \"$CMS_LOCAL_SITE\"/g" /etc/condor/config.d/99_DODAS_local
    str2=$(grep "GLIDEIN_CMSSite =" /etc/condor/config.d/99_DODAS_local)
    sed -i -e "s/$str2/GLIDEIN_CMSSite = \"$CMS_LOCAL_SITE\"/g" /etc/condor/config.d/99_DODAS_local

    export PATH=$PATH:/usr/libexec/condor

    oneclient -i -o allow_other -H $CMS_ONEDATA_CACHE -t $ONEDATA_ACCESS_TOKEN /mnt/onedata/
else
    echo "proxy certificate is Failure"
    exit 9
fi
