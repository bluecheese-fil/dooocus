FROM pytorch/pytorch:latest
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y libgl1-mesa-glx libglib2.0-0 libsm6 libxrender1 libxext6 python3 python3-pip git && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Creating all the folders needed for this app
RUN useradd foooser && mkdir /home/foooser/ && git clone https://github.com/lllyasviel/Fooocus.git && mv Fooocus/ /fooocus/ && chown -R foooser:foooser /home/foooser && \
    chown -R foooser:foooser /fooocus && chmod -R 0777 /fooocus
    

WORKDIR /fooocus

RUN pip3 install --no-cache -r requirements_versions.txt

USER foooser
EXPOSE 7865

CMD [ "python3", "entry_with_update.py", "--listen" ]