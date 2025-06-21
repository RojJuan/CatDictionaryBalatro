if not CatDictionaryBalatro then 
  CatDictionaryBalatro = {}
end
local global = {}

local mod_path = "" .. SMODS.current_mod.path
CatDictionaryBalatro.path = mod_path
CatDictionaryBalatro_config = SMODS.current_mod.config

--Load jokers
local files = NFS.getDirectoryItems(mod_path .. "jokers/")
for _, file in ipairs(files) do
	print("[CD] Loading lib file " .. file)
	local f, err = SMODS.load_file("jokers/" .. file)
	if err then
		error(err) 
	end
	f()
end

SMODS.load_file("videos.lua")()
SMODS.load_file("misc.lua")()

