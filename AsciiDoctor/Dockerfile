FROM tibo43/light-asciidoctor:latest
MAINTAINER Thibaut Fabre <fabre.thibaut@gmail.com>

### Define some variables
ENV DEFAULT_GEN default
ENV DIR_PDF /theme/pdf-sources
ENV DIR_PDF_FONTS fonts
ENV DIR_PDF_THEME themes
ENV DIR_REVEALJS /theme/reveal.js-sources
ENV DIR_REVEALJS_SLIM slim
ENV DEFAULT_STYLE default
ENV DEFAULT_FILE default.adoc

### Git clone asciidoctor themes
RUN mkdir /theme && mkdir /src

### Set the place to mount the volume
VOLUME /src

### Copy Script
COPY script.sh /

### Set the workdir
WORKDIR /src

### Define entrypoint
ENTRYPOINT bash /script.sh
