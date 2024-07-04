Food = {};

function Food:load()
    self.x = math.random(1,math.floor(love.graphics.getWidth()/TILE_SIZE)-1);
    self.y = math.random(1,math.floor(love.graphics.getHeight()/TILE_SIZE)-1);
    self.eaten = false;
    self.color = {1,0,0,1};
end

function Food:update()
    Food:relocate();
end

function Food:relocate()
    if self.eaten then
        self.x = math.random(1,math.floor(love.graphics.getWidth()/TILE_SIZE)-1);
        self.y = math.random(1,math.floor(love.graphics.getHeight()/TILE_SIZE)-1);
        self.eaten = false;
     end
end

function Food:draw()
    love.graphics.setColor(self.color);
    love.graphics.rectangle("fill",self.x*TILE_SIZE,self.y*TILE_SIZE,TILE_SIZE,TILE_SIZE);
end