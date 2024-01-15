# dooocus
Fooocus by lllyasviel on docker

# Building your own version
To successfully build your own image, based on the available cuda version of your nvidia graphics card, it's possible to locally clone this repository and change the Dockerfile to allow graphics cards with old drivers to run this application. Consider that this has been tested only on a few versions and might require some work to get it to run. When testing the modified build it's recommended to download locally the Juggernaut stable diffusion model used by fooocus and map that drive to the models folder. This will cut the preparation time by skipping the download step. To change version, it's necessary to change the pytorch tag in the Dockerfile and then run the docker build.
Available pytorch tags can be found here:
https://hub.docker.com/r/pytorch/pytorch/tags

The minimum pytorch version is 2.0.0, which would make the minimum nvidia cuda driver version 11.7.
Hopefully you can find this helpful

## Important!
This is not an activly mantained repository. I've made so that the docker image will run the 'entry_with_update.py' on startup, to keep the fooocus application updated. This however may break compatibility with new updates made to pytorch. To solve this, it's possible to change the CMD command in the Dockerfile to:
CMD ['python3', 'launch.py', '--listen']
This will run the latest downloaded version of fooocus and, as long as at the time of testing it works, it will work indefinitely, skipping the update process.
