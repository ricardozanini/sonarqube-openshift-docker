FROM redhat-openjdk-18/openjdk18-openshift

LABEL author="Ricardo Zanini <ricardozanini@gmail.com>"

ENV SONAR_VERSION=7.1 \
    SONARQUBE_HOME=/opt/sonarqube \
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL= 

USER root

RUN set -x \

    # pub   2048R/D26468DE 2015-05-25
    #       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
    # uid                  sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
    # sub   2048R/06855C1D 2015-05-25
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \

    && cd $HOME \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    && unzip sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION ${SONARQUBE_HOME} \
    && rm sonarqube.zip \
    && rm -rf ${SONARQUBE_HOME}/bin/* \
    && chown -R jboss:0 ${SONARQUBE_HOME} \
    && chmod -R g+rw ${SONARQUBE_HOME}

# Http port
EXPOSE 9000

# VOLUME "$SONARQUBE_HOME/data"

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/

ADD root /

RUN /usr/bin/fix-permissions $SONARQUBE_HOME \
&& chmod +x $SONARQUBE_HOME/bin/run.sh

USER jboss

CMD ["./bin/run.sh"]