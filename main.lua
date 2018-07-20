--[[
    GD50 2018
    Pong Remake

    pong-0
    "The Day-0 Update"

    -- Main Program --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

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

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- For the lower resolution
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    retroFont = love.graphics.newFont('fonts/retro.ttf', 8)

    love.graphics.setFont(retroFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

function love.keypressed( key )
    -- body
    if key == 'escape' then
        -- terminal the application
        love.event.quit()
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

    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- render first paddle (left side)
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- render second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- render ball (center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- end rendering at virtual resolution

    push:finish()
end
