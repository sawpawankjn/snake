Snake = {};

function Snake:load()
    self.segments = {{x = 2,y = 2}};
    self.dir = "right"; --left right up down
    self.biten = false;
    self.color = {0,1,0,1};
    self.time = 0;
end

function Snake:update(dt)
    self:go(dt);
    self:eat();
    self:bite();
    self:up_pos();
    self:up_seg();
    self:control(); 
end

function Snake:go(dt)
    local head = self.segments[1];
    if self.time > 0.15 then
       if self.dir == "left" then
       head.x = head.x - 1;
       elseif self.dir == "right" then  
       head.x = head.x + 1;
       elseif self.dir == "down" then
       head.y = head.y + 1;
       elseif self.dir == "up" then  
       head.y = head.y - 1;
      end
      self.time = 0;
    end
    self.time = self.time + dt;
end

function Snake:up_pos()
    local head = self.segments[1];
    if head.x > math.floor(love.graphics.getWidth()/TILE_SIZE) then
       head.x = 0;
    elseif head.x < 0 then
       head.x = math.floor(love.graphics.getWidth()/TILE_SIZE);
    elseif head.y > math.floor(love.graphics.getHeight()/TILE_SIZE) then
       head.y = 0;
    elseif head.y < 0 then
       head.y = math.floor(love.graphics.getHeight()/TILE_SIZE);
    end
end

function Snake:up_seg()
 if self.time > 0.15 then
    for i = #self.segments,2,-1 do
        self.segments[i].x = self.segments[i-1].x;
        self.segments[i].y = self.segments[i-1].y;
    end
 end
end

function Snake:bite()
    local head = self.segments[1];
    for i = 2,#self.segments,1 do 
        local segment = self.segments[i];
        if head.x == segment.x and head.y == segment.y then
           self.biten = true;
        end
    end

    if self.biten then
        self.biten = false;
        self.segments = {{x = 3,y = 2}};
    end
end

function Snake:eat()
     local head = self.segments[1];
     if head.x == Food.x and head.y == Food.y then
        Food.eaten = true;
        self:expand();
     end
end

function Snake:expand()
     local tail = self.segments[#self.segments];
     local segment = {x = tail.x , y = tail.y};
     if self.dir == "right" then
     segment.x = segment.x - 1;
     elseif self.dir == "left" then
     segment.x = segment.x + 1;
     elseif self.dir == "up" then
     segment.y = segment.y + 1;
     elseif self.dir == "down" then
     segment.y = segment.y - 1;
     end
     table.insert(self.segments,segment);
end

function Snake:control()
    if love.keyboard.isDown("up") and self.dir ~= "down" then
       self.dir = "up";
    elseif love.keyboard.isDown("down") and self.dir ~= "up" then
       self.dir = "down"
    elseif love.keyboard.isDown("left") and self.dir ~= "right" then
        self.dir = "left";
    elseif love.keyboard.isDown("right") and self.dir ~= "left" then
        self.dir = "right"
    end
end

function Snake:draw()
    for i = 1,#self.segments,1 do
        local segment = self.segments[i];
        love.graphics.setColor(self.color);
        love.graphics.rectangle("fill",segment.x*TILE_SIZE,segment.y*TILE_SIZE,TILE_SIZE,TILE_SIZE);
        love.graphics.setColor({0,0,0,1});
        love.graphics.rectangle("line",segment.x*TILE_SIZE,segment.y*TILE_SIZE,TILE_SIZE,TILE_SIZE);
    end
    local len = tostring(#self.segments);
    love.graphics.print(len);
end