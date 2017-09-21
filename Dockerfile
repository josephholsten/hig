# FROM debian:8
# ENV DISTRO debian/jessie
FROM ubuntu:14.04
ENV DISTRO ubuntu/trusty

MAINTAINER Joseph Anthony Pasquale Holsten <joseph@josephholsten.com>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get -q update \
&&  apt-get -qy --no-install-recommends install \
                        pandoc \
                        ruby \
                        rubygems-integration \
                        ruby-json \
                        ruby-ffi \
                        make \
                        binutils \
&&  gem install --no-rdoc --no-ri \
                        fpm \
                        package_cloud \
&&  apt-get -qy clean autoclean autoremove \
&&  rm -rf /var/lib/{apt,dpkg,cache,log}/ \

VOLUME /opt/src
WORKDIR /opt/src

ENTRYPOINT ["make"]
CMD ["deb"]
