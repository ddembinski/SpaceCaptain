bullets = {} --table of bullets

function update_bullets(delta)
	for i, bullet in ipairs(bullets) do 
		bullet.y = bullet.y - (450 * delta)

		if bullet.y < 0 then -- remove bullets when they pass off the screen
			table.remove(bullets, 1)
			numBullets = numBullets - 1
		end
	end
end

function draw_bullets(bullets)
  for i, bullet in ipairs(bullets) do 
  	love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end
end
