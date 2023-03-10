SLIDEs = SLIDEs or {}


SLIDEs.Config = SLIDEs.Config or {}

local slidescape = "slidescape"
local name = "SLIDEscape"
local ver = "1.0.0"

if SERVER then

    AddCSLuaFile(slidescape.."/config/sh_config.lua")
    
    AddCSLuaFile(slidescape.."/client/cl_init.lua")
    MsgC(Color(34, 34, 34), "["..name.."]", Color(238,255,4), " Version : "..ver.."\n")

    for k, file in SortedPairs(file.Find(slidescape.."/config/*", "LUA")) do
        include(slidescape.."/config/"..file)
        AddCSLuaFile(slidescape.."/config/"..file)
        MsgC( Color( 34, 34, 34), "["..name.."]", Color(255,255,255), " Loading : "..slidescape.."/config/"..file.."\n")
    end

    for k, file in pairs (file.Find(slidescape.."/client/*", "LUA")) do
        AddCSLuaFile(slidescape.."/client/"..file)
        MsgC( Color( 34, 34, 34 ), "["..name.."]", Color(255,255,255), " Loading : "..slidescape.."/client/"..file.."\n")
    end

    for k, file in pairs (file.Find(slidescape.."/client/fonts/*", "LUA")) do
        AddCSLuaFile(slidescape.."/client/fonts/"..file)
        MsgC( Color( 34, 34, 34 ), "["..name.."]", Color(255,255,255), " Loading : "..slidescape.."/client/fonts/"..file.."\n")
    end

    for k, file in pairs (file.Find(slidescape.."/server/*", "LUA")) do
        include(slidescape.."/server/"..file)
        MsgC( Color( 34, 34, 34 ), "["..name.."]", Color(255,255,255), " Loading : "..slidescape.."/server/"..file.."\n")
    end
    
end

if CLIENT then

    for k, file in SortedPairs (file.Find(slidescape.."/config/*", "LUA")) do
        include(slidescape.."/config/"..file)
    end

    for k, file in SortedPairs (file.Find(slidescape.."/client/*", "LUA")) do
        include(slidescape.."/client/"..file)
    end
    
    AddCSLuaFile(slidescape.."/config/sh_config.lua")
    
    AddCSLuaFile(slidescape.."/client/cl_init.lua")

    for k, file in pairs (file.Find(slidescape.."/client/fonts/*", "LUA")) do
        include(slidescape.."/client/fonts/"..file)
    end

end
