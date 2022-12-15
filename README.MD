# RHSSO_Custom_Cache_Owners

1- Clone or download the Dockerfile in your environment:

~~~
git clone https://github.com/juanviz/RHSSO_Cache_Owners_2.git
~~~

2- Pull SSO image from Red Hat Containers Images Catalog https://catalog.redhat.com/software/containers/explore
~~~
podman login registry.redhat.io
Username: {REGISTRY-SERVICE-ACCOUNT-USERNAME}
Password: {REGISTRY-SERVICE-ACCOUNT-PASSWORD}
Login Succeeded!

podman pull registry.redhat.io/rh-sso-7/sso76-openshift-rhel8:7.6-15
~~~


3- Build the custom image using the Dockerfile (You must be located in the directory where is the Dockerfile):

~~~
podman build -t juanviz/sso76-openshift-rhel8-custom-owners-2 .
~~~

4- Now the image is ready to use: 
~~~
$ podman images
REPOSITORY                                         TAG               IMAGE ID      CREATED        SIZE
registry.redhat.io/rh-sso-7/sso76-openshift-rhel8  7.6-15            ad41a6c03dfc  8 days ago     1.1 GB

~~~

5- Can be copied to an image Repository to make it able to be pulled from any location. 
   In this case the image is moved to my quay.io account (Same method applies to DockerHub):

~~~
$ podman push localhost/juanviz/sso76-openshift-rhel8-custom-owners-2 quay.io/juaherre/sso76-openshift-rhel8-custom-owners-2

~~~

## Importing the image in Openshift

1- Log in into the Openshift platform and move to openshift project:

~~~
oc project openshift
~~~

2- Import the image from the container repository:

~~~
oc import-image sso76-openshift-rhel8-custom-owners-2 --from quay.io/juaherre/sso76-openshift-rhel8-custom-owners-2 --confirm
~~~

3- Verify the new imagestream:

~~~
oc get is | grep sso76-openshift-rhel8-custom-owners-2
sso76-openshift-rhel8-custom-owners-2                 default-route-openshift-image-registry.apps.cluster-v8vtx.v8vtx.sandbox2332.opentlc.com/openshift/sso76-openshift-rhel8-custom-owners-2                 latest                                                   11 minutes ago
~~~

4- Now the image is available to be used into the namespaces and templates
