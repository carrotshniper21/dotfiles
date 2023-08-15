local wezterm = require("wezterm")



local font_size = 18
local font_family = ({
  "Liga SFMono Nerd Font",    -- [1]
  "BlexMono Nerd Font",       -- [2]
  "Iosevka Nerd Font",        -- [3]
  "JetBrainsMono Nerd Font",  -- [4]
  "FiraCode Nerd Font",       -- [5]
  "ComicCodeLigatures",       -- [6]
  "Nouveau IBM",              -- [7]
  "IBM Plex Mono",            -- [8]
  "Source Code Pro",          -- [9]
  "NotoSansMono Nerd Font",   -- [10]
  "FantasqueSansM Nerd Font", -- [11]
  "JetBrains Mono",           -- [12]
})[12]

local font = wezterm.font(font_family)

return { font = font, font_size = font_size }
