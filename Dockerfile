FROM ich777/mono-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends screen unzip curl && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/windward"
ENV GAME_PARAMS="-name "Docker Windward" -world "World" -tcp 5127 -public"
ENV ADMIN=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USER="windward"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 777 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]