-- runs as soon as the game loads/before actually starting
-- specifiy global vars and window size.. , anything that need to be run before the game starts
-- any global var declared here will exist from the moment the game starts
love.load = function ()
  target = {}
  target.x = 300
  target.y = 300
  target.r = 20

  game_state = 1
  score = 0
  timer = 0
  game_font = love.graphics.newFont(20)
end

love.mousepressed = function (x,y,button,istouch,presses) -- last two used for mobile

  if button == 1 and game_state == 1 then
    game_state = 2
    timer = 10
    score = 0
  end

  if button == 1 and game_state == 2 then
    -- check we are inside the circle; distance between the source and mouse should be <= the radius
    local mouse_target = distanceBetween(x,y,target.x,target.y)
    if mouse_target <= target.r then
      score = score + 1
      -- Stop it from going past the edge
      target.x = math.random(target.r , love.graphics.getWidth() - target.r)
      target.y = math.random(target.r , love.graphics.getHeight() - target.r)
    end
  end


end

-- reserved only to draw graphics/images into the screen [do not declare vars | do not make calcs]
-- similar to update runs every frame per second
love.draw = function ()
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  if game_state == 1 then
    love.graphics.printf("Click to Start the Game", 0, height/2, width, "center")
  end

  if game_state == 2 then
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill", target.x,target.y,target.r)
  end

  love.graphics.setColor(1,1,1)
  love.graphics.setFont(game_font)
  love.graphics.printf("Score: " .. score,0,0,width,"left")
  love.graphics.printf("Time: " .. math.ceil(timer),0,0,width,"center")
end
-- game loop, it runs each frame, if it's 60fps it's gonna run 60 times every second

love.update = function (dt)
  if timer > 0 then timer = timer - dt
  elseif timer < 0 then
    timer = 0
    game_state = 1
  end
end

-- calculate the distance between to points
distanceBetween = function (x1,y1,x2,y2)
  d = (x2-x1)^2 + (y2-y1)^2
  return math.sqrt(d)
end
