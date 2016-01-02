require "enemies"
--things to load in at start time

function load_up()
  gamestate = "mainmenu"

  math.randomseed( os.time() )
  math.random() ; math.random() ; math.random()
  font = love.graphics.newImageFont("assets/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  love.graphics.setFont(font)
  bg.img = love.graphics.newImage('assets/background.png')
  load_stars()
  logoImg = love.graphics.newImage('assets/logo.png')

  player.img = love.graphics.newImage('assets/player.png')
  anim = newAnimation(player.img, 64, 64, 0.1, 0)
  bulletImg = love.graphics.newImage('assets/shot.png')
  
  load_explosions() --from explosion.lua
  load_smoke() --from smoke.lua
  load_enemies() --from enemies.lua
  load_powerups() --from powerups.lua

  deathSound = love.audio.newSource("assets/explosion5.ogg", "static")
  deathSound:setVolume(1.0)
  gunSound = love.audio.newSource("assets/laser6.ogg", "static")
  gunSound:setVolume(0.5)
  enemyDeathSound = love.audio.newSource("assets/explosion4.ogg", "static")
  enemyDeathSound:setVolume(0.25)
  music = love.audio.newSource("assets/music.ogg")
  music:setVolume(0.5)
  music:setLooping(true)
  music:play()
end