FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ADD ./quake3-data_63_all.deb /tmp/quake3-data.deb
RUN dpkg -i /tmp/quake3-data.deb

RUN apt-get update -qq \
	&& apt-get upgrade -qq \
	&& apt-get install -y --no-install-recommends ioquake3-server \
	&& useradd -m -s /usr/sbin/nologin -d /home/quake3 quake3 \
	# && mkdir /home/quake3/.q3a \
	# && ln -s /usr/share/games/quake3-data/baseq3 /home/quake3/.q3a/baseq3 \
	&& rm -rf /var/lib/apt/lists/* 

USER quake3
WORKDIR /home/quake3

RUN mkdir -p /home/quake3/.q3a/baseq3

ADD ./*.cfg /home/quake3/.q3a/baseq3/

CMD ["/usr/lib/ioquake3/ioq3ded", "+set", "fs_basepath", "/usr/share/games/quake3-data", "+exec", "levels.cfg"]
