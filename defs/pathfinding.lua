-- PATHFINDING



function self.pathfinding_start(dx,dy)
   self.path_dx=dx
   self.path_dy=dy
end

function self.rendre_heureux()
   local root=main()
   local game_speed=root.stages.engine.game.game_speed
   if self.properties.bonheur < 100 then
      self.properties.bonheur=self.properties.bonheur+(1*game_speed)
   end
end

function self.pathfinding()
   local cx=self.get_case_x();
   local cy=self.get_case_y();
   
   local diffx=self.path_dx-cx;
   local diffy=self.path_dy-cy;
   

   self.move(cx,cy)            
   
   if diffx==0 and diffy==0 then
      local rt=randomize(10)+1;
      local rtf=randomize(15)+1;
      
      self.states.set_state ("immobile",{
				attendre={val_time(0,0,rt,rtf)}
			     });
   else


--      self.jump(cx-mod_x,cy-mod_y)      

      local dir="north"

      if diffx<0 then	 
	 dir="east"
      end
      if diffx>0 then
	 dir="west"
      end
      if diffy>0 then
	 dir="south"
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
end