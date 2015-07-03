# Setting up build environment

The following examples assume the container building and deployment happens on `acdocker1`.


## Local setup

Assuming the build server (where the git repository is hosted) is at `acdocker1`,
you will need to add the git repository as a remote.

This can be done with:

```bash
git remote add website <HOST>:/git/static-website.git
```

where `<HOST>` is `acdocker1` or `root@acdocker1.mpi-sws.org`, depending on
how you have configured you local ssh.


## Remote setup

In this initial setup, it is expected that both the build and hosting server
are the same, i.e. `acdocker1`.

On the host itself, create the repository that hosts the code, and receives git pushes,
as well as a local clone of it:

```bash
mkdir /git/static-website.git
cd /git/static-website.git
git init --bare
git symbolic-ref HEAD refs/heads/develop

mkdir -p /aircloak/
cd /aircloak
git clone /git/static-website.git
```

You now need to add a [post-update](post-update) git hook at `/git/static-website.git/hooks/post-update`.
This ensures that git pushes result in the creation and deployment of a new container.
The hook needs to be made executable with `chmod +x /git/static-website.git/hooks/post-update`.

The git hook expects the existence of an init script. Please create [/etc/init.d/static_website](static_website_initd),
and run `update-rc.d static_website defaults`. This way the site also automatically comes up when the system
reboots.

The site is accessed through nginx. Configure nging by adding a site [config](nginx.config) under
`/etc/nginx/sites-available/www.aircloak.com` and enable it with `ln -s
/etc/nginx/sites-available/www.aircloak.com /etc/nginx/sites-enables/`
After this you will have to reload nginx with `nginx -t && /etc/init.d/nginx reload`.
