# FROM ubuntu:bionic
FROM raspbian/stretch

ENV GASSIST_CRED_FILENAME=gassist-cred.json \
    USER=pi \
    UNAME=pi \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN apt-get update && \
    apt-get -y install sudo git && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes pulseaudio-utils 
#    groupadd -g 1000 ${USER} && useradd --create-home -u 1000 -g ${USER} -s /bin/bash ${USER} && \
#    adduser ${USER} sudo && \
#    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set up the user
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} pi

WORKDIR /home/${USER}/GassistPi

COPY . .

COPY pulse-client.conf /etc/pulse/client.conf

WORKDIR /home/${USER}

RUN ["/bin/bash","-c", "./GassistPi/scripts/docker-gassist-installer.sh"]

RUN chown -R ${USER}:${USER} /home/${USER}

USER ${USER}

ENV PATH="/home/${USER}/env/bin:${PATH}"

CMD ["/bin/bash", "-c", "./Gassist/start.sh"]
