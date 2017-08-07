FROM spiga/el7wn
MAINTAINER spiga spiga@pg.infn.it

# Required software is listed under slc7_amd64_platformSeeds at
# http://cmsrep.cern.ch/cgi-bin/cmspkg/driver/cms/slc7_amd64_gcc530

RUN yum -y install gcc \
                   glibc-headers \
                   openssh-clients \
                   redhat-lsb-core \
                   sssd-client && \
    yum -y install glibc coreutils bash tcsh zsh perl tcl tk readline openssl ncurses e2fsprogs krb5-libs freetype ncurses-libs perl-libs perl-ExtUtils-Embed \
                   fontconfig compat-libstdc++-33 libidn libX11 libXmu libSM libICE libXcursor \
                   libXext libXrandr libXft mesa-libGLU mesa-libGL e2fsprogs-libs libXi libXinerama libXft-devel \
                   libXrender libXpm libcom_err perl-Test-Harness perl-Carp perl-constant perl-PathTools \
                   perl-Data-Dumper perl-Digest-MD5 perl-Exporter perl-File-Path perl-File-Temp perl-Getopt-Long \
                   perl-Socket perl-Text-ParseWords perl-Time-Local libX11-devel libXpm-devel libXext-devel mesa-libGLU-devel \
                   perl-Switch perl-Storable perl-Env perl-Thread-Queue && \
    yum clean all
