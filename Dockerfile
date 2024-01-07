FROM alpine:3.19

RUN apk upgrade --no-cache \
  && apk add --update --no-cache \
  bash \
  ntpdate \
  tor \ 
  torsocks \
  nyx

# init script
COPY ./init.sh /init.sh
RUN chmod +x /init.sh

# Create a new user tor
ARG UID=1001
ARG GID=1001
RUN groupadd --gid $GID tor
RUN useradd --system --create-home --shell /usr/sbin/nologin --uid $UID --gid $GID tor

# Run with user tor
USER tor

# Configuration files and data output folder
ENTRYPOINT ["/init.sh"]
