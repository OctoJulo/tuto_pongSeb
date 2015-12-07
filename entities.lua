	
local entity = {}
entity.__index = entity

function entity.new(name, width,height,speedx,speedy,posX,posY)
	-- body
	local self = setmetatable({},entity)
		self.name = name
		self.width = width
		self.height = height
		self.speedx = speedx
		self.speedy = speedy
		self.cooldown = 10
		self.x = posX
		self.y = posY 
		self.ONmove = "stop"
		self.colisionWall = ""
		self.score = 0
	return self
end		

function entity.hitball(self)

	if self.name == player.name and ball.x >= self.x and ball.x <= self.x + self.width and ball.y == self.y - self.height then
			--print(self.name," touch ball :",ball.x,ball.y)
			ball.speedy = - ball.speedy
	elseif self.name == player2.name and ball.x >= self.x and ball.x <= self.x + self.width and ball.y <= self.y + self.height and ball.y >= self.y then
			--print(self.name," touch ball :",ball.x,ball.y)
			ball.speedy = - ball.speedy
	end
end

function entity.checkWallcolision(self)
	if self.x <= 0 then
		--print("colision mur gauche")
		self.colisionWall = "left"
		--print(ball.x,ball.y)
		
	elseif (self.x + self.width) >= screen.width then
		--print("colision mur droit") 
		self.colisionWall = "right" 
	else
		--print("nada")
		self.colisionWall = ""
	end
	return self.colisionWall
end

function entity.move(self)
	colisionwithWall = entity.checkWallcolision(self)
	if colisionwithWall == "" then
		--print("peut bouger")
		if self.ONmove == "right" then
			self.x = self.x + self.speedx 
		elseif self.ONmove == "left" then
			self.x = self.x - self.speedx
		end
	elseif colisionwithWall == "right" and self.ONmove == "right" then
		self.ONmove = "stop"--print("ne peut aller a droite")
	elseif colisionwithWall == "right" and self.ONmove == "left" then
		self.x = self.x - self.speedx
	elseif colisionwithWall == "left" and self.ONmove == "left" then
		self.ONmove = "stop"--	print("ne peut aller a gauche")
	elseif colisionwithWall == "left" and self.ONmove == "right" then
		self.x = self.x + self.speedx 
	end
	return self.move
end

function entity.keypressed(self, key)
	--print(self.name," press key", key)
	if key == "right" then
		self.ONmove = "right" 	
	elseif key == "left" then
		self.ONmove = "left"
	end
	return self.keypressed
end

function entity.keyreleased(self, key)
	--print(self.name," released key", key)
	if key == "right" then
		if love.keyboard.isDown("left") then
			print("encore left")
		else
			self.ONmove = "stop" 
		end  
	elseif key == "left" then
		if love.keyboard.isDown("right") then
			print("encore right")
		else
			self.ONmove = "stop"
		end    
	elseif key == " " then
		gamestat = "game"
	end
	return self.keyreleased
end
return entity

