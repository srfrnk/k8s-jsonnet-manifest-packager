FROM ubuntu

RUN apt-get update -y &&\
  apt-get install -yy wget

RUN wget https://github.com/google/go-jsonnet/releases/download/v0.17.0/go-jsonnet_0.17.0_Linux_x86_64.tar.gz -O jsonnet.tar.gz &&\
  tar -xzf jsonnet.tar.gz &&\
  rm jsonnet.tar.gz &&\
  mv jsonnet /usr/bin/jsonnet &&\
  chmod +x /usr/bin/jsonnet

RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
  chmod +x /usr/bin/yq

RUN useradd -ms /bin/bash user

COPY ./build-manifests.sh /build-manifests.sh
COPY ./sync-import.sh /sync-import.sh
RUN mkdir /build && chown user /build

USER user

ENTRYPOINT [ "/bin/bash","-c","/build-manifests.sh $@" ]
