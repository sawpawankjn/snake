require("food");
require("snake");

TILE_SIZE = 40;

function love.load()
  Food:load();
  Snake:load();
end

function love.update(dt)
  Food:update();
  Snake:update(dt);
end

function love.draw()
  Food:draw();
  Snake:draw();
end