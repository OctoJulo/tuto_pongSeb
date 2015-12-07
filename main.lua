local entities = require('entities')
function love.load()
	screen = {}
	screen.width, screen.height = love.window.getDimensions()
	
	player = {}
	player= entities.new("joueur",100,10,6,1,(screen.width - 100)/2,screen.height - 10)

	player2 = {}
	player2 = entities.new("bot",100,10,6,1,screen.width/2, 0)

	ball = {}
	ball = entities.new("ball",10,10,3,3,player.x + (player.width - 10)/2,player.y - player.height)

	run = 0
	gamestat = "wait"
end

function ball_hit()
	if ball.x >= screen.width - ball.width/2 then--touch right wall
		ball.speedx = - ball.speedx
	end
	if ball.x <= ball.width/2 then	--touch left wall
		ball.speedx = - ball.speedx
	end
end

function love.update()


	if ball.y >= screen.height then
		gamestat = "gameover"
	elseif ball.y <= 0 then
		gamestat = "gamewin"
		--print("bop")
	end
----------------GAMESTATEMENT----------------
	if gamestat == "game" then
		ball.y = ball.y - ball.speedy
		ball.x = ball.x - ball.speedx
		player:move()
		player2:move()
		player:hitball()
		player2:hitball()
		ball_hit()
	elseif gamestat == "gameover" then
		player2.score = player2.score +1
		posball = string.format("at pos: x: %s y: %s", ball.x, ball.y)
		print(gamestat,posball)
		print("SCORE:",player.name,player.score,"/",player2.name,player2.score)
		gamestat = "wait"
	elseif gamestat == "gamewin" then
		player.score = player.score +1
		posball = string.format("at pos: x: %s y: %s", ball.x, ball.y)
		print(gamestat,posball)
		print("SCORE:",player.name,player.score,"/",player2.name,player2.score)
		gamestat = "wait"
	end
	if gamestat == "wait" then  -- si le jeux n'est pas commencer alors la ball est sur la raquette du joueur.
		ball.x = player.x + (player.width - ball.width)/2
		ball.y = player.y - player.height
	end
	
	----------------CHEAT----------------
		--player2.x = ball.x - 45
		player2.x = player.x
end

function love.draw()
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
	love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
	love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end

function love.keypressed(key)
	player:keypressed(key)
end
function love.keyreleased(key)
	player:keyreleased(key)
end