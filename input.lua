--Command processing module

--delta is the dt global variable passed from main.lua. It complains when you try to use dt in this module otherwise.
function process_commands(delta)
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('space', 'rctrl', 'lctrl', 'ctrl') and canShoot and player.isAlive and numBullets <= maxBullets then
                fire_gun(dt) --from gun.lua
	end

	if love.keyboard.isDown('left','a') and player.isAlive then
		if player.x > 0 then -- binds us to the map
			player.x = player.x - (player.speed*delta)
		end
	elseif love.keyboard.isDown('right','d') and player.isAlive then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed*delta)
		end
	end

	--warp drive engage!
	if love.keyboard.isDown('up','w') and player.isAlive then
		if player.y > 0 then -- binds us to the map
			player.y = player.y - ((player.speed*2)*delta)
			bg.y = bg.y + (150*delta)
			fuel.remaining = fuel.remaining - (16*delta)
		end
	elseif player.isAlive then
		if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
			player.y = player.y + (175*delta)
		end
	end

	if not player.isAlive and love.keyboard.isDown('r') then 
		--remove all our bullets and enemies from the screen
		bullets = {}
		enemies = {}

		--reset timers
		canShootTimer = canShootTimerMax
		createEnemyTimer = createEnemyTimerMax

		--move player back to default position
		player.x = 50
		player.y = 610

		--reset our game state
		reset_game() -- in main.lua
	end

end