Aircloak website
================

----------------------

- [What it does](#what-it-does)
- [View locally](#view-locally)
- [Deploying](#deploying)

----------------------

# What it does

This repository contains the static version of the Aircloak.com website.

Only the files in the `site` folder are visible on the homepage itself.
Anything added outside of it, can not be served by the web-server.


# View locally

To view the website locally, to verify that your changes had the desired effect,
run the `./run.sh` script. It will start a static web server, making the website
available under `http://localhost:8000`.


# Deploying

The website is deployed as a static website behind nginx.
To deploy a new version you run either `./deploy.sh stage` or `./deploy.sh prod`,
depending on which version of the website you want to update.

The setup of `nginx` is not part of this repository, nor is the configuration
of correct certificates.
