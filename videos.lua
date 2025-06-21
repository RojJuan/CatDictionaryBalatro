

function create_UIBox_custom_video1(name, buttonname)
  local file_path = SMODS.Mods["CD"].path.."/assets/videos/"..name..".ogv"
  local file = NFS.read(file_path)
  love.filesystem.write("temp.ogv", file)
  local video_file = love.graphics.newVideo('temp.ogv')
  local vid_sprite = Sprite(0,0,11*9/16,11,G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)], {x=0, y=0})
  video_file:getSource():setVolume(G.SETTINGS.SOUND.volume*G.SETTINGS.SOUND.game_sounds_volume/(100*10))
  vid_sprite.video = video_file
  video_file:play()

  local t = create_UIBox_generic_options({ back_delay = 2 , back_label = buttonname, colour = G.C.BLACK, padding = 0, contents = {
    {n=G.UIT.O, config={object = vid_sprite}} }})
  return t
end 

function vidtest()
  G.FUNCS.overlay_menu{definition = create_UIBox_custom_video1("1","Keep scrolling.")}
end
