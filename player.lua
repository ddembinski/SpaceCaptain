player = { x= 200, y = 630, speed = 150, img = nil, isAlive=true }
fuel = { remaining=400, default=400 }
played_death_sound = false
deathMessage = "Killed by mysterious forces."

--check our fuel remaining and update
function update_fuel(delta)
	if fuel.remaining > 0 and player.isAlive then
		fuel.remaining = fuel.remaining - delta
	elseif fuel.remaining < 1 and player.isAlive then
		kill_player("Ran out of fuel!")
	end
end

function reset_timer()
	fuel.remaining = fuel.default
end

function update_player_speed()
	--if score >= 25 and score < 50 then
	--	player.speed = 200
	--elseif score >= 50 and score < 75 then
	--	player.speed = 225
	--elseif score >=75 then
	--	player.speed = 250
	--else
	--	player.speed = 175
	--end
end

function draw_player()
	--love.graphics.draw(player.img, player.x, player.y, 0, 1.2, 1.2)
	anim:draw(player.x, player.y)
end

function kill_player(cause_of_death)
	if not played_death_sound then
		deathSound:play()
		played_death_sound = true
	end
	deathMessage = cause_of_death
	player.isAlive = false
	create_explosion(player.x, player.y, 5.0)
	print("maxBullets: " ..tostring(maxBullets) .."\n")
	print("numBullets: " ..tostring(numBullets) .."\n")
end

function display_death_message()
	love.graphics.print("Oh no, Captain! You ", love.graphics:getWidth()/2-100, love.graphics:getHeight()/2-150)
	love.graphics.printf(deathMessage, love.graphics:getWidth()/2 -125, love.graphics:getHeight()/2-100, 200, center, 0, 1.5, 1.5)
	love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-100, love.graphics:getHeight()/2-10)
	if beatHiScore then
		love.graphics.print("NEW HIGH SCORE!", love.graphics:getWidth()/2-135, love.graphics:getHeight()/2+50, 0, 1.75, 1.75)
	end
	if score > tonumber(hiScore) then
		beatHiScore = true
		hiScore = score
		success = love.filesystem.write( "hiScoreSave", tostring(hiScore) )
	end
end