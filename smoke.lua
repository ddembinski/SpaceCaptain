smoke = { x = 0, y = 0, lifespan = 1.5 } --table of explosions


function load_smoke()
	smokeImg = love.graphics.newImage('assets/smoke.png')
	smokeAnim = newAnimation(smokeImg, 64, 64, 0.09, 0)
end

function create_smoke(create_x, create_y, lifespan)
	newSmoke = { x = create_x, y = create_y, lifespan = lifespan }
	table.insert(smoke, newSmoke)
end

function update_smoke(smoke_list, delta)
		smokeAnim:update(delta)
end

function draw_smoke(smoke_list, delta)
	for i, smoke in ipairs(smoke_list) do
		if smoke.lifespan > 0 then
			smokeAnim:draw(smoke.x, smoke.y)
			smoke.lifespan = smoke.lifespan - 0.1
		else
			table.remove(smoke_list, i)
		end
	end

end

