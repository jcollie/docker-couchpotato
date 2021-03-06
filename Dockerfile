FROM registry.fedoraproject.org/fedora:27

ENV LANG C.UTF-8

RUN dnf -y update && \
    rm -rf /var/cache/dnf /usr/share/doc /usr/share/man

RUN dnf -y install git python2 python2-lxml python2-pyOpenSSL && \
    rm -rf /var/cache/dnf /usr/share/doc /usr/share/man

RUN groupadd -g 5000 media
RUN useradd -u 5000 -g 5000 -d /source -M media

RUN mkdir /config /data /source && chown media:media /config /data /source

USER media

RUN git clone https://github.com/CouchPotato/CouchPotatoServer.git /source

VOLUME /config
VOLUME /data

EXPOSE 5050/tcp

WORKDIR /source

CMD ["/usr/bin/python2", "/source/CouchPotato.py", "--config_file=/config/config.ini", "--data_dir=/data"]

# Local Variables:
# indent-tabs-mode: nil
# End:
