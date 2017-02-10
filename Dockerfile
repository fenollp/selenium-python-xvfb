FROM ubuntu:17.04

ENV DISPLAY :99
ENV GECKOV v0.14.0
ENV FFV 52.0~b4+build1-0ubuntu0.17.04.1

#================================================
# Installations
#================================================

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:mozillateam/firefox-next \
    && apt-get update \
    && apt-get purge firefox \
    && apt-get upgrade -y

RUN apt-get install -y \
        firefox=$FFV \
        build-essential libssl-dev python-setuptools \
        xvfb xz-utils zlib1g-dev wget python3-pip

RUN pip3 install --upgrade pip
RUN pip3 install -U selenium pyvirtualdisplay requests unittest-xml-reporting

ENV GECKO_URL https://github.com/mozilla/geckodriver/releases/download/$GECKOV/geckodriver-$GECKOV-linux64.tar.gz
RUN wget $GECKO_URL && tar xvxf gecko* && mv geckodriver /usr/bin && chmod a+x /usr/bin/geckodriver

#==================
# Xvfb + init scripts
#==================

ADD libs/xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb

ADD libs/xvfb-daemon-run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run

#============================
# Clean up
#============================

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ADD example.py /home/
