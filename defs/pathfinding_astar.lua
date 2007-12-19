self.current_path=1
self.pf_open_list={}
self.pf_closed_list={}


function self.pf_push_open(n)
   self.pf_open_list[size(self.pf_open_list)]=n
   return size(self.pf_open_list) - 1
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

function self.pf_calc(p,cx,cy)
   c=self.pf_push_closed(self.pf_node(p,cx,cy,10))

   n1=self.pf_push_open(self.pf_node(c,cx-1,cy,10))
   n2=self.pf_push_open(self.pf_node(c,cx+1,cy,10))
   n3=self.pf_push_open(self.pf_node(c,cx,cy-1,10))
   n4=self.pf_push_open(self.pf_node(c,cx,cy+1,10))

   f=100000
   bn=nil
   local map=self.parent.parent;


   fc=self.pf_heuristic(cx-1,cy) + self.pf_g(n1)
   if fc < f then
      f=fc
      bn=n1
   end



   fc=self.pf_heuristic(cx+1,cy) + self.pf_g(n2)
   if fc < f then
      f=fc
      bn=n2
   end


   fc=self.pf_heuristic(cx,cy-1) + self.pf_g(n3)
   if fc < f then
      f=fc
      bn=n3
   end

   fc=self.pf_heuristic(cx,cy+1) + self.pf_g(n4)
   if fc < f then
      f=fc
      bn=n4
   end


   bno=self.pf_open_list[bn]
   
   if bno.x~=self.path_dx or bno.y~=self.path_dy then
--      print(format("PATHFINDING : %s@%s calc %i,%i",self.get_id(),self.get_type(),bno.x,bno.y))
      self.pf_calc(bno.p,bno.x,bno.y,10)

   else
--      print(format("PATHFINDING : %s@%s calc destination %i,%i",self.get_id(),self.get_type(),bno.x,bno.y))
      c=self.pf_push_closed(self.pf_node(bno.p,bno.x,bno.y,10))
   end
   self.pf_open_list[bn]=nil


end



function self.pathfinding()
   local cx=self.get_case_x();
   local cy=self.get_case_y();

   local rx=self.path_dx-cx;
   local ry=self.path_dy-cy;

   self.move(cx,cy)
   local cnode=self.pf_closed_list[self.current_path]


   if (rx==0 and ry==0)  or self.current_path >= size(self.pf_closed_list) then 
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

      self.current_path=self.current_path+1
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

   self.pf_calc(nil,cx,cy)
--   print(format("PATHFINDING : %s@%s %i cases, %i,%i -> %i,%i",self.get_id(),self.get_type(),size(self.pf_closed_list),cx,cy,self.path_dx,self.path_dy))
 
end