require "powerups"

enemies = {} --table of enemies
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

function load_enemies()
  enemy1Img = love.graphics.newImage('assets/lander.png')
  enemy1Anim = newAnimation(enemy1Img, 64, 64, 0.4, 0)
  enemy2Img = love.graphics.newImage('assets/bell.png')
  enemy2Anim = newAnimation(enemy2Img, 64, 64, 0.1, 0)
  enemy3Img = love.graphics.newImage('assets/top.png')
  enemy3Anim = newAnimation(enemy3Img, 64, 64, 0.1, 0)
  enemy4Img = love.graphics.newImage('assets/splatter.png')
  enemy4Anim = newAnimation(enemy4Img, 64, 64, 0.1, 0)
  enemy5Img = love.graphics.newImage('assets/nemesis.png')
  enemy5Anim = newAnimation(enemy5Img, 64, 64, 0.1, 0)
end


function update_enemies(delta)

	--time out enemy creation
	createEnemyTimer = createEnemyTimer - (0.6 * delta)
	if createEnemyTimer < 0 then
		createEnemyTimer = createEnemyTimerMax

		--create an enemy
		randomNumber = math.random(10, love.graphics.getWidth() - 10)


		if score >= 10 and score <= 20 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy2Img, enemyType=2 }
		elseif score > 20 and score <= 30 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy3Img, enemyType=3 }
		elseif score > 30 and score <= 40 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy4Img, enemyType=4 }
		elseif score > 40 and score <= 50 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy5Img, enemyType=5 }
		elseif score >= 0 and score <= 10 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy1Img, enemyType=1 }
		end

		if score > 50 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy2Img, enemyType=math.random(1,5) }
		end

		table.insert(enemies, newEnemy)
	end

	--update the positions  and animations of enemies
	for i, enemy in ipairs(enemies) do 
		--prev_x and prev_y are needed to calculate the vector of travel
		--this is used to set rotation so that enemies face in the direction they are moving
		prev_y = enemy.y
		prev_x = enemy.x

		--move enemies down along y-axis
		enemy.y = enemy.y + ((score)+ 100) * delta


		--controls how different enemy types move and animate differently
		if enemy.enemyType == 2 then
			enemy.x = enemy.x + ((math.sin((enemy.direction * 0.5 * 3.141)/5) * 200) * delta)
			enemy.r = (math.rad(get_vector_x(prev_x, prev_y, enemy.x, enemy.y)) *50) * -1
			
		elseif enemy.enemyType == 3 then
			enemy.x = enemy.x + ((math.cos((enemy.direction * 0.5 * 3.141)/5) *score) * delta)
			enemy.r = (math.rad(get_vector_x(prev_x, prev_y, enemy.x, enemy.y)) * 50) * -1
			
		elseif enemy.enemyType == 4 then
			enemy.x = enemy.x + ((get_vector_x(player.x, player.y + 200, enemy.x, enemy.y) / 20) *-1) * score
			enemy.r = (math.rad(get_vector_x(prev_x, prev_y, enemy.x, enemy.y)) * 50) * -1
			
		elseif enemy.enemyType == 5 then
			enemy.x = enemy.x + ((get_vector_x(player.x, player.y + 200, enemy.x, enemy.y) / 10) *-1) * score
			enemy.r = (math.rad(get_vector_x(prev_x, prev_y, enemy.x, enemy.y)) * 50) * -1
			
		else
			
		end

  		if enemy.y > 850 then --remove enemies when they pass off the screen
			table.remove(enemies, i)
		end
	end
	enemy1Anim:update(delta)
	enemy2Anim:update(delta)
	enemy3Anim:update(delta)
	enemy4Anim:update(delta)
	enemy5Anim:update(delta)
end

--takes a table of enemies and iterates through, setting options and then drawing
function draw_enemies(enemy_table)
	for i, enemy in ipairs(enemy_table) do
  		if enemy.enemyType == 2 then
  			love.graphics.setColor(255, 255, 255)
  			enemy2Anim:draw(enemy.x, enemy.y)
  		elseif enemy.enemyType == 3 then
  			love.graphics.setColor(255, 255, 255)
  			enemy3Anim:draw(enemy.x, enemy.y)
  		elseif enemy.enemyType == 4 then
  			love.graphics.setColor(255, 255, 255)
  			enemy4Anim:draw(enemy.x, enemy.y)
  	  	elseif enemy.enemyType == 5 then
  			love.graphics.setColor(255, 255, 255)
  			enemy5Anim:draw(enemy.x, enemy.y)
  		else
  			love.graphics.setColor(255, 255, 255)
  			enemy1Anim:draw(enemy.x, enemy.y)
  		end
  		--love.graphics.draw(enemy.img, enemy.x, enemy.y, enemy.r)
  	end
end

function kill_enemy(enemyTable, key, ene_x, ene_y)
	enemyDeathSound:stop()
    enemyDeathSound:play()
    create_explosion(ene_x, ene_y, 2.0)
    if math.floor(rand()*25) + 1 == 5 then
    	create_powerup(ene_x, ene_y)
    end
    table.remove(enemyTable, key)

end
