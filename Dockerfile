FROM ubuntu

RUN apt-get update -y &&\
  apt-get install -yy wget

RUN wget https://github.com/google/go-jsonnet/releases/latest/download/jsonnet-go_0.17.0_linux_amd64.deb -O /usr/bin/jsonnet &&\
  chmod +x /usr/bin/jsonnet
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
  chmod +x /usr/bin/yq

RUN useradd -ms /bin/bash user

COPY ./build-manifests.sh /build-manifests.sh
COPY ./sync-import.sh /sync-import.sh
RUN mkdir /build && chown user /build

USER user

ENTRYPOINT [ "/bin/bash","-c","/build-manifests.sh $@" ]
