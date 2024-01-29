FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]

# Arguments
ARG USER_ID

# Env variables
ENV MPLCONFIGDIR=/matplt_cache

RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y libgl1-mesa-glx libglib2.0-0 libsm6 libxrender1 libxext6 python3 python3-pip git && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Creating all the folders needed for this app
RUN useradd -u $USER_ID foooser && git clone https://github.com/lllyasviel/Fooocus.git && mv Fooocus/ /fooocus/ && \
    mkdir /matplt_cache && chown -R foooser /matplt_cache && chmod -R 0760 /matplt_cache && \
    mkdir /home/foooser/ && chown -R foooser /home/foooser && chmod -R 0760 /home/foooser && \
    chown -R foooser /fooocus && chmod -R 0760 /fooocus

RUN touch /home/foooser/.bashrc && echo "export PATH=$PATH:/home/foooser/.local/bin" >> ~/.bashrc

WORKDIR /fooocus
USER foooser

RUN pip3 install --no-cache --no-warn-script-location -r requirements_versions.txt

EXPOSE 7865

ENTRYPOINT [ "python3", "entry_with_update.py"]
CMD [ "--listen" ]