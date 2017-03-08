# Overview

Deploy a MVP to the cloud using Infrastructure as Code.

## CHEF DK

Install/Configure [Chef DK](https://docs.chef.io/install_dk.html).
I've also developed this [script](https://gist.github.com/valterhenrique/b0d2039ca58bf5bcc81ac25b74fb52cb) on Ubuntu to ease this step.

## AWS

* Create an account on AWS
* Create an user with programmatic access
* Give to her/him access to EC2 services.
* Download the generated credentials

It should look like this:

    User name,Password,Access key ID,Secret access key,Console login link
    username,,AAA,BBB,https://AWS_ACCOUNT_ID.signin.aws.amazon.com/console

### Install AWS CLI.

On Ubuntu:

Install it using pip:

    sudo pip install awscli  

Or, install it using apt-get:

    sudo apt-get install -y awscli

You can test it by typing:

    aws --version

The output should be similar to:

    aws-cli/1.11.58 Python/2.7.12 Linux/4.4.0-65-generic botocore/1.5.21

### Configure AWS CLI

    $ aws configure
    AWS Access Key ID [None]: AAA
    AWS Secret Access Key [None]: BBB
    Default region name [None]: eu-central-1
    Default output format [None]: json

### Create a key pair

Go to EC2 Dashboard, on the left side bar, look for `NETWORK & SECURITY`, then `Key Pairs`.
Create a key pair, and save it at `~/.ssh/aws-vasi.pem` (`TODO`: Make an environment variable ?)

(I've tried generating this key pair using `kitchen EC2` but it [didn't work for me](https://github.com/test-kitchen/kitchen-docker/issues/202)

## Configure Security Groups

Create a security groups that allows ports: `22`, `8000`, `8001`, `8002`.
In my example, I've created two security groups for this purpose, their IDs are: `sg-50ff3f3b`, `sg-61a6650a`.

## Kitchen EC2

Install/Configure [kitchen ec2 plugin](https://github.com/test-kitchen/kitchen-ec2#initial-setup)

## Run

After ChefDK, AWS and Kitchen EC2 are configured, type:

    cd cookbooks/tw-mvp/
    kitchen converge

This will create a new ec2 instance on AWS EC2 service, bootstrap it using `run_list`

After that, you can access the machine by typing:

    kitchen login

You can do `curl` commands in order to test if the application is running:

    curl http://localhost:8001

To view the logs:

    sudo journalctl -u mvp_frontend
    sudo journalctl -u mvp_quote
    sudo journalctl -u mvp_newsfeed


You can access our application remotely by accessing `http://<ec2-public-ip-or-public-dns>:8001/`

    http://35.157.178.25:8001
    http://ec2-35-157-178-25.eu-central-1.compute.amazonaws.com:8001


You can also reboot the server, that our MVP application will start automatically.

## Repository Directories

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

- `cookbooks/` - Cookbooks you download or create.
- `data_bags/` - Store data bags and items in .json in the repository.
- `roles/` - Store roles in .rb or .json in the repository.
- `environments/` - Store environments in .rb or .json in the repository.

## Next Steps

Read the README file in each of the subdirectories for more information about what goes in those directories.

## Future Work

### Extend

Develop future cookbooks/recipes using the base recipe, `tw-base`, to ensure that all systems have a minimal common setup, regarding packages, security, users, etc.

### Security

Ensure that our systems are secure and compliant using a tool like [Chef Compliance](https://www.chef.io/solutions/compliance/) for example. Continue to evolve our tests regarding [inspec](inspec.io), making sure that our system are secure and stable.

### Continuous Delivery

Create a box/template/ami in order to speed deployments. Create/deploy using containers, perhaps our application requirements can be deployed faster.

### Monitoring

After a server have been deployed to production, it should be added automatically into a monitoring system, like [Amazon CloudWatch](https://aws.amazon.com/cloudwatch) or many others like Nagios(https://nagios.com), or Zabbix (http://www.zabbix.com/), etc.

### Team

In order to engage the team, I would identify the most painful problem that they have at the moment. Present to them some tools and practices explaining how we could solve the problem. We might need to study the tools in depth in order to make a more accurate decision regarding which tool will work better for us, and for a certain project/customer, on the short/long term.

## License and Maintainer

Maintainer:: Valter Henrique (valterhenrique85@gmail.com)

License:: All rights reserved
