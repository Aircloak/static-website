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
