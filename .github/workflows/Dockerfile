FROM docker.io/rockylinux:9

RUN dnf update -y

RUN dnf install -y dnf-plugins-core \
    && dnf install -y epel-release \
    && dnf config-manager --set-enabled crb \
    && dnf install -y rpm-build rpmlint rpmdevtools dos2unix tree \
    && dnf clean all

COPY entrypoint.sh /usr/local/entrypoint.sh

RUN dos2unix /usr/local/entrypoint.sh && chmod +x /usr/local/entrypoint.sh

WORKDIR /root

RUN rpmdev-setuptree

WORKDIR /root/rpmbuild

ENTRYPOINT ["/usr/local/entrypoint.sh"]