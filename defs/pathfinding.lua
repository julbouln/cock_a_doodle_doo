-- PATHFINDING

function self.pathfinding_start(dx,dy)
   self.path_dx=dx
   self.path_dy=dy
end

function self.pf_dir_cost(x,y)
   local cx=self.get_case_x();
   local cy=self.get_case_y();
   local diffx=(x - cx)
   local diffy=(y - cy)

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

      local st=self.states.get_state_val();

      if st~=nil and st.deplacement~=nil and st.deplacement[0]~=nil and st.deplacement[0].dir~=dir then
	 if dir=="west" and st.deplacement[0].dir=="east" then
	    return 1.0
	 end
	 if dir=="east" and st.deplacement[0].dir=="west" then
	    return 1.0
	 end
	 if dir=="north" and st.deplacement[0].dir=="south" then
	    return 1.0
	 end
	 if dir=="south" and st.deplacement[0].dir=="north" then
	    return 1.0
	 end
	 return 0.5
      else
	 return 0
      end
end

function self.pf_heuristic(x,y)
   local map=self.parent.parent;
   local diffx=self.path_dx-x;
   local diffy=self.path_dy-y;
   local r=0
   local deo=map.decor.get_object_at_position(x,y)
   if deo~=nil and deo.properties.metatype=="decoration" then
--      print(format("PATHFINDING %s@%s : obstacle %i,%i : %s@%s",self.get_id(),self.get_type(),x,y,deo.get_id(),deo.get_type()))      
   r=r+2.0
   end
   local oo=map.objet.get_object_at_position(x,y)
   if oo~=nil then
--      print(format("PATHFINDING %s@%s : obstacle %i,%i : %s@%s",self.get_id(),self.get_type(),x,y,deo.get_id(),deo.get_type()))      
   r=r+0.5
   end
   r=r+(sqrt(diffx*diffx+diffy*diffy))+ self.pf_dir_cost(x,y)
   return r
end

self.best_r=10000.0
self.best_x=0
self.best_y=0


function self.pf_best(r,x,y)
   if r < self.best_r then
      self.best_r=r
      self.best_x=x
      self.best_y=y
   end
end

function self.pf_calc_best(x,y)
   r=self.pf_heuristic(x,y)   
--   print(format("PATHFINDING %s@%s : %i,%i=%f",self.get_id(),self.get_type(),x,y,r))

   self.pf_best(r,x,y)
end

function self.pathfinding()
   local cx=self.get_case_x();
   local cy=self.get_case_y();
   
   local rx=self.path_dx-cx;
   local ry=self.path_dy-cy;
   
   local map=self.parent.parent;

   self.move(cx,cy)
   self.best_r=10000.0
   self.pf_calc_best(cx-1,cy)
   self.pf_calc_best(cx+1,cy)
   self.pf_calc_best(cx,cy-1)
   self.pf_calc_best(cx,cy+1)

--   print(format("PATHFINDING %s@%s : from %i,%i to %i,%i = %i,%i(%f)",self.get_id(), self.get_type(),cx,cy,self.path_dx,self.path_dy,self.best_x,self.best_y,self.best_r))


--   print("Best path")

--   print(self.best_x - cx)
--   print(self.best_y - cy)
   local diffx=(self.best_x - cx)
   local diffy=(self.best_y - cy)

--   self.pf_calc_best(cx,cy)


   
   if rx==0 and ry==0 then
      local rt=randomize(10)+1;
      local rtf=randomize(15)+1;
      
      self.states.set_state ("immobile",{
				attendre={val_time(0,0,rt,rtf)}
			     });

   else

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
end