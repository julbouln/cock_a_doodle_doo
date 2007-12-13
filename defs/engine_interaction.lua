function self.on_mouseover(x,y)
   local engine=self.parent.parent;
   local vis=engine.visual;

   local obj=engine.map.decor[engine.pose_achat] 
   local cx=floor((x+vis.get_x())/32);
   local cy=floor((y+vis.get_y())/32);
   
   
   if(obj ~=nil) then
      local ao=engine.map.decor.get_object_at_position(cx,cy);
      if ao~=nil and ao~=obj then
	 obj.wont=1
	 obj.graphics.main.hide();
	 obj.graphics.main_border.hide();
	 obj.graphics.main_border_wont.show();
      else
	 obj.wont=0
	 obj.graphics.main.show();
	 obj.graphics.main_border.show();
	 obj.graphics.main_border_wont.hide();
      end      

      obj.move(cx,cy)	      
   end
   
end

function self.on_mouseclick(x,y)
   local engine=self.parent.parent;
   local vis=engine.visual;
   local cx=floor((x+vis.get_x())/32);
   local cy=floor((y+vis.get_y())/32);
   local obj=engine.map.objet.get_object_at_position(cx,cy);
   local dobj=engine.map.decor.get_object_at_position(cx,cy);

   local pobj=engine.map.decor[engine.pose_achat] 
   if pobj ~= nil then
      if pobj.wont==0 then
	 engine.parent.ui.sprites.argent.properties.total=engine.parent.ui.sprites.argent.properties.total-pobj.properties.price
	 engine.parent.ui.sprites.argent.graphics.main.set_text(format("$ %i",engine.parent.ui.sprites.argent.properties.total))
	 pobj.graphics.main_border_wont.hide();
	 engine.pose_achat=nil
      end
   end



   
   if(obj==nil and dobj ~=nil) then
      obj=dobj
   end
   
   if(dobj ~= nil and (dobj.get_type()=="nid" and obj.get_type()=="oeuf")) then
      obj=dobj
   end
   
   if(obj ~=nil ) then
      engine.select_object(obj)
   else
      local sprites=engine.parent.ui.sprites
      engine.unselect_all()
   end
   
   
   
end

function self.on_keypress(e)
   local engine=self.parent.parent; 
   if e=="p" then
      if engine.pause then
	 engine.map.unpause();
	 engine.pause=nil
	 print ("*unpause*")
	 engine.parent.ui.sprites.pause.graphics.main.hide();
--	 engine.timer.start();
      else
	 engine.pause=1
	 engine.map.pause();
	 print ("*pause*")
	 engine.parent.ui.sprites.pause.graphics.main.show();
--	 engine.timer.stop();
      end
   end

   if e=="echap" then 
--      gc_dump_head();
      exit(2) 
   end;
   if e=="return" then 
   end;
   
   if e=="a" then
      engine.select_poules()
      engine.current_poule=engine.current_poule+1;
   end
   
   if e=="right" then
      engine.visual.scroll(16,0)
   end
   if e=="left" then
      engine.visual.scroll(-16,0)
   end
   if e=="up" then
      engine.visual.scroll(0,-16)
   end
   if e=="down" then
      engine.visual.scroll(0,16)
   end
   
end