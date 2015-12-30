boss = { x = 0, y = 0, hit_points = 25, startingHP = 25, speed = 150, img = nil, isAlive = false }
iterator = 0

function load_boss(hp)
	boss.isAlive = true
	boss.hit_points = hp
	boss.startingHP = hp
	start_x = boss.x
	start_y = boss.y
	create_smoke(start_x, start_y, 1.5)
	create_smoke(start_x, start_y+20, 1.5)
	create_smoke(start_x, start_y-20, 1.5)
	create_smoke(start_x+50, start_y, 1.5)
	create_smoke(start_x+50, start_y+10, 1.5)
	create_smoke(start_x+50, start_y-10, 1.5)
	create_smoke(start_x+100, start_y, 1.5)
	create_smoke(start_x+100, start_y+10, 1.5)
	create_smoke(start_x+100, start_y-10, 1.5)
	create_smoke(start_x-50, start_y, 1.5)
	create_smoke(start_x-50, start_y+10, 1.5)
	create_smoke(start_x-50, start_y-10, 1.5)
end


function update_boss(delta)
	if boss.isAlive then
		iterator = iterator + 1
    	boss.x = ((math.sin(iterator * 0.5 * 3.141 / 360) *150) + 200)
		boss.y = boss.y + ((score / 7) + 10) * delta

		if boss.y > 850 then
			reset_boss()
		end
	end

end

function damage_boss(damage)
	if boss.isAlive then
		boss.hit_points = boss.hit_points - damage
		if boss.hit_points < 1 then
			kill_boss()
		end
	end
end


function draw_boss()
	if boss.isAlive then
		 --build a boss out of composite enemy parts
	 	enemy5Anim:draw(boss.x, boss.y)
 		enemy3Anim:draw(boss.x+50, boss.y)
 		enemy4Anim:draw(boss.x+50, boss.y+10)
 		enemy3Anim:draw(boss.x-50, boss.y)
 		enemy4Anim:draw(boss.x-50, boss.y+10)
 	end

end

function kill_boss()
	if boss.isAlive then
    	deathSound:play()
    	create_explosion(boss.x, boss.y, 4.0)
    	create_explosion(boss.x+50, boss.y, 4.0)
    	create_explosion(boss.x+50, boss.y+10, 4.0)
    	create_explosion(boss.x-50, boss.y, 4.0)
    	create_explosion(boss.x-50, boss.y+10, 4.0)
    	create_powerup(boss.x, boss.y)
    	boss.isAlive = false
    	score = score + boss.startingHP
    	reset_boss()
    end
end

function reset_boss()
    boss.isAlive = false
    boss.x = 0
    boss.y = 0
    iterator = 0
    boss.hp = 25
end

