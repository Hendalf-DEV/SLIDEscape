

--[[local PANEL = {}

function PANEL:Init()
    local ply = LocalPlayer()

    SLIDEs.Init = self
    SLIDEs.Init:Dock(FILL)
    SLIDEs.Init:DockMargin(0,0,0,0)
    SLIDEs.Init.Paint = function (self,w,h)
    end
end
vgui.Register("Important Stuff", PANEL, "DPanel")
]]