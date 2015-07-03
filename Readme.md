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

The website is deployed using docker, and git post-commit hooks.
If everything is [setup](setup/initial-setup.md) correctly, you can push changes with the command `git push website develop`.

You can also test the site locally by running `./build.sh; ./run.sh` from the root folder.
If successful, the website is available under `http://localhost:10000` (or http://$(boot2docker ip):10000 if
you are on OSX).
