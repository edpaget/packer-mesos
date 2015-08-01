## Packer

Packer (http://packer.io) is an open source tool for creating machine images.

We use Packer to create VirtualBox images and Amazon Machine Images (AMIs), which are then distributed as Vagrant Boxes on [Vagrant Cloud](https://atlas.hashicorp.com/edpaget/boxes/mesos).

This has been modified from the [original](https://github.com/mbabineau/cloudformation-mesos) to

+ use apt for managing the installed version of Mesos and Docker
+ use upstart instead of runit to manage Mesos and Docker daemons
+ remove Logstash dependencies 
+ produce Vagrant boxes using [Atlas](https://atlas.hashicorp.com).

### Installation

Instructions here: http://www.packer.io/docs/installation.html

### Usage

To build an AMI or VirtualBox image, make sure your keys are set or you've configured the [AWS Command Line Tools](http://aws.amazon.com/cli/):
```
$ export AWS_ACCESS_KEY_ID="<your_access_key>"
$ export AWS_SECRET_ACCESS_KEY="<your_secret_key>"
```

Then, run `packer build <template>`:
```
$ packer build -var ami_prefix=<mycompany> ubuntu-14.04-mesos.json
```

To only build the VirtualBox image:
```
$ packer build --only=virtualbox-iso ubuntu-14.04-mesos.json
```

To only build the AMI:
```
$ packer build --only=amazon-ebs ubuntu-14.04-mesos.json
```

Build times are typically 5-15 minutes plus another 10-20 minutes to replicate to other regions. You should see streamed output like this:
```
$ packer build -var ami_prefix=mbabineau ubuntu-14.04-mesos.json
amazon-ebs output will be in this color.

==> amazon-ebs: Inspecting the source AMI...
==> amazon-ebs: Creating temporary keypair: packer 55304cd7-343f-cbe0-7d08-3875e6dcf1d6
==> amazon-ebs: Creating temporary security group for this instance...
==> amazon-ebs: Authorizing SSH access on the temporary security group...
==> amazon-ebs: Launching a source AWS instance...
    amazon-ebs: Instance ID: i-0ad312c1
==> amazon-ebs: Waiting for instance (i-0ad312c1) to become ready...
==> amazon-ebs: Waiting for SSH to become available...
==> amazon-ebs: Connected to SSH!
==> amazon-ebs: Uploading include/ => /tmp/
==> amazon-ebs: Provisioning with shell script: /var/folders/01/8gq4dvp57bs9hlyh0dxpkr140000gn/T/packer-shell373313770
    amazon-ebs: Ign http://security.ubuntu.com trusty-security InRelease
    amazon-ebs: Get:1 http://security.ubuntu.com trusty-security Release.gpg [933 B]
[... REMOVED FOR BREVITY ...]
==> amazon-ebs: Adding tags to AMI (ami-f26ca9f2)...
    amazon-ebs: Adding tag: "os:distribution": "Ubuntu"
    amazon-ebs: Adding tag: "os:release": "14.04 LTS"
    amazon-ebs: Adding tag: "mesos:version": "0.21.1"
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' finished.

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:

ap-northeast-1: ami-f26ca9f2
ap-southeast-1: ami-50467b02
ap-southeast-2: ami-79542943
eu-west-1: ami-99fc9cee
sa-east-1: ami-3944c124
us-east-1: ami-0a878262
us-west-1: ami-494eac0d
us-west-2: ami-734a7f43
```

### Credit

This is almost entirely based on Mike Babineau's [cloudformation-mesos](https://github.com/mbabineau/cloudformation-mesos) and used Nathan Sullivan's [packer ubuntu](https://github.com/CpuID/packer-ubuntu-virtualbox) to get up and running with the VirtualBox builds.


### License

Available under an MIT-style License see [LICENSE](https://github.com/edpaget/packer-mesos/tree/master/LICENSE) for details
