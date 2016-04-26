FROM ubuntu:latest
RUN apt-get -y update && apt-get install -y wget curl &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    groupadd dropbox && \
    useradd -m -d /home/dbox -c "Dropbox Daemon Account" -g dropbox dropbox
USER dropbox
RUN cd ~ &&wget -O ~/binary.tar "https://www.dropbox.com/download?plat=lnx.x86_64" && tar xzf ~/binary.tar && rm -f ~/binary.tar
RUN touch ~/Dropbox

# Switch back to root, since the run script needs root privs to chmod to the user's preferrred UID
USER root

# Install init script and dropbox command line wrapper
COPY run /root/

VOLUME ["/home/dbox/.dropbox", "/home/dbox/Dropbox"]
ENTRYPOINT ["/root/run"]
