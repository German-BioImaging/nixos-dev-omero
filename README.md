# nixos-dev-omero
NixOS configuration and HowTo for an out of the box setup to contribute to OMERO.web and plugins.


## Components

This development environment consists of two main components:

### 1. OMERO Server and PostgreSQL Database (Docker)
For development purpose, OMERO.web and plugins need a test server to connect to. This server doesn't have to be local, but it is nevertheless recommended.
The OMERO.server and PostgreSQL database are not yet part of this NixOS setup. You can however set them easily locally with Docker Desktop. 
See [openmicroscopy/omero-server on Docker Hub](https://hub.docker.com/r/openmicroscopy/omero-server) for instructions.

### 2. NixOS for OMERO.web Development
NixOS is used to run the OMERO.web development server from source, along with any plugins you're developing.
This repo provides configuration files for the NixOS that you will have to copy in the right folders. 
Once this is done, you will have all the necessary library and configurations to setup your omero-web python environment.
To work on a given project (omero-figure, omero-web, ...), clone your own fork of the corresponding Github repos, follow the setup instructions in the repo description, and voilà!

## Getting Started on Windows

Windows users can run NixOS using the Windows Subsystem for Linux (WSL). Here's how to get started:

### Setting up NixOS in WSL

1. **Install WSL**: Follow the [official Microsoft WSL installation guide](https://learn.microsoft.com/en-us/windows/wsl/install)
2. **Install NixOS on WSL**: Use [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) for a seamless NixOS experience on Windows
3. **Install Docker Desktop for Windows**: Download from [Docker's official website](https://www.docker.com/products/docker-desktop)
   - Enable WSL 2 integration in Docker Desktop settings

### Additional Resources
- [WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Docker on WSL 2](https://docs.docker.com/desktop/windows/wsl/)

## Using this repository in your NixOS

### Create an SSH key pair and link it with your Github account

[Github documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

### Clone the repository and copy environment files
The configuration files are in this repo that you can clone, however the configuration is needed to have git installed...
So start by copying the content of `nixos-dev-omero/initial/flake.nix` to `/etc/nixos/flake.nix`
vi is also not installed at this point, so you could use nano:
```
cd /etc/nixos
sudo mv configuration.nix configuration.nix.tmp  # this setup is not using configuration.nix
sudo nano flake.nix
# put inside the content of nixos-dev-omero/initial/flake.nix and save
sudo nixos-rebuild switch --flake .#
```

Finally we can clone the repo and add configuration to `.bashrc` and `.bash_profile`
```
git clone git@github.com:German-BioImaging/nixos-dev-omero.git

cd ~/nixos-dev-omero  # This repo
cat ./initial/.bashrc >> ~/.bashrc
cat ./initial/.bashr_profile >> ~/.bash_profile
```

Now we can cd into the repo folder and setup the environment. 
This will later be sourced each time you cd in this folder (you shouldn't repeat these steps or the previous once it's done).

```
direnv allow .
uv venv --python 3.12
source .venv/bin/activate
uv sync
```

## Setup OMERO.web and an example plugins

### OMERO.web

```
git clone git@github.com:ome/omero-web.git && cd omero-web
uv pip install -e .
omero config edit  # see below for an example configuration
```

You can already install the plugins. To develop them, you can clone their repo and `pip install -e .` each. (cf example below and respective repos for detailed specific instructions).
```
uv pip install omero-figure omero-autotag omero-tagsearch omero-iviewer
```
Then configure it and test that you can start OMERO.web (further configuration below).
More instructions [here](https://github.com/ome/omero-web?tab=readme-ov-file#developer-installation)



<details>
<summary>
Example omero-web config for the dev environment (!do not use for production!) with iviewer, figure, autotag and tagsearch.
</summary>

```
omero.config.version=5.1.0
omero.web.application_server=development
omero.web.apps=["omero_iviewer", "omero_figure", "omero_autotag", "omero_tagsearch"]
omero.web.caches={"default": {"BACKEND": "django.core.cache.backends.locmem.LocMemCache", "LOCATION": "unique-snowflake"}}
omero.web.cors_origin_allow_all=True
omero.web.debug=True
omero.web.middleware=[{"index": 1, "class": "django.middleware.common.BrokenLinkEmailsMiddleware"}, {"index": 2, "class": "django.middleware.common.CommonMiddleware"}, {"index": 3, "class": "django.contrib.sessions.middleware.SessionMiddleware"}, {"index": 4, "class": "django.middleware.csrf.CsrfViewMiddleware"}, {"index": 5, "class":"django.contrib.messages.middleware.MessageMiddleware"}, {"index": 6, "class": "django.middleware.clickjacking.XFrameOptionsMiddleware"}, {"index": 0.5, "class": "corsheaders.middleware.CorsMiddleware"}, {"index": 10, "class": "corsheaders.middleware.CorsPostCsrfMiddleware"}]
omero.web.open_with=[["Image viewer", "webgateway", {"supported_objects": ["image"], "script_url": "webclient/javascript/ome.openwith_viewer.js"}], ["omero_iviewer", "omero_iviewer_index", {"supported_objects": ["images", "dataset", "well"], "script_url": "omero_iviewer/openwith.js", "label": "OMERO.iviewer"}], ["omero_figure", "new_figure", {"supported_objects": ["images"], "target": "_blank", "label": "OMERO.figure"}]]
omero.web.server_list=[["localhost", 4064, "omero"], ["omero-nfdi.uni-muenster.de", 4064, "nfdi"], ["wss://omero-training.gerbi-gmb.de/omero-wss", 443, "gerbi-wss"]]
omero.web.ui.center_plugins=[["Auto Tag", "omero_autotag/auto_tag_init.js.html", "auto_tag_panel"]]
omero.web.ui.top_links=[["Data", "webindex", {"title": "Browse Data via Projects, Tags etc"}], ["History", "history", {"title": "History"}], ["Help", "https://help.openmicroscopy.org/", {"title": "Open OMERO user guide in a new tab", "target": "new"}], ["Figure", "figure_index", {"title": "Open Figure in new tab", "target": "_blank"}], ["Tag Search", "tagsearch"]]
omero.web.viewer.view=omero_iviewer.views.index
```
</details>

### OMERO.figure

```
git clone git@github.com:ome/omero-figure.git && cd omero-figure
uv pip install -e .
npm install
npm run build
```
OMERO.figure should then be the dev version from the cloned repo. See the repo for more detailed instructions.




## Acknowledgements
Originally made by @wiessall during the de.NBI hackathon 2025.
Tested and corrected by @Tom-TBT
