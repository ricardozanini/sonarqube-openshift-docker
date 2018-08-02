FROM redhat-openjdk-18/openjdk18-openshift

LABEL author="Ricardo Zanini <ricardozanini@gmail.com>" \
 summary="Container image for SonarQube based on Red Hat OpenJDK base image" \
 io.k8s.description="Container image for SonarQube based on Red Hat OpenJDK base image" \
 io.k8s.display-name="SonarQube" \
 url="https://hub.docker.com/r/ricardozanini/sonarqube/" \
 name="ricardozanini/sonarqube" \
 maintainer="Ricardo Zanini <ricardozanini@gmail.com>" \
 usage="Reference for building your own Sonarqube image" 

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

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/

RUN chmod +x $SONARQUBE_HOME/bin/run.sh

USER jboss

CMD ["./bin/run.sh"]