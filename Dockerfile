# dockerfile to build image SSO 7.x

#start from base image
FROM registry.redhat.io/rh-sso-7/sso76-openshift-rhel8

#Edit owners amount in standalone-openshift.xml
RUN sed -i -E 's/CACHE_OWNERS_COUNT:1/CACHE_OWNERS_COUNT:2/g' /opt/eap/standalone/configuration/standalone-openshift.xml
RUN sed -i -E 's/CACHE_OWNERS_AUTH_SESSIONS_COUNT:1/CACHE_OWNERS_AUTH_SESSIONS_COUNT:2/g' /opt/eap/standalone/configuration/standalone-openshift.xml

# Important, use numeric user user to run image in Kubernetes/Openshift. Other containerized env can run with another user i. e., jboss
USER 1001
