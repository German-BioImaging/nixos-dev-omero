# nixos-dev-omero
NixOs configutation and HowTo for an out of the box setup to contribute to OMERO.web and plugins

## Components

This development environment consists of two main components:

### 1. OMERO Server and PostgreSQL Database (Docker)
The OMERO server and PostgreSQL database run in Docker containers using the official OMERO server image. This provides a stable and isolated backend for development.

- **Recipe source**: [openmicroscopy/omero-server on Docker Hub](https://hub.docker.com/r/openmicroscopy/omero-server)
- The containerized setup ensures consistent behavior across different development environments
- Handles all data storage, metadata management, and server-side operations

### 2. NixOS for OMERO.web Development
NixOS is used to run the OMERO.web development server from source, along with any plugins you're developing.

- Provides a reproducible development environment
- Allows running OMERO.web from source for easy debugging and development
- Supports plugin development with hot-reloading capabilities
- Ensures all dependencies are properly managed and isolated

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
