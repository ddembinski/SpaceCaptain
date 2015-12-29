-- Configuration
function love.conf(t)
  t.title = "Space Captain" -- The title of the window the game is in (string)
  t.identity = spacecaptain -- name of the save director
  t.version = "0.10.0"   -- The LOVE version this game was made for (string)
  t.window.width = 480  -- we want our game to be long and thin.
  t.window.height = 700

  -- for Windows debugging
  t.console = true
end
