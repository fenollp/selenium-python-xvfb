FROM ubuntu:16.10

ENV BROWSER firefox
ENV DISPLAY :99
ENV GECKOV v0.14.0

#================================================
# Installations
#================================================

RUN apt-get update && apt-get install -y $BROWSER \
        build-essential libssl-dev python-setuptools \
        vim xvfb xz-utils zlib1g-dev wget python3-pip

RUN pip3 install --upgrade pip

RUN pip3 install selenium pyvirtualdisplay requests unittest-xml-reporting

ENV GECKO_URL https://github.com/mozilla/geckodriver/releases/download/$GECKOV/geckodriver-$GECKOV-linux64.tar.gz
RUN wget $GECKO_URL && tar xvxf gecko* && mv geckodriver /usr/bin && chmod a+x /usr/bin/geckodriver

#==================
# Vim highlight
#==================

RUN echo 'syntax on' >>/etc/vim/vimrc

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
