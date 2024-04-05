# Dockerfile to host tftp server, 
# for machines that run container but don't have the binary

# modeled after  Dockerfile github: https://github.com/tin6150/perf_tools/blob/master/Dockerfile


FROM rockylinux:9.3
MAINTAINER Tin (at) LBL.gov

ARG TZ="America/Los_Angeles"

ENV TFTPD_BIND_ADDRESS="0.0.0.0:69"
ENV TFTPD_EXTRA_ARGS=""

# destination dir will be created automatically
COPY . /gitrepo

RUN touch    _TOP_DIR_OF_CONTAINER_                                                   ;\
    echo "====================================== " | tee -a _TOP_DIR_OF_CONTAINER_    ;\
    echo "Begin Dockerfile build process at " | tee -a _TOP_DIR_OF_CONTAINER_         ;\
    echo "====================================== " | tee -a _TOP_DIR_OF_CONTAINER_    ;\
    hostname | tee -a       _TOP_DIR_OF_CONTAINER_                                    ;\
    date     | tee -a       _TOP_DIR_OF_CONTAINER_                                    ;\
    touch /THIS_IS_INSIDE_DOCKER_CONTAINER                                            ;\
    # mkdir /tftpboot                                                                   ;\
    bash  /gitrepo/install_tools_rocky9.sh  | tee -a install_tools.log                ;\
    echo  $? > install_tools.exit.code                                                ;\
    cd      / 

COPY ./tftpboot  /tftpboot

RUN touch    _TOP_DIR_OF_CONTAINER_                                                   ;\
    echo "====================================== " | tee -a _TOP_DIR_OF_CONTAINER_    ;\
    echo "mousepad editor layer to check size    " | tee -a _TOP_DIR_OF_CONTAINER_    ;\
    echo "====================================== " | tee -a _TOP_DIR_OF_CONTAINER_    ;\
    yum -y install mousepad  | tee -a yum_install.log  ;\
    cd      / 

RUN     cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && TZ=PST8PDT date  >> _TOP_DIR_OF_CONTAINER_  \
  && echo  "Dockerfile. 2024.0405 /tftpboot  "     >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Grand Finale"

# ENV TZ America/Los_Angeles  
# ENV TZ could be changed/overwritten by container's /etc/csh.cshrc
ENV TEST_DOCKER_ENV_1   Can_use_ADD_to_make_ENV_avail_in_build_process
ENV TEST_DOCKER_ENV_REF https://vsupalov.com/docker-arg-env-variable-guide/#setting-env-values


EXPOSE 69/udp 

# VOLUME /var/lib/tftpboot 
# VOLUME /tftpboot 

CMD set -eu ;\
    #[ -d /tftpboot/boot/root ] && cp -af /tftpboot/boot/root/* /tftpboot ;\
    exec /usr/sbin/in.tftpd -L -vvv -u ftp --secure --address "$TFTPD_BIND_ADDRESS" $TFTPD_EXTRA_ARGS /tftpboot

###ENTRYPOINT [ "/usr/bin/zsh" ]
#ENTRYPOINT [ "/usr/bin/bash", "-l", "-i" ]
# if no defined ENTRYPOINT, default to bash inside the container
