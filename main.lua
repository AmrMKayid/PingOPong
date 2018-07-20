--[[
    GD50 2018
    Pong Remake

    Originally programmed by Atari in 1972. Features two
    paddles, controlled by players, with the goal of getting
    the ball past your opponent's edge. First to 10 points wins.

    This version is built to more closely resemble the NES than
    the original Pong machines or the Atari 2600 in terms of
    resolution, though in widescreen (16:9) so it looks nicer on 
    modern systems.
]]

--[[
    Require Libraries
]]
push = require 'lib/push'
Class = require 'lib/class'


--[[
    Require Classes
]]

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- For the lower resolution
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- paddle speed
PADDLE_SPEED = 200

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    retroFont = love.graphics.newFont('fonts/retro.ttf', 8)

    retroFontForScore = love.graphics.newFont('fonts/retro.ttf', 32)

    -- set LÖVE2D's active font to the retroFont object
    love.graphics.setFont(retroFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- transition between different parts of the game
    gameState = 'start'

end


function love.update( dt )
    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed( key )
    -- body
    if key == 'escape' then
        -- terminal the application
        love.event.quit()
    
    elseif key == 'enter' or key == 'return' then

        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- ball's new reset method
            ball:reset()
        end
    end
end

--[[
    Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    push:start()
    
    -- Clear the screen with a specific color similar to original pong
    -- TODO: Fix color error
    -- love.graphics.clear(40, 45, 52, 255)

    love.graphics.setFont(retroFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- render paddles, now using their class's render method
    player1:render()
    player2:render()

    -- render ball using its class's render method
    ball:render()

    -- end rendering at virtual resolution

    push:finish()
end
