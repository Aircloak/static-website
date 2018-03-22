Aircloak website
================

----------------------

- [What it is](#what-it-is)
- [Making changes to the website](#making-changes-to-the-website)
- [What it was](#what-it-was)

----------------------

# What it is

This repository contains a script that helps copy website changes from
our staging website to our productive website.

# Making changes to the website

To edit the website visit [https://www-stage.aircloak.com/wp-admin](https://www-stage.aircloak.com/wp-admin).
Once the website has been changed and works and looks as expected, run the
`aircloak-website-release.sh` found in this repository locally from your machine:

```
./aircloak-website-release.sh
```

It will migrate static assets as well as the database from the staging environment to the productive environment.

## Prerequisites

For the script to work you will need `ssh` and `scp` installed on your machine. A normal unix-like shell should be
sufficient. Furthermore you need to be able to ssh into the following machines using the following commands:

```
ssh root@acwww0.mpi-sws.org
ssh root@acwww1.mpi-sws.org
```

This might require that you setup tunnelling via contact.mpi-sws.org to work, since you can only ssh into these
machines from within the MPI network. On my machine I have an SSH config that looks like this:

```
$ cat ~/.ssh/config

Host acwww0.mpi-sws.org acwww1.mpi-sws.org
  IdentityFile ~/.ssh/mpi_rsa
  ProxyCommand ssh spe@contact nc %h %p 2> /dev/null
```

# What it was

This repository used to contain the source code of our website for local editing.
This mode of operation is no longer supported.
You can still browse the history of this repository for older versions of the website.
