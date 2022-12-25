--[[
    DO NOT CHANGE NOTHING UNLESS YOU KNOW WHAT ARE YOU DOING!!
--]]

local isSLIDEscapeAct = false 
local InitialPanel = false 
local width
local ButTons

    --Creating launch sys

local blur = Material("pp/blurscreen")

local function blurBG(p, a, h)
    local x, y = p:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetMaterial(blur)
    for i = 1, (h or 3) do
        blur:SetFloat("$blur", (i/3)*(a or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()

        surface.DrawTexturedRect(x*-1,y*-1,scrW,scrH)
        surface.SetDrawColor(SLIDEs.Config.SideColor)
		surface.DrawRect(0, 0, 365, ScrH())
    end
end

function logo()


    if SLIDEs.Config.UseLogo then
        local logo = Material(SLIDEs.Config.Logo)
        if string.sub(SLIDEs.Config.Logo, 1, 4) == "http" then
            SLIDEs.GetImage(SLIDEs.Config.Logo, SLIDEs.Config.CacheLogo, function(url, filename)
                logo = Material(filename)
            end)
    
            surface.SetMaterial(logo)
            surface.SetDrawColor(color_white)

        end
    end
    surface.DrawTexturedRect( 50, 55, 260, 120 )
end

function SLIDEs:Start()
    local ply = LocalPlayer()

    if IsValid ( SLIDEs.Menu ) then
        if SLIDEs.Menu:IsVisible() then
            SLIDEs.Menu:Remove()
            gui.EnableScreenClicker(false)
            isSLIDEscapeAct = false 
            return true
            end
    end


    gui.EnableScreenClicker(true)

    --Creating menu

    SLIDEs.Menu = vgui.Create("DFrame")
    SLIDEs.Menu:SetTitle("")
    SLIDEs.Menu:SetDraggable(false)
    SLIDEs.Menu:ShowCloseButton(false)
    SLIDEs.Menu:MakePopup(true)
    SLIDEs.Menu:SetPos(0,0)
    SLIDEs.Menu:SetSize(0, ScrH())

    --Creating Anim

    local isAnimating = true
    SLIDEs.Menu:SizeTo(ScrW(), ScrH(), SLIDEs.Config.time, SLIDEs.Config.delay, SLIDEs.Config.ease, function()
        isAnimating = false 
    end)
    SLIDEs.Menu.Think = function(me)
        if isAnimating then
            me:CenterVertical()
        end
    end

    if string.sub(SLIDEs.Config.BG, 1, 4) == "blur" then
        SLIDEs.Menu.Paint = function(self,w,h)
            blurBG(self, 4)
            logo(self,4)
        end

    elseif SLIDEs.Config.Background == "color" then 
        SLIDEs.Menu.Paint = function(self, w, h)
            surface.SetDrawColor(SLIDEs.Config.BGColor or color_white)
            surface.DrawRect(0, 0, w, h)
        end
    elseif SLIDEs.Config.BG != "" then
        local background = Material(SLIDEs.Config.BG)
        SLIDEs.Menu.Paint = function(self,w,h)
            surface.SetMaterial(background)
            surface.DrawTexturedRect(0,0,w,h)
        end
    else
        SLIDEs.Menu.Paint = function(self,w,h) end
    end

    SLIDEs.Pan = vgui.Create( "DPanel", SLIDEs.Menu)
    SLIDEs.Pan:SetSize( ScrW() - ScrW()/2 - ScrW()/3.5 - ScrW()/25, ScrW()/3.80)
    SLIDEs.Pan:SetPos(ScrW()/1000 + ScrW()/40 , 250)
    SLIDEs.Pan.Paint = function( self, w, h)
    end

    SLIDEs.List = vgui.Create("DPanelList", SLIDEs.Menu)
    SLIDEs.List:SetSize(ScrW()/3, ScrH()- ScrH()/4-10)
    SLIDEs.List:SetPos(ScrW()/4-1,ScrH()/4)
    SLIDEs.List.Paint = function(self, w, h)
    end
    
    ButTons = 1
    for k, v in ipairs(SLIDEs.Config.Nav) do
		if not v.Enabled or v.Visible and !v.Visible(ply) then continue end
		ButTons = ButTons + 1
	end

    SLIDEs.Buttons = {}

    width = math.Round( SLIDEs.Pan:GetWide() / ButTons)
    SLIDEs.Pan:SetWide(width*ButTons)

    for k, v in ipairs( SLIDEs.Config.Nav ) do
	
		if not v.Enabled or v.Visible and !v.Visible(ply) then continue end

		local icon = Material( v.icon )

		if string.sub(v.icon, 1, 4) == "http" then
			SLIDEs.GetImage(v.icon, v.cachepath, function(url, filename)
				v.icon = filename
				icon = Material( v.icon )
			end)
		end

		local ColorLine = v.ColorLine or Color( 255, 255, 255, 100 )
		local ColorBase = v.ColorBase or Color(33, 31, 35, 200)
		local ColorHover = v.ColorHover or Color( 0, 0, 0, 100 )
		local ColorText = v.ColorText or Color( 255, 255, 255, 255 )
		local ColorImage = v.ColorImage or Color(255,255,255,255)
		local ColorSelected = v.ColorSelected or Color(47, 174, 79, 100)

		self.SLIDEs_Button = vgui.Create("DButton", SLIDEs.Pan)
		self.SLIDEs_Button:Dock(BOX_TOP)
		self.SLIDEs_Button:SetText("")
		self.SLIDEs_Button:DockMargin(0,5,0,0)
		self.SLIDEs_Button:SetSize(ScrW()/80,ScrH()/15-5)
		self.SLIDEs_Button.Paint = function(self, w, h)
			
			if self.active then
				draw.RoundedBox(8, 0, 0, w, h, ColorSelected)
			else
				draw.RoundedBox(8, 0, 0, w, h, ColorBase)
			end

			

			if self:IsHovered() or self:IsDown() then
				draw.RoundedBox( 8, 0, 0, w, h, ColorHover )
			end

			draw.DrawText( string.upper(v.Name), "SLIDEs.Button.Text", 60, h/2-7, ColorText, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			
			surface.SetMaterial( icon )
			surface.SetDrawColor( ColorImage )
			surface.DrawTexturedRect( 10, h/2-15, 32, 32 )
		end
		self.SLIDEs_Button.DoClick = function(obj)

			if ( v.WebEnabled and v.WebURL ) then
				for _, button in ipairs( SLIDEs.Buttons ) do
					button.active = false
				end
				gui.OpenURL( v.WebURL or "https://www.google.com/" )

				return
			end

			if v.DoFunc then
				v.DoFunc()
				return
			end

			for _, button in ipairs( SLIDEs.Buttons ) do
				button.active = false
			end

			obj.active = true

			SLIDEs.HideBox()

			SLIDEs.List:Remove()
			if not IsValid( SLIDEs.List ) then
				SLIDEs.List = vgui.Create("DPanelList", SLIDEs.Menu)
    			SLIDEs.List:SetSize(ScrW() - SLIDEs.Model:GetWide()+ 100, ScrH() - ScrH()/4-10)
    			SLIDEs.List:SetPos(ScrW()/10,ScrH()/10)
				SLIDEs.List.Paint = function(self, w, h) end
			end
			vgui.Create(v.DoLoadPanel, SLIDEs.List)	
		end
		table.insert( SLIDEs.Buttons, self.SLIDEs_Button )

		if v.OnLoadInit and !InitialPanel and !v.DoFunc then
			SLIDEs.List:Remove()
			if not IsValid( SLIDEs.List ) then
				SLIDEs.List = vgui.Create("DPanelList", SLIDEs.Menu)
				SLIDEs.List:SetSize(ScrW() - SLIDEs.Model:GetWide()+ 100, ScrH() - ScrH()/4-10)
				SLIDEs.List:SetPos(ScrW()/10,ScrH()/10)
				SLIDEs.List.Paint = function(self, w, h) end
			end
			vgui.Create( v.DoLoadPanel, SLIDEs.List )

			for _, button in pairs( SLIDEs.Buttons ) do
				button.active = false
			end
			self.SLIDEs_Button.active = true
			InitialPanel = true
		end
	end
end




local keyNames
local function KeyNameToNumber(str)
    if not keyNames then
        keyNames = {}
        for i = 1, 107, 1 do
            keyNames[input.GetKeyName(i)] = i
        end
    end

    return keyNames[str]
end

    --Opening


hook.Add("PreRender", "SLIDEs:PreRender", function()
	if ( gui.IsGameUIVisible() and input.IsKeyDown( KEY_ESCAPE )) then
		gui.HideGameUI()

		isSLIDEscapeAct = true
		InitialPanel = false
		if IsValid( SLIDEs.Menu ) then
    		SLIDEs:Start()
			gui.HideGameUI()
			isSLIDEscapeAct = false
		else
			SLIDEs:Start()
			gui.HideGameUI()
		end
	end
end)