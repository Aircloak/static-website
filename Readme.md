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

The website is automatically (periodically) updated from the `master` branch.
There is no need to manually deploy anything.

As there is no stage environment, please check the changes locally with the `./run.sh`
script before merging.
