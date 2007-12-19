-- A* pathfinding implementation
self.path={}
self.current_path=1
self.pf_open_list={}
self.n_open_list=0
self.pf_closed_list={}
self.current_node=nil


function self.pf_push_open(n)
   local i=0
   local e=nil
   while i < self.n_open_list do
      if self.pf_open_list[i]~=nil and self.pf_open_list[i].x == n.x and self.pf_open_list[i].y == n.y then
	 e=1
      end
      i=i+1
   end
   
   local i=0
   while i < size(self.pf_closed_list) do
      if self.pf_closed_list[i]~=nil and self.pf_closed_list[i].x == n.x and self.pf_closed_list[i].y == n.y then
	 e=1
      end
      i=i+1
   end
   if e==nil then
--      print(format("PUSH : %i,%i",n.x,n.y))
      self.pf_open_list[self.n_open_list]=n
      self.n_open_list=self.n_open_list + 1
      return self.n_open_list - 1
   else
      return nil
   end
end

function self.pf_push_closed(n)
   self.pf_closed_list[size(self.pf_closed_list)]=n
   return size(self.pf_closed_list) - 1
end

function self.pf_node(p,x,y,cost)
   return  {p=p,x=x,y=y,cost=cost}
end

function self.pf_heuristic(x,y)
   local diffx=self.path_dx-x;
   local diffy=self.path_dy-y;
   return floor((sqrt(diffx*diffx+diffy*diffy))*10)
end

function self.pf_g(n)
   local cn=n
   local g=0

   g=g+self.pf_open_list[cn].cost

   cn=self.pf_open_list[n].p

   while cn~=nil do
      g=g+self.pf_closed_list[cn].cost
      cn=self.pf_closed_list[cn].p
   end
   return g
end

function self.pf_is_obstacle(x,y)
   local map=self.parent.parent;   
   local deo=map.decor.get_object_at_position(x,y)
   if deo~=nil and deo.properties.metatype=="decoration" then
      return 1
   else
      return nil
   end
end

function self.pf_calc(p,cx,cy)
   r=nil
--   print(format("FROM : %i,%i",cx,cy))
   c=self.pf_push_closed(self.pf_node(p,cx,cy,10))

   if self.pf_is_obstacle(cx-1,cy)==nil then
      n1=self.pf_push_open(self.pf_node(c,cx-1,cy,10))
   end

   if self.pf_is_obstacle(cx+1,cy)==nil then
      n2=self.pf_push_open(self.pf_node(c,cx+1,cy,10))
   end
   if self.pf_is_obstacle(cx,cy-1)==nil then
      n3=self.pf_push_open(self.pf_node(c,cx,cy-1,10))
   end
   if self.pf_is_obstacle(cx,cy+1)==nil then
   n4=self.pf_push_open(self.pf_node(c,cx,cy+1,10))
   end
--   print (format("OPENLIST : %i",self.n_open_list))
   local f=100000
   bn=nil
   local map=self.parent.parent;

   local i=0

   while i < self.n_open_list do 
      if self.pf_open_list[i] ~= nil then
	 local ntmp=self.pf_open_list[i]

	 fc=self.pf_heuristic(ntmp.x,ntmp.y) + self.pf_g(i)
--	 print(format("%i,%i = %i",ntmp.x,ntmp.y,fc))
	 if fc < f then
	    f=fc
	    bn=i
	 end
      end
      i=i+1
   end   

   if bn~=nil then
      bno=self.pf_open_list[bn]


--      print(format("PATHFINDING : %i,%i",bno.x,bno.y))

      if bno.x > 0 and bno.y > 0 and bno.x < map.get_w() and bno.y < map.get_h() then
	 if bno.x~=self.path_dx or bno.y~=self.path_dy then
--	    print(format("PATHFINDING : %s@%s calc %i,%i",self.get_id(),self.get_type(),bno.x,bno.y))
	    self.pf_open_list[bn]=nil	    
	    r=self.pf_calc(bno.p,bno.x,bno.y,10)

	 else
--	    print(format("PATHFINDING : %s@%s calc destination %i,%i",self.get_id(),self.get_type(),bno.x,bno.y))
	    self.pf_open_list[bn]=nil
	    c=self.pf_push_closed(self.pf_node(bno.p,bno.x,bno.y,10))
	    r=c
	 end
      end
   end
   return r
end


function self.pathfinding()
   local cx=self.get_case_x();
   local cy=self.get_case_y();

   local rx=self.path_dx-cx;
   local ry=self.path_dy-cy;

   self.move(cx,cy)
   local cnode=self.path[self.current_path]
--   local cnode=self.current_node
--   print(cnode)

   if (rx==0 and ry==0)  or cnode==nil then
--or self.current_path >= size(self.pf_closed_list) then 
--      print(format("PATHFINDING : %s@%s %i %i,%i destination!",self.get_id(),self.get_type(),self.current_path,cx,cy))
      
      local rt=randomize(10)+1;
      local rtf=randomize(15)+1;

      self.states.set_state ("immobile",{
				attendre={val_time(0,0,rt,rtf)}
			     });      


   else

      local diffx=cnode.x - cx
      local diffy=cnode.y - cy

--      print(format("PATHFINDING : diff %i,%i",diffx,diffy))

--      print(format("PATHFINDING : %s@%s %i,%i -> %i,%i",self.get_id(),self.get_type(),cx,cy,cnode.x,cnode.y))

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

--      self.current_node=self.pf_closed_list[self.current_node.p]
--      print(self.current_node)
      self.current_path=self.current_path+1
   end


end

function self.pf_get_path(r)
   local i=0
   n=self.pf_closed_list[r]
   tmpl={}

   while n ~= nil do
      tmpl[i]=n      
      n=self.pf_closed_list[n.p]
      i=i+1
   end

   local j=0
   while j < size(tmpl) do
      self.path[size(tmpl)-j-1]=tmpl[j]
      j=j+1
   end

end

function self.pathfinding_start(dx,dy)
   self.path_dx=dx
   self.path_dy=dy
   local cx=self.get_case_x()
   local cy=self.get_case_y()
   self.pf_open_list={}
   self.pf_closed_list={}
   self.current_path=1
   self.current_node=nil

   r=self.pf_calc(nil,cx,cy)
   self.pf_get_path(r)
   print(format("PATHFINDING : %s@%s %i cases, %i,%i -> %i,%i",self.get_id(),self.get_type(),size(self.path),cx,cy,self.path_dx,self.path_dy))
 
end