FROM centos:7
MAINTAINER Ira W. Snyder <isnyder@lcogt.net>

# netdisco-web runs on port 5000
EXPOSE 5000
ENTRYPOINT [ "/init" ]

ENV NETDISCO_VERSION 2.033006

# install and update packages
RUN yum -y install epel-release \
        && yum -y install perl-core perl-DBD-Pg net-snmp-perl net-snmp-devel \
                          make automake gcc tar gzip bzip2 postgresql \
                          supervisor \
        && yum -y update \
        && yum -y clean all

# Install netdisco
# https://metacpan.org/pod/App::Netdisco
ENV NETDISCO_HOME "/netdisco"
RUN mkdir -p "$NETDISCO_HOME" \
        && cd "$NETDISCO_HOME" \
        && curl -L http://cpanmin.us/ | perl - --notest --local-lib $NETDISCO_HOME/perl5 App::Netdisco@$NETDISCO_VERSION \
        && rm -rf /root/.cpanm

# Add netdisco to the PATH
ENV PATH $NETDISCO_HOME/perl5/bin:$PATH

# Copy OUI file
# The website that hosts this is incredibly slow, so we provide a local copy
COPY oui.txt "$NETDISCO_HOME/"

# Deploy the MIBS manually
# This website is fast, but we'd rather not depend on being Internet accessable
# during container startup
RUN curl -L http://downloads.sourceforge.net/project/netdisco/netdisco-mibs/latest-snapshot/netdisco-mibs-snapshot.tar.gz > "$NETDISCO_HOME/netdisco-mibs-snapshot.tar.gz" \
        && cd "$NETDISCO_HOME" \
        && tar xzf "$NETDISCO_HOME/netdisco-mibs-snapshot.tar.gz" \
        && rm -f "$NETDISCO_HOME/netdisco-mibs-snapshot.tar.gz"

# Install configuration
COPY processes.ini /etc/supervisord.d/
COPY init /
