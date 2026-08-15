StarGaze Bootstrap Installer
============================

The bootstrap downloads the current StarGaze installer from GitHub and executes it with loadstring. The destination is controlled by one setting in the bootstrap file.

Configuration
-------------

Open StarGazeBootstrap.server.lua and edit:

    InstallPath = "ReplicatedStorage.StarGaze"

Examples:

    InstallPath = "ReplicatedStorage.StarGaze"
    InstallPath = "ReplicatedStorage.UI.StarGaze"
    InstallPath = "ServerScriptService.StarGaze"
    InstallPath = "StarterPlayer.StarterPlayerScripts.StarGaze"

Every parent in the path must already exist. The final StarGaze object is created or replaced by the installer.

Setup
-----

1. Enable Game Settings > Security > Allow HTTP Requests.
2. Enable ServerScriptService.LoadStringEnabled.
3. Put StarGazeBootstrap.server.lua in a server-side location while installing from Studio.
4. Set CONFIG.InstallPath.
5. Run the bootstrap.

The bootstrap fetches:

https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua

Updating
--------

Run the same bootstrap again. The installer removes the existing StarGaze installation at the configured location and installs the latest source from the repository.

Security
--------

The bootstrap intentionally executes remotely downloaded Luau. Only use it with a repository and URL you control or trust. For published production games, pinning a release or committing a local installer is safer than executing a mutable branch.
