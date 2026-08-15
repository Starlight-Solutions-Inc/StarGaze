STAR GAZE STUDIO BOOTSTRAP

1. Open Roblox Studio.
2. Enable Game Settings > Security > Allow HTTP Requests.
3. Open View > Command Bar.
4. Paste the contents of Bootstrap.lua.
5. Change InstallPath if you want a different destination.
6. Run the command.

The bootstrap downloads the current InstallInStudio.lua file from the StarGaze GitHub repository. The installer downloads the framework source, verifies that every Lua file can be retrieved, and only then replaces the existing installation.

Default:
InstallPath = "ReplicatedStorage.StarGaze"
Mode = "Auto"

Modes:
Auto   = install when missing, update when present
Install = install only; refuses to overwrite
Update  = update only; requires an existing installation

After installation:
local StarGaze = require(game.ReplicatedStorage.StarGaze)

Use the bootstrap only in Studio. It is not intended to modify ModuleScript.Source from a live published server.
