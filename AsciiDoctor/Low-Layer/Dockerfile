FROM alpine:3.5
MAINTAINER Thibaut Fabre <fabre.thibaut@gmail.com>

### Update, install some packages and do other some stuff
RUN apk update && \
    apk add curl wget bash git ruby ruby-bundler && \
    rm -rf /var/cache/apk/* && \
    echo 'gem: --no-document' > /etc/gemrc

### Install ruby packages
RUN gem install rdoc && \
    gem install asciidoctor && \
    gem install asciidoctor-pdf --pre && \
    gem install rouge pygments.rb coderay && \
    gem install slim tilt haml && \
    gem install asciidoctor-revealjs

### Set the CMD
CMD ["/bin/bash"]
