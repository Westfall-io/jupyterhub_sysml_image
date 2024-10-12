FROM quay.io/jupyterhub/k8s-singleuser-sample:3.3.8

# To make multi architecture
# Push each architecture to latest-xxx64
# docker manifest create westfallio/jupyterhub_single_user:latest --amend westfallio/jupyterhub_single_user:latest-arm64 --amend westfallio/jupyterhub_single_user:latest-amd64

USER root
RUN apt-get update
RUN apt-get install -y npm wget curl unzip

# tests


# Have to download and install because apt-get is limited to 12.x
#RUN wget https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-arm64.tar.xz
#RUN mkdir -p /usr/local/lib/nodejs
#RUN tar -xJvf node-v18.17.1-linux-arm64.tar.xz -C /usr/local/lib/nodejs
#RUN . ~/.profile

# Install extensions
#RUN pip install jupyter_contrib_nbextensions
#RUN jupyter contrib nbextension install --sys-prefix
#RUN jupyter nbextension enable scratchpad/main --sys-prefix
#RUN jupyter labextension install jupyterlab-sos@0.10.4

# Run in one command to set npm to v18, otherwise git will fail to install with
# less than v16.
#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
#  && export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] \
#  && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \
#  && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
#  && nvm install 18.17.1 \
#  && nvm alias default 18.17.1 && jupyter labextension install --debug @jupyterlab/git@0.42.0
#RUN jupyter labextension install --debug @systems-modeling/jupyterlab-sysml
#RUN pip install jupyterlab-git==0.50.1 jupyterlab_sos==0.10.4
#RUN pip install sos sos-notebook sos-papermill sos-r
#RUN python -m sos_notebook.install
#RUN pip install sos-bash sos-javascript sos-julia sos-matlab sos-python
#RUN pip install octave_kernel

#SYSMLv2
RUN wget https://github.com/Systems-Modeling/SysML-v2-Pilot-Implementation/releases/download/2024-07/jupyter-sysml-kernel-0.43.2.zip
RUN unzip jupyter-sysml-kernel-0.43.2.zip -d /tmp \
  && python3 /tmp/install.py
RUN apt-get update && apt-get install -y openjdk-17-jdk openjdk-17-jre graphviz
RUN pip install graphviz
RUN apt-get install -y libvips-dev --no-install-recommends
RUN pip install pyvips

USER jovyan
#RUN pip install jupyterlab-git==0.42.0 jupyterlab_sos==0.9.0
