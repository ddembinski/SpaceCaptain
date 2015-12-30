explosions = { x = 0, y = 0, lifespan = 0.5 } --table of explosions


function load_explosions()
	explosionImg = love.graphics.newImage('assets/explosion.png')
	explodeAnim = newAnimation(explosionImg, 64, 64, 0.5, 0)
end

function create_explosion(create_x, create_y, lifespan)
	newExplosion = { x = create_x, y = create_y, lifespan = lifespan }
	table.insert(explosions, newExplosion)
end

function update_explosions(explosion_list, delta)
		explodeAnim:update(delta)
end

function draw_explosions(explosion_list)
	for i, explosion in ipairs(explosion_list) do
		if explosion.lifespan > 0 then
			explodeAnim:draw(explosion.x, explosion.y)
			explosion.lifespan = explosion.lifespan - 0.1
		else
			table.remove(explosion_list, i)
		end
	end

end

