FROM rocker/r-ver:4.0.0-ubuntu18.04

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/rocker-versioned" \
      org.label-schema.vendor="Rocker Project" \
      maintainer="Carl Boettiger <cboettig@ropensci.org>"

ENV S6_VERSION=v1.21.7.0
ENV RSTUDIO_VERSION=daily
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

RUN apt-get update \
&&  apt-get install -y --no-install-recommends \ 
  libpq5


RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_verse.sh

RUN mkdir /home/${DEFAULT_USER}/.config/rstudio/keybindings/

COPY settings/addins.json /home/rstudio/.config/rstudio/keybindings/
COPY settings/rstudio-prefs.json /home/rstudio/.config/rstudio/

COPY fonts /usr/share/fonts
COPY fonts /etc/rstudio/fonts

## Update font cache
RUN fc-cache -f -v

EXPOSE 8787

CMD /init



