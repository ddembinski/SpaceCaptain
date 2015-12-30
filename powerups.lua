powerups = {} --table of enemies
createPowerupTimerMax = 4.0
createPowerupTimer = createPowerupTimerMax


function load_powerups()
  powerup1Img = love.graphics.newImage('assets/powerup-bullet.png')
  powerup2Img = love.graphics.newImage('assets/powerup-rate.png')
  powerup3Img = love.graphics.newImage('assets/powerup-speed.png')
end


function update_powerups(delta)


	--update the positions of powerups
	for i, powerup in ipairs(powerups) do 

		powerup.y = powerup.y + (50 * delta)

  		if powerup.y > 850 then --remove powerups when they pass off the screen
			table.remove(powerups, 1)
		end
	end

end

function create_powerup(create_x, create_y)
		random2 = math.floor(rand()*3) + 1

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
 		love.graphics.setColor(255, 255, 255)
  		love.graphics.draw(powerup.img, powerup.x, powerup.y)
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

