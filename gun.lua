canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax
numBullets = 0
maxBullets = 2

function can_shoot(delta)
	canShootTimer = canShootTimer - (.75 * delta)
	if canShootTimer < 0 then
		canShoot = true
	end
end