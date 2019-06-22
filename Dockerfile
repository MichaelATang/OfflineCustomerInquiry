# LICENSE UPL 1.0
#
# Copyright (c) 2014, 2019, Oracle and/or its affiliates. All rights reserved.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
#
# Dockerfile template for Oracle Instant Client
#
# HOW TO BUILD THIS IMAGE
# -----------------------
#
# Run:
#      $ docker build -t oracle/instantclient:19 .
#
# Note Instant Client 19 automatically configures the global library
# search path to include Instant Client libraries.
#
FROM oraclelinux:7-slim

ARG release=19
ARG update=3

RUN  yum -y install oracle-release-el7 && yum-config-manager --enable ol7_oracle_instantclient && \
     yum -y install oracle-instantclient${release}.${update}-basic oracle-instantclient${release}.${update}-devel oracle-instantclient${release}.${update}-sqlplus && \
     rm -rf /var/cache/yum

# Uncomment if the tools package is added
# ENV PATH=$PATH:/usr/lib/oracle/${release}.${update}/client64/bin

# Add necessary sql files
ADD ./sqlQueries/customerBioData.sql /home/customerBioData.sql
ADD ./sqlQueries/customerConsumptionData.sql /home/customerConsumptionData.sql
ADD ./sqlQueries/customerFinancialData.sql /home/customerFinancialData.sql

RUN mkdir /tmp/customerdata

# Execute queries to generate files
#RUN sqlplus testuser/testuser@172.17.0.1:32769/ORCLPDB1.localdomain @/home/customerBioData.sql
#RUN sqlplus testuser/testuser@172.17.0.1:32769/ORCLPDB1.localdomain @/home/customerConsumptionData.sql
#RUN sqlplus testuser/testuser@172.17.0.1:32769/ORCLPDB1.localdomain @/home/customerFinancialData.sql

#CMD ["sqlplus", "testuser/testuser@172.17.0.1:32769/ORCLPDB1.localdomain", "@/home/customerConsumptionData.sql"]
#CMD ["sqlplus", "testuser/testuser@172.17.0.1:32769/ORCLPDB1.localdomain", "@/home/customerFinancialData.sql"]
