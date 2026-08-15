# StarGaze Bootstrap

The bootstrap is intentionally small. It downloads **one installer file from GitHub**, executes it with `loadstring`, and passes the configuration to that installer. The installer then discovers the current StarGaze source tree and installs or updates the framework in Studio.

## Bootstrap

Place this in a Studio server-side Script and change only the settings you need:

```lua
local HttpService = game:GetService("HttpService")

local CONFIG = {
    InstallPath = "ReplicatedStorage.StarGaze",
    Mode = "Auto",
    InstallerUrl = "https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua",
}

local source = HttpService:GetAsync(CONFIG.InstallerUrl, false)
local installer = assert(loadstring(source, "StarGazeInstaller"))
installer(CONFIG)
```

## Modes

`Auto` creates StarGaze when it is missing and replaces the existing installation when it is already present.

`Install` only installs when the destination does not already exist.

`Update` only updates an existing installation.

## Custom locations

```lua
InstallPath = "ReplicatedStorage.StarGaze"
```

```lua
InstallPath = "ReplicatedStorage.UI.StarGaze"
```

```lua
InstallPath = "ServerScriptService.StarGaze"
```

Intermediate folders are created automatically when they do not already exist.

## Requirements

Enable **Game Settings → Security → Allow HTTP Requests**.

The bootstrap uses `loadstring` because it is intended as a Studio bootstrapper. Do not execute mutable remote code in production unless you control and trust the source.
