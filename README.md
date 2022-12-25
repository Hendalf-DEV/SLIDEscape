
# SLIDEscape

SLIDEscape is simple and modern escape menu for Garry's Mod communities


## Installation

How to install addon?

```bash
  Download "SLIDEscape" folder
  Drag and put it into the addons folder that is at "garrysmod\addons"
  Edit configuration file! It's called "sh_config.lua", it can be found under the "config" named folder.
```

Default config file looks like

```lua

SLIDEs = SLIDEs or {}


SLIDEs.Config = SLIDEs.Config or {}


SLIDEs.Config.UseLogo = true
SLIDEs.Config.Logo = "https://i.imgur.com/4RT6LMO.jpg" -- This is your logo URL. It can be whatever you want. But I reccomend using IMGUR
SLIDEs.Config.CacheLogo = "your_server_name/logo.png" -- This is not necessary to be changed, but if you want, you can change the "your_server_name" to something other

SLIDEs.Config.BG = "blur"

SLIDEs.Config.SideColor = Color(36,36,36)

SLIDEs.Config.BGColor = Color(31,29,29) --Works only if you change background to use COLOR instead of blur

SLIDEs.Config.time = 0.6 --Change this to change animation length
SLIDEs.Config.delay = 0 --This is not necessary to edit, leave this as it is.
SLIDEs.Config.ease = 0.6 -- Change this to change animation smoothness


--Max amount of buttons is 7

SLIDEs.Config.Nav =
{
    
    {
        Enabled = true,
        Name = "Play",
        icon = "https://i.imgur.com/d93Aze2.png",
        cachepath = "your_server_name/play.png",
        OnLoadInit = false,
        Visible = function(ply) return true end,
        ColorBase = Color(19, 19, 19, 159),
        ColorHover = Color( 0, 0, 0, 100 ),
        ColorText = Color( 255, 255, 255, 255 ),
        ColorImage = Color(255,255,255,255),
        DoFunc = function()
            SLIDEs:Start()
        end
    },
    {
        Enabled = true,
        Name = "SETTINGS",
        icon = "https://i.imgur.com/mFQ0l3I.png",
        cachepath = "your_server_name/settings.png",
        OnLoadInit = false,
        Visible = function(ply) return true end,
        ColorBase = Color(19, 19, 19, 159),
        ColorHover = Color( 0, 0, 0, 100 ),
        ColorText = Color( 255, 255, 255, 255 ),
        ColorImage = Color(255,255,255,255),
        DoFunc = function()
            if IsValid( SLIDEs.Menu ) then
                SLIDEs:Start()
                isSLIDEscapeAct = false
            else
                SLIDEs:Start()
            end
            RunConsoleCommand("gamemenucommand", "openoptionsdialog")
            RunConsoleCommand("gameui_activate")
        end
    },
    {
        Enabled = true,
        Name = "Your Webiste name",
        WebEnabled = true,
        OnLoadInit = false,
        WebURL = "https://discord.gg/UR5Cr7xG",
        icon = "https://i.imgur.com/xu6gOqI.png",
        cachepath = "your_server_name/website.png",
        Visible = function(ply) return true end,
        ColorBase = Color(19, 19, 19, 159),
        ColorHover = Color( 0, 0, 0, 100 ),
        ColorText = Color( 255, 255, 255, 255 ),
        ColorImage = Color(255,255,255,255),
    },
    {
        Enabled = true,
        Name = "DISCONNECT",
        icon = "https://i.imgur.com/CZlBwZA.png",
        OnLoadInit = false,
        cachepath = "your_server_name/disconnect.png",
        Visible = function(ply) return true end,
        ColorBase = Color(19, 19, 19, 159),
        ColorHover = Color( 0, 0, 0, 100 ),
        ColorText = Color( 255, 255, 255, 255 ),
        ColorImage = Color(255,255,255,255),
        DoFunc = function()
            RunConsoleCommand("disconnect")
        end
    },
}



```
    
## Authors

- [@Hendalf-DEV](https://github.com/Hendalf-DEV)


## License

[MIT](https://choosealicense.com/licenses/mit/)


![EvoDevelopment](https://i.imgur.com/IlGiTug.png)

