## Bootstrap Installer

StarGaze includes a bootstrapper that can download and run the latest Studio installer from GitHub.

1. Open `StarGazeBootstrap.server.lua`.
2. Set `CONFIG.InstallPath` to the desired location.
3. Enable **Allow HTTP Requests** in Game Settings > Security.
4. Enable `ServerScriptService.LoadStringEnabled`.
5. Run the bootstrap from a Server Script in Studio.

```lua
local CONFIG = {
    InstallPath = "ReplicatedStorage.StarGaze",
    InstallerUrl = "https://raw.githubusercontent.com/Starlight-Solutions-Inc/StarGaze/main/tools/InstallInStudio.lua",
}
```

The bootstrap fetches the installer and executes it with `loadstring`, allowing the same bootstrap to update StarGaze when the repository changes.
