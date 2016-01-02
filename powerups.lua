powerups = {} --table of powerups
createPowerupTimerMax = 4.0
createPowerupTimer = createPowerupTimerMax


function load_powerups()
  powerup1Img = love.graphics.newImage('assets/powerup-shots.png')
  powerup1Anim = newAnimation(powerup1Img, 32, 32, 0.1, 0)
  powerup2Img = love.graphics.newImage('assets/powerup-rof.png')
  powerup2Anim = newAnimation(powerup2Img, 32, 32, 0.1, 0)
  powerup3Img = love.graphics.newImage('assets/powerup-speed-anim.png')
  powerup3Anim = newAnimation(powerup3Img, 32, 32, 0.1, 0)
end


function update_powerups(delta)


	--update the positions of powerups
	for i, powerup in ipairs(powerups) do 
		if powerup.powerupType == 3 then 
			powerup3Anim:update(delta)
		elseif powerup.powerupType == 1 then
			powerup1Anim:update(delta)
		elseif powerup.powerupType == 2 then
			powerup2Anim:update(delta)
		end

		powerup.y = powerup.y + (50 * delta)

  		if powerup.y > 850 then --remove powerups when they pass off the screen
			table.remove(powerups, 1)
		end
	end

end

function create_powerup(create_x, create_y)
		random2 = math.random(1,3)

		if random2 == 1 then
			newPowerup = { x = create_x, y = create_y, img = powerup1Img, powerupType=1 }
		elseif random2 == 2 then
			newPowerup = { x = create_x, y = create_y, img = powerup2Img, powerupType=2 }
		elseif random2 == 3 then
			newPowerup = { x = create_x, y = create_y, img = powerup3Img, powerupType=3 }
		end

		table.insert(powerups, newPowerup)

end

function draw_powerups(powerup_table)
	for i, powerup in ipairs(powerup_table) do
		if powerup.powerupType == 3 then
			powerup3Anim:draw(powerup.x, powerup.y)
		elseif powerup.powerupType == 1 then
			powerup1Anim:draw(powerup.x, powerup.y)
		elseif powerup.powerupType == 2 then
			powerup2Anim:draw(powerup.x, powerup.y)
		end
 		--love.graphics.setColor(255, 255, 255)
  		--love.graphics.draw(powerup.img, powerup.x, powerup.y)
  	end
end

function process_powerup(powerup)
	if powerup.powerupType == 1 then
		if maxBullets <= 4 then
			maxBullets = maxBullets + 1
		end
	elseif powerup.powerupType == 2 then
		if canShootTimerChange <= 1.5 then
			canShootTimerChange = canShootTimerChange + 0.25
		end
	elseif powerup.powerupType == 3 then
		if player.speed <= 200 then
			player.speed = player.speed + 25
		end
	end
end

