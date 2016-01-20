FROM java:8

ENV SCALA_VERSION 2.11.7
ENV SBT_VERSION 0.13.9

# Install Scala
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
ENV SBT_JAR      https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar

ADD  $SBT_JAR  /usr/local/bin/sbt-launch.jar  
COPY sbt.sh    /usr/local/bin/sbt
RUN chmod u+x  /usr/local/bin/sbt


RUN echo "==> run sbt for first time & fetch all jars files"  && \
    echo "==> [CAUTION] this may take several minutes!!!"  && \
    sbt

# Define working directory
WORKDIR /root

# Define default command.
ENTRYPOINT ["sbt"]
CMD ["--version"]