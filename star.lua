stars = {} --table of enemies
createStarTimerMax = 0.4
createStarTimer = createEnemyTimerMax


function load_stars()
  starImg = love.graphics.newImage('assets/star_horizontal.png')
  starAnim = newAnimation(starImg, 32, 32, 0.5, 0)
end


function update_stars(delta)

	--time star creation
	createStarTimer = createStarTimer - (0.6 * delta)
	if createStarTimer < 0 and math.random(1,100) == 24 then
		createStarTimer = createStarTimerMax

		--create a star
		randomX = math.random(10, love.graphics.getWidth() - 10)
		randomY = math.random(10, love.graphics.getHeight() - 10)
		
		newStar = { x = randomX, y = randomY, lifespan = 1.5, type = 1 }
		
		table.insert(stars, newStar)
	end

	--update star animations
	starAnim:update(delta)


end

--takes a table of enemies and iterates through, setting options and then drawing
function draw_stars(star_table)
	for i, star in ipairs(star_table) do
		if star.lifespan > 0 then
			starColor = math.random(1,3)
			if starColor == 1 then
				love.graphics.setColor(255, 255, 255)
				starAnim:draw(star.x, star.y)
			elseif starColor == 2 then
				love.graphics.setColor(248, 255, 0)
			else 
				love.graphics.setColor(173, 181, 252)
			end
			love.graphics.setColor(255, 255, 255)
			star.lifespan = star.lifespan - 0.4
		else
			table.remove(star_table, i)
		end
	end
end
