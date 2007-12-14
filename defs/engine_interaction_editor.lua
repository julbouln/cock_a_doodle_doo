

function self.efface_bordure_obj(k,obj)
   if obj.graphics.main_border~=nil then
      obj.graphics.main_border.hide();
   end
end

function self.efface_bordure_carte(mid,map)
   map.foreach_object (self.efface_bordure_obj);
end


function self.on_mouseover(x,y)
local engine=self.parent.parent;
local vis=engine.visual;
local iface=engine.parent.iface;

   engine.map.foreach_object_map(self.efface_bordure_carte);

   cx=floor((x+vis.get_x())/32);
   cy=floor((y+vis.get_y())/32);
   objid=engine.map.get_object_id_at_position(cx,cy);
   if objid~=nil then
      oid=engine.map.object_get_object_id(objid);
      mid=engine.map.object_get_map_id(objid);
      map=engine.map[mid];
      obj=map[oid];
      if obj.graphics.main_border~=nil then
	 obj.graphics.main_border.show();
      end

   end


if iface.outil.type=="objet" then   
   local mt=engine.map[iface.outil.valeur.map];
   local obj=mt[iface.outil.valeur.id];
--   print (obj.get_bcentre_x());
   obj.jump (x+vis.get_x(),y+vis.get_y());
end

if iface.outil.type=="terrain" and iface.outil.valeur.etat=="clic" and iface.outil.valeur.num~=nil then
   local mo=engine.map["terrains"];
   local bo=engine.map["bordures"];
   cx=floor((x+vis.get_x())/32)-floor(iface.outil.pinceau/2);
   cy=floor((y+vis.get_y())/32)-floor(iface.outil.pinceau/2);

   nx=0;
   while nx~=iface.outil.pinceau do
      ny=0;
      while ny~=iface.outil.pinceau do
	 bo.set_tile_position(cx+nx,cy+ny,nil);	    
	 ny=ny+1;
      end
      nx=nx+1;
   end

   nx=0;
   boc=24;
   while nx~=iface.outil.pinceau do
      ny=0;
      while ny~=iface.outil.pinceau do

	 if mo.get_tile_position(cx+nx,cy+ny)~=iface.outil.valeur.num then
	 if nx==0 and ny==0 then
	    if bo.get_tile_position(cx+nx,cy+ny)==nil then
	       bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24+4);
	    end
	 else
	    if nx==0 then
	       bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24);
	    end

	    if ny==0 then
	       bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24+1);
	    end	  

	 end



	 if nx==iface.outil.pinceau-1 and ny==iface.outil.pinceau-1 then
	    if bo.get_tile_position(cx+nx,cy+ny)==nil then
	       bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24+6);
	    end
	 else

	    if nx==iface.outil.pinceau-1 then
	       bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24+2);
	    end

	    if ny==iface.outil.pinceau-1 then
	       bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24+3);
	    end	    

	    if nx==iface.outil.pinceau-1 and ny==0 then
		  bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24+5);
	    end

	    if ny==iface.outil.pinceau-1 and nx==0 then
		  bo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num/3*24+7);
	    end


	 end
--	 bo.auto_tile_border(cx+nx,cy+ny);	
	 end
	 ny=ny+1;
      end
      nx=nx+1;
   end

   nx=0;
   while nx~=iface.outil.pinceau do
      ny=0;
      while ny~=iface.outil.pinceau do
	 if bo.get_tile_position(cx+nx,cy+ny)~=nil then	
	    bo.auto_tile_border(cx+nx,cy+ny);	
	 end
	 ny=ny+1;
      end
      nx=nx+1;
   end

--   nx=iface.outil.pinceau;
--   while nx~=0 do
--      ny=iface.outil.pinceau;
--      while ny~=0 do
--	 if bo.get_tile_position(cx+nx,cy+ny)~=nil then	
--	    bo.auto_tile_border(cx+nx,cy+ny);	
--	 end
--	 ny=ny-1;
--     end
--      nx=nx-1;
--   end

   nx=1;
   while nx~=iface.outil.pinceau-1 do
      ny=1;
      while ny~=iface.outil.pinceau-1 do
	 bo.set_tile_position(cx+nx,cy+ny,nil);	    
	 mo.set_tile_position(cx+nx,cy+ny,iface.outil.valeur.num);	    
	 ny=ny+1;
      end
      nx=nx+1;
   end


end

end

-- Clique souris sur la carte


function self.on_mouseclick(x,y,b)
   local engine=self.parent.parent;
   local vis=engine.visual;
   local iface=engine.parent.iface;
   cx=floor((x+vis.get_x())/32);
   cy=floor((y+vis.get_y())/32);
   
   if b==2 then
      iface.clear_objet();
      iface.outil.type=nil;
      
   end

   if iface.outil.type=="objet" then
      iface.reset_objets();

      local mo=engine.map[iface.outil.valeur.map];
      local o=mo[iface.outil.valeur.id];
      --   iface[self.place_obj].hide();
      --   self.place_obj=nil;
      no=mo.add_object_from_type(o.get_type(),cx,cy);
      --   iface.outil.type=nil;
      iface.outil.valeur.id=no;
   end

   if iface.outil.type=="terrain" then
      iface.outil.valeur.etat="clic";
   end
   
   if iface.outil.type=="supprime" then
      dobj=engine.map.get_object_id_at_position(cx,cy);
      --  print(dobj);
      if dobj~=nil then
	 engine.map.delete_object(dobj);
      end   
   end

   if iface.outil.type=="deplace" then

      dobj=engine.map.get_object_id_at_position(cx,cy);
      if dobj~=nil then
	 oid=engine.map.object_get_object_id(dobj);
	 mid=engine.map.object_get_map_id(dobj);
	 iface.outil.type="objet"
	 iface.outil.valeur.id=oid;
	 iface.outil.valeur.map=mid;
      end
      
   end

end

function self.on_mouserelease(x,y,b)
   local engine=self.parent.parent;
   local iface=engine.parent.iface;
   if iface.outil.type=="terrain" then
      iface.outil.valeur.etat=nil;
   end
end
-- Presse touche clavier
function self.on_keypress(e)
   if e=="echap" then exit(2) end;
end

-- Relache touche clavier 
function self.on_keyrelease(e)

end

