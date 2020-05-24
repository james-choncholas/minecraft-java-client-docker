FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -qy \
        --no-install-recommends \
        curl ca-certificates
RUN curl https://launcher.mojang.com/download/Minecraft.deb --output /Minecraft.deb
RUN apt-get install -qy \
        --no-install-recommends \
        /Minecraft.deb && \
    rm /Minecraft.deb && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entry.sh /usr/bin/
ENTRYPOINT ["docker-entry.sh"]
