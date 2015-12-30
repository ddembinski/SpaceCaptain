-- This game began by following Dawson Goodell's tutorial at http://www.osmstudios.com/tutorials/your-first-love2d-game-in-200-lines-part-1-of-3
-- Clearest "How to build a game" tutorial I've ever read, and highly recommended.

debug = true

require "util"
require "input"
require "load"
require "explosion"
require "enemies"
require "bullets"
require "gun"
require "player"
require "powerups"
require "smoke"
require "boss"

require "AnAL"

function reset_game()
    score = 49
    player.isAlive = true
    beatHiScore = false
    played_death_sound = false
    if fuel.remaining < 1 then
        bg.y = -4100
        reset_timer()
    end
    numBullets = 0
    bossLoaded = false
    reset_boss()
    maxBullets = defaultValues["mb"]
    canShootTimerChange = defaultValues["cstc"]
    player.speed = defaultValues["ps"]
end


math.randomseed( os.time() )
math.random() ; math.random() ; math.random()

--globals
bg = { x= 0, y = -4100, speed = 5, img = nil}

score = 0
if not love.filesystem.exists( "hiScoreSave" ) then
    love.filesystem.write( "hiScoreSave", "0" )
end
hiScore = love.filesystem.read( "hiScoreSave" )
beatHiScore = false
waitingForInput = false
bossLoaded = false

--default values for the stats we're modifying with powerups
defaultValues = { mb = 2, cstc = 1.0, ps = 150 }
reset_game()


function love.load(arg)
    --load_up() from load.lua - things to load at start time
    load_up()
end

-- Updating
function love.update(dt)
    if boss.isAlive == false then 
        bossLoaded = false
    end

    --create a boss every 50 points
    if score > 1 and score % 50 == 1 and not bossLoaded then
        load_boss(score)
        bossLoaded = true
    end

    --contains command functions
    process_commands(dt) --from input.lua
    
    --contains enemy defintions and behaviors
    update_enemies(dt) --from enemies.lua

    update_powerups(dt) --from powerups.lua
    
    --check our fuel remaining and update
    update_fuel(dt) --from player.lua
    
    --is our gun ready to fire?
    can_shoot(dt) --from gun.lua
    
    --does what it says on the tin
    update_player_speed() --from player.lua
    
    --update bullet positions
    update_bullets(dt) --from bullets.lua
    
    --update player animation
    anim:update(dt)

    --update explosions
    update_explosions(explosions, dt)
    
    update_smoke(smoke, dt) --from smoke.lua

    update_boss(dt)
    
    --scroll our background down
    bg.y = bg.y + ( bg.speed *dt )
    if bg.y > -1 then
        bg.y = -1
    end
    
    -- check collisions between bullets/enemies, enemies/player, powerups/player, and bullets/boss.
    for i, enemy in ipairs(enemies) do 
        for j, bullet in ipairs(bullets) do 
            if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth() /4, enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then 
                table.remove(bullets, j)
                numBullets = numBullets -1
                kill_enemy(enemies, i, enemy.x, enemy.y) --from enemies.lua
                score = score + 1
            end
            if boss.isAlive and CheckCollision(boss.x -64, boss.y, boss.x + 64, 74, bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then 
                damage_boss(score / 25) --from boss.lua
                create_explosion(bullet.x, bullet.y, 0.5)
                table.remove(bullets, j)
                numBullets = numBullets -1
            end
        end
        
        if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth() /4, enemy.img:getHeight(), player.x, player.y, player.img:getWidth() /4, player.img:getHeight()) 
            and player.isAlive then
            table.remove(enemies, 1)
            kill_player("Collided with the enemy.") --from player.lua
        end
        if boss.isAlive and player.isAlive and CheckCollision(boss.x -64, boss.y, boss.x + 64, 74, player.x, player.y, player.img:getWidth() /4, player.img:getHeight()) 
            then
                damage_boss(boss.hp) --from boss.lua
                kill_player("Collided with the enemy")
            end
    end
    for i, powerup in ipairs(powerups) do
        if CheckCollision(powerup.x, powerup.y, powerup.img:getWidth(), powerup.img:getHeight(), player.x, player.y, player.img:getWidth() /4, player.img:getHeight()) 
            and player.isAlive then
            process_powerup(powerup)
            table.remove(powerups, i)
        end
    end
end

function love.draw(dt)
    --draw the background
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.draw(bg.img, bg.x,bg.y)
    
    if player.isAlive then 
        draw_player() --from player.lua
    else
        display_death_message() --from player.lua
    end
    
    draw_bullets(bullets)--from bullets.lua
    
    draw_enemies(enemies) --from enemies.lua

    draw_powerups(powerups) --from powerups.lua

    draw_explosions(explosions) --from explosion.lua

    draw_boss() --from boss.lua

    draw_smoke(smoke) --from smoke.lua
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("HIGH SCORE: " .. tostring(hiScore), 10, 10)
    love.graphics.print("SCORE: " .. tostring(score), 10, 30)
    love.graphics.print("FUEL: " ..tostring(math.floor(fuel.remaining)), 350, 10)
end