Aircloak website
================

----------------------

- [What it does](#what-it-does)
- [Deploying](#deploying)

----------------------

# What it does

This repository contains the static version of the Aircloak.com website.

Only the files in the `site` folder are visible on the homepage itself.
Anything added outside of it, can not be served by the web-server.


# Deploying

The website is deployed as a static website behind nginx.
To deploy a new version you run either `./deploy.sh stage` or `./deploy.sh prod`,
depending on which version of the website you want to update.

The setup of `nginx` is not part of this repository, nor is the configuration
of correct certificates.
