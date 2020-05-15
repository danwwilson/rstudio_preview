FROM rocker/r-ver:4.0.0-ubuntu18.04

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/rocker-versioned" \
      org.label-schema.vendor="Rocker Project" \
      maintainer="Carl Boettiger <cboettig@ropensci.org>"

ENV S6_VERSION=v1.21.7.0
ENV RSTUDIO_VERSION=daily
ENV PATH=/usr/lib/rstudio-server/bin:$PATH


RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_pandoc.sh

COPY fonts /usr/share/fonts
COPY fonts /etc/rstudio/fonts

## Update font cache
RUN fc-cache -f -v

EXPOSE 8787

CMD /init



