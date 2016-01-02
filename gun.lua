canShoot = true
canShootTimerMax = 0.25
canShootTimerChange = 0.5
canShootTimer = canShootTimerMax
numBullets = 0

function can_shoot(delta)
	canShootTimer = canShootTimer - (canShootTimerChange * delta)
	if canShootTimer < 0 then
		canShoot = true
	end
end

function fire_gun(delta)
    --create some bullets
    newBullet = { x = player.x + (player.img:getWidth()/10), y = player.y, img = bulletImg }
    table.insert(bullets, newBullet)
    numBullets = numBullets +1
    gunSound:stop()
    gunSound:play() 
    canShoot = false
    canShootTimer = canShootTimerMax
end
