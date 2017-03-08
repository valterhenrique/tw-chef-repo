# Overview

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

* Install it using pip:

    sudo pip install awscli

* Or, install it using apt-get:

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

Go to EC2 Dashboard, on the left side bar, look for 'NETWORK & SECURITY', then 'Key Pairs'.
Create a key pair, and save it at '~/.ssh/aws-vasi.pem'

(I've tried generating this key pair using `Kitchen EC2` but it [didn't work for me](https://github.com/test-kitchen/kitchen-docker/issues/202).)

## Configure Security Groups

Create a security groups that allows ports: 22, 8000, 8001, 8002.
In my example, I've created two security groups for this purpose, their IDs are: sg-50ff3f3b, sg-61a6650a.

## Kitchen EC2

Install/Configure [kitchen ec2 plugin](https://github.com/test-kitchen/kitchen-ec2#initial-setup)


# Repository Directories

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

- `cookbooks/` - Cookbooks you download or create.
- `data_bags/` - Store data bags and items in .json in the repository.
- `roles/` - Store roles in .rb or .json in the repository.
- `environments/` - Store environments in .rb or .json in the repository.

# Configuration

The config file, `.chef/knife.rb` is a repository specific configuration file for knife. If you're using the Chef Platform, you can download one for your organization from the management console. If you're using the Open Source Chef Server, you can generate a new one with `knife configure`. For more information about configuring Knife, see the Knife documentation.

<https://docs.chef.io/knife.html>

# Next Steps

Read the README file in each of the subdirectories for more information about what goes in those directories.
