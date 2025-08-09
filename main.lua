
function love.load()
    player = love.graphics.newImage('sprites/player/test.png')
    player_img_W, player_img_img_H = player:getWidth(), player:getHeight()
    ground = love.graphics.newImage('sprites/ground/test+ground.png')
    abs_pos = 0
    love.window.setMode(350,350,{resizable = true, minwidth = 350, minheight = 350})
end

function love.update(dt)
    if love.keyboard.isDown("a") then
        abs_pos = abs_pos - 100 * dt
        print("pressed [a]")
    end
    
    if love.keyboard.isDown("d") then
        abs_pos = abs_pos + 100 * dt 
        print("pressed [d]")
    end
end


function love.draw()
    love.graphics.draw(
        player,
        abs_pos, 1,         -- Позиция
        0,            -- Поворот
        scale, scale  -- Масштаб
    )
    love.graphics.draw(ground, 100, 100, 0, scale, scale)
    
end

function love.resize(w, h)
    -- Вычисляем масштаб так, чтобы картинка влезала в окно по меньшей стороне
    scale = math.min(w / player_img_W, h / player_img_img_H)
end

