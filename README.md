# Mikrotik point to point wireless configuration

This guide explains how to configure you Mikrotik devices to be used as wireless point-to-point link.
These configurations have been tested two SXTsq 5 ac devices.

## Overview of point-to-point

In point-to-point connection, one of the devices acts as a server and the other one as a client.
After the connection has been established, the server and client roles don't matter.
Both devices can send and receive data.
The bridge is the server device and the station bridge is the client.
The bridge creates an acceppoint where the station bridge will connect to.
The configurations are decided by the bridge.
After the connection has been established between the bridge and station bridge,
both devices will transparently forward traffic wirelessly over the link.

## Installing the configurations

### Upload the configuration
Use Webfig or WinBox
Upload the file to the device:
Files - Upload... or drag it.
Note! the file has to be in the flash folder.

### Take the configuration into use
System - Reset Configuration - Run After Reset (the file you uploaded)

