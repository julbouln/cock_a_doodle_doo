function self.pathfinding()
   self.pathfinding_step()
end

function self.on_pathfinding_check_obstacle(x,y)
   local map=self.parent.parent;   
   local deo=map.decor.get_object_at_position(x,y)
--   if deo~=nil and deo.properties.metatype=="decoration" then
   if deo~=nil and deo.properties.obstacle==1 then
      return 1
   else
      return 0
   end

end

function self.on_pathfinding_noway()
   self.on_pathfinding_destination()
end

function self.on_pathfinding_destination()
      local rt=randomize(10)+1;
      local rtf=randomize(15)+1;

      self.states.set_state ("immobile",{
				attendre={val_time(0,0,rt,rtf)}
			     });      

   end

function self.on_pathfinding_step(cx,cy,x,y)
      local diffx=x - cx
      local diffy=y - cy

      local dir="north"
      if diffx<0 then
	 dir="east"
      end

      if diffy>0 then 
	 dir="south"
      end

      if diffx>0 then 
	 dir="west"
      end

      if diffy<0 then
	 dir="north"
      end
      
      local root=main()
      local game_speed=root.stages.engine.game.game_speed

      self.states.set_state ("marcher",{
				bouge={val_time(0,1,0,0)},
				deplacement={
				   (self.properties.speed*game_speed),
				   val_direction(dir) 
			     }})
end