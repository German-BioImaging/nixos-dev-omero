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

### Clone the repository and copy environment files

## Acknowledgements
Originally made by @wiessall during the de.NBI hackathon 2025.
Tested by @Tom-TBT
