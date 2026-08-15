StarGaze Bootstrap
==================

The bootstrap is the only file you need to run. It downloads InstallInStudio.lua from the StarGaze GitHub repository and executes it with loadstring. The downloaded installer is responsible for discovering the repository files, creating the ModuleScript hierarchy, and installing or updating StarGaze.

Configuration
-------------

InstallPath controls where StarGaze is placed.

    InstallPath = "ReplicatedStorage.StarGaze"

Other examples:

    InstallPath = "ReplicatedStorage.UI.StarGaze"
    InstallPath = "ServerScriptService.StarGaze"

Mode controls the behavior:

    Mode = "Auto"

Auto installs when missing and updates when already installed.

    Mode = "Install"

Install only; fails if the destination already exists.

    Mode = "Update"

Update only; fails if the destination does not exist.

Requirements
------------

Enable Game Settings > Security > Allow HTTP Requests.

Usage
-----

Run StarGazeBootstrap.server.lua from Studio. The bootstrap fetches the current installer from:

https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua

Run the same bootstrap again to receive the current StarGaze source from GitHub.
