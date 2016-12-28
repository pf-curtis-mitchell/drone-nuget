FROM alpine:3.3

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories

RUN apk update && \
  apk add \
    ca-certificates \
    nodejs \
    mono@testing && \
  rm -rf \
    /var/cache/apk/*

RUN mkdir -p /usr/lib/nuget && \
  wget \
    https://dist.nuget.org/win-x86-commandline/v3.5.0/nuget.exe \
    -O /usr/lib/nuget/NuGet.exe

WORKDIR /node
ADD package.json /node/
ADD index.js /node/
RUN npm install --production

ENTRYPOINT ["node", "index.js"]
