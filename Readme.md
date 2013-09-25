Aircloak website
----------------

This repository contains the static version of the Aircloak.com website.
Later when we move to a dynamic website where customers can sign up for our
services, or where they can log in to some sort of web interface, this
site, and repository, is likely to cease existing in its current form.

# Files available on the website

Only the files in the `site` folder are available on the homepage. This
folder is the so called webroot pointed to by our webserver. Anyting you put
outside that folder is not going to be accessible on the webserver.

Why don't we just make the site folder the root folder of the repository?
The reason is that then this readme file, along with all our git metadata
would also become available to our website visitors. We do not want that.

# How do I get my changes onto the website?

This is rather cool and funky. Once you have it working (and once you
like git), you are going to think it is awesome.

## Short version

We use git to deploy our website. Add
`root@hannibal.mpi-sws.org:/git/www.aircloak.com` as a remote to your 
git repo and push to it to make changes appear on the website.
Only changes in the master branch will be available on the site.

## Long version

We use git to deploy our website.
The website is hosted on a machine called hannibal.


### Accessing the machine

Please make sure you are able to SSH into the machine as root.
If you are not, then deploying is not going to work either.

Try:

    ssh root@hannibal.mpi-sws.org

If that does not work, then check one of the following things might be
wrong: 

1) maybe you don't have your key uploaded onto hannibal?
2) maybe you are not using your default key on hannibal?
3) maybe you need a proxy to get to hannibal?

1) if you don't have your key on hannibal then the way to solve this
is to email your public key to the `servicedesk@mpi-sws.org` and request
it be added. They only support a single root key per user, so if you
already have a key with them, then you either need to ask for that key
to be added to hannibal, or look at 2) for information about how
to use it.

2) if your root key in the MPI-SWS system is not your id_rsa key
(which is what git uses by default when logging into remote hosts),
then you need to configure SSH to use the correct key.
You do this by adding to your `~/.ssh/config` file.

Add something along the lines of:

    Host hannibal.mpi-sws.org
      Hostname hannibal.mpi-sws.org
      User root
      IdentityFile [PATH-TO-YOUR-PRIVATE-KEY]

This will instruct SSH (which git relies on for transport) to
use the correct key when logging onto hannibal as root.

You should of course replace `[PATH-TO-YOUR-PRIVATE-KEY]` with
the path to your private key that is the root key with MPI-SWS.

3) Hannibal is setup so that it cannot be connected to from outside MPI. This
is safe and good, of course :) When you are far from home (MPI) you won't be
able to push the website directly though, which is a bloody pain. This can,
fortunately, be solved through some additional ssh config magic. What you want
to do is to add a proxy command. Make your ~/.ssh/config file look something
like this:

    Host hannibal.mpi-sws.org hannibal
      User root
      IdentityFile [PATH-TO-YOUR-PRIVATE-KEY]
      HostName hannibal.mpi-sws.org
      ProxyCommand ssh [YOUR-USER-NAME]@contact.mpi-sws.org nc %h %p 2> /dev/null

The commands above log you in to the contact.mpi-sws.org server before, logging
on to hannibal from there! Pretty magical.

-----

Now please try to log in with SSH again. If it still doesn't work, then 
I am not sure what is the problem.

### Adding the remote

Now that you can access the webserver itself through SSH, we need to
add it as a remote to your git repository.

Please execute the following command:

    git remote add website root@hannibal.mpi-sws.org:/git/www.aircloak.com

You can replace **website** with anything you want. It becomes the name
of the remote destination for the webserver.

### Making your changes visible on the server

Now, whenever you have made changes to the website (we assume you follow
the normal git practises we have established at aircloak with branches
and pull requests), you can push the changes to the webserver using:

    git push website master

**website** should be replaced with whatever you named the remote target.

If all the steps above worked, then this is likely to work as well :)
The site should now be available online, for yours, and others, viewing
pleasure.
