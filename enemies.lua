enemies = {} --table of enemies
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

function load_enemies()
  enemy1Img = love.graphics.newImage('assets/enemy1.png')
  enemy2Img = love.graphics.newImage('assets/enemy2.png')
  enemy3Img = love.graphics.newImage('assets/enemy3.png')
  enemy4Img = love.graphics.newImage('assets/enemy4.png')
  enemy5Img = love.graphics.newImage('assets/enemy5.png')
end


function update_enemies(delta)

	--time out enemy creation
	createEnemyTimer = createEnemyTimer - (1 * delta)
	if createEnemyTimer < 0 then
		createEnemyTimer = createEnemyTimerMax

		--create an enemy
		randomNumber = math.random(10, love.graphics.getWidth() - 10)

		if score >= 25 and score < 50 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy2Img, enemyType=2 }
		elseif score >= 50 and score < 75 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy3Img, enemyType=3 }
		elseif score >= 75 and score < 100 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy4Img, enemyType=4 }
		elseif score >= 100 then
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy5Img, enemyType=5 }
		else
			newEnemy = { x = randomNumber, y = -10, direction = math.random(20), img = enemy1Img, enemyType=1 }
		end
		table.insert(enemies, newEnemy)
	end

	--update the positions of enemies
	for i, enemy in ipairs(enemies) do 
		--prev_x and prev_y are needed to calculate the vector of travel
		--this is used to set rotation so that enemies face in the direction they are moving
		prev_y = enemy.y
		prev_x = enemy.x

		--move enemies down along y-axis
		enemy.y = enemy.y + ((score * 4)+ 200) * delta


		--controls how different enemy types move differently
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
		end

  		if enemy.y > 850 then --remove enemies when they pass off the screen
			table.remove(enemies, 1)
		end
	end

end

--takes a table of enemies and iterates through, setting options and then drawing
function draw_enemies(enemy_table)
	for i, enemy in ipairs(enemy_table) do
  		if enemy.enemyType == 2 then
  			love.graphics.setColor(255, 255, 255)
  		elseif enemy.enemyType == 3 then
  			love.graphics.setColor(255, 255, 255)
  		elseif enemy.enemyType == 4 then
  			love.graphics.setColor(255, 255, 255)
  	  	elseif enemy.enemyType == 5 then
  			love.graphics.setColor(255, 255, 255)
  		else
  			love.graphics.setColor(255, 255, 255)
  		end
  		love.graphics.draw(enemy.img, enemy.x, enemy.y, enemy.r)
  	end
end
