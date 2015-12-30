require "enemies"
--things to load in at start time

function load_up()
  font = love.graphics.newImageFont("assets/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  love.graphics.setFont(font)
  bg.img = love.graphics.newImage('assets/starfield1.png')

  player.img = love.graphics.newImage('assets/spaceship.png')
  bulletImg = love.graphics.newImage('assets/bullet_150.png')

  load_enemies() --from enemies.lua
  load_powerups() --from powerups.lua

  deathSound = love.audio.newSource("assets/aiplaneexplode.ogg", "static")
  deathSound:setVolume(1.0)
  gunSound = love.audio.newSource("assets/gun1Light.ogg", "static")
  gunSound:setVolume(0.5)
  enemyDeathSound = love.audio.newSource("assets/boatexplode.ogg", "static")
  enemyDeathSound:setVolume(0.25)
  music = love.audio.newSource("assets/battleThemeA.mp3")
  music:setVolume(0.5)
  music:setLooping(true)
  music:play()
end