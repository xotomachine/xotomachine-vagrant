# Official "development box" :computer:

## Introduction :bookmark:

This is a [Vagrant](https://www.vagrantup.com/) configuration to set up a complete, virtualized development environment.

1. [Usage](#usage) :gift:
2. [Installation](#setup) :rocket:
3. [Customize your virtual machine](#customize) :wrench:

## <a name="usage"></a> Usage :gift:

The "development box" requires to have [Vagrant](https://www.vagrantup.com/) installed on your machine.

It is fully based on Open Source software, and most importantly on:

- Ubuntu
- OpenJDK (Oracle JDK can't be used because of license issues)
- Node, NPM and Yarn
- mvn, brew
- Docker and Docker Compose

This "development box" also have all client applications useful for working with a databases application:

- postsql
- MongoDB client

## <a name="setup"></a> Installation :rocket:

This generates a new "development box" directly from this repository.

- Clone this repository: `git clone https://github.com/xotosphere/ubunutu-machine.git`
- Run

```
cd ubuntu-machine-vm
vagrant up
```

## <a name="customize"></a> Customize your virtual machine :wrench:

This is very important! Modify your system properties, depending on your host's hardware. We recommend, at least:

- 4 CPUs
- 8 Gb of RAM
- 128 Mb of video RAM
