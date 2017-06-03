FROM tibo43/light-asciidoctor:latest
MAINTAINER Thibaut Fabre <fabre.thibaut@gmail.com>

### Define some variables
ENV DIR_PDF /theme/pdf-sources
ENV DIR_FONTS fonts
ENV DIR_THEME themes
ENV DEFAULT_STYLE default
ENV DEFAULT_FILE default.adoc

### Git clone asciidoctor themes
RUN mkdir /theme && mkdir /src
#&& git clone https://github.com/tibo43/asciidoctor_theme.git /theme

### Set the place to mount the volume
VOLUME /src

### Copy Script
COPY script.sh /

### Set the workdir
WORKDIR /src

### Define entrypoint
ENTRYPOINT bash /script.sh
