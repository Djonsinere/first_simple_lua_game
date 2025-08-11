
function love.load()
    player = love.graphics.newImage('sprites/player/canon.png')
    player_img_W, player_img_H = player:getWidth(), player:getHeight()
    bullet_state = false
    bullet = love.graphics.newImage('sprites/player/bullet/bullet.png')
    bullet_img_W, bullet_img_H = bullet:getWidth(), bullet:getHeight()
    ground = love.graphics.newImage('sprites/ground/test+ground.png')
    abs_rotation = 0
    love.window.setMode(350,350,{resizable = true, minwidth = 350, minheight = 350})
    window_width, window_height = love.graphics.getDimensions()
        -- Низ окна
    ground_cx = window_width / 2
    ground_cy = window_height / 1.2

    --spriteSheet = love.graphics.newImage("sprites/player/animation/canon_rotate_left-Sheet.png")
    --frameWidth, frameHeight = 128, 64
    --frames = {}
    --for i = 0, 10 do
    --    frames[i+1] = love.graphics.newQuad(
    --        i * frameWidth, 0, -- смещение
    --        frameWidth, frameHeight,
    --        spriteSheet:getDimensions()
    --    )
    --end
--
    --currentFrame = 1
    --timer = 0
    --frameDuration = 0.15

end

function love.update(dt)

    if love.keyboard.isDown("a")  and abs_rotation > -1.35 then
        abs_rotation = abs_rotation - 1 * dt
        print("pressed [a]: ", abs_rotation)
    end
    
    if love.keyboard.isDown("d") and  abs_rotation < 1.35 then
        abs_rotation = abs_rotation + 1 * dt
        --timer = timer + dt
        --if timer >= frameDuration then
        --    timer = timer - frameDuration
        --    currentFrame = currentFrame + 1
        --    if currentFrame > #frames then
        --        currentFrame = 1
        --    end
        --end 
        print("pressed [d]: ", abs_rotation)
    end

    if love.keyboard.isDown("space") and not bullet_active then
            bullet_active = true
            bullet_index = 1

            -- вычисляем траекторию в момент выстрела
            local barrelLength = 150
            local startX = ground_cx
            local startY = ground_cy
            local endX = startX + math.cos(abs_rotation - math.pi/2) * barrelLength
            local endY = startY + math.sin(abs_rotation - math.pi/2) * barrelLength

            bullet_path = get_cords_for_bullet(startX, startY, endX, endY, 10)
        end 

        if bullet_active then
            bullet_index = bullet_index + 1
            if bullet_index > #bullet_path then
                bullet_active = false -- пуля достигла конца
            end
        end
end




function love.draw()
    -- Низ окна
    --local ground_cx = window_width / 2
    --local ground_cy = window_height / 1.2

    -- Рисуем ground (своим масштабом)
    love.graphics.draw(
        ground,
        ground_cx, ground_cy,
        0,
        scale_ground, scale_ground,
        ground:getWidth() / 2, ground:getHeight() / 1.4
    )

    -- Рисуем player (фиксированный масштаб)
    love.graphics.draw(
        player,
        --spriteSheet,
        --frames[currentFrame],
        ground_cx, ground_cy,          -- центр земли
        abs_rotation,                  -- поворот
        scale_player, scale_player,    -- масштаб игрока
        player_img_W /2, player_img_H
    )

     -- Линия прицела
    local barrelLength = 150 -- длина линии
    local startX = ground_cx
    local startY = ground_cy
    local endX = startX + math.cos(abs_rotation - math.pi/2) * barrelLength
    local endY = startY + math.sin(abs_rotation - math.pi/2) * barrelLength

    love.graphics.setColor(1, 1, 1) -- красная линия
    love.graphics.setLineWidth(2)
    love.graphics.line(startX, startY, endX, endY)

    if bullet_active then
        local point = bullet_path[bullet_index]
        love.graphics.draw(bullet, point[1], point[2])
    end
end


function love.resize(w, h)
    -- Масштаб земли, чтобы она вписывалась в окно
    scale_ground = math.min(w / ground:getWidth(), h / ground:getHeight())

    -- Масштаб игрока — фиксированный (например, 1)
    scale_player = 1
end


function get_cords_for_bullet(x_s, y_s, x_e, y_e, quantity) 
    points_array = {}
    for i=1, quantity do
        local x = ((quantity - i)*x_s +x_e * i)/quantity--x
        local y = ((quantity - i)*y_s +y_e * i)/quantity --y
        table.insert(points_array, {x, y})
    end
    return points_array
end
