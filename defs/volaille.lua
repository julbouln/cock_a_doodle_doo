self.init_bcentre("main");
local rt=randomize(10)+1;
local rtf=randomize(15)+1;
self.states.set_state ("immobile",{
			  attendre={val_time(0,0,rt,rtf)}
		    });

self.dpix=0;
self.veut="rien"

-- IA
self.connait={}
self.n_connait=0

self.rand_poule=0
self.rand_nourriture=0

self.dcase_x=-2
self.dcase_y=-2

function self.nettoyer()
   local root=main()
   local bulle=root.stages.engine.ui.sprites.bulle
   if bulle.attache==self then
      bulle.attache=nil
      root.bulle=nil
      self.bulle=nil
   end

end


function self.proche_heuristic(obj)
   local ch=0
   if self.properties.fertile==1 then
      ch=ch+10
   end
   return ch
end
   
function self.vieillir()
   local root=main()
   local game_speed=root.stages.engine.game.game_speed
   self.properties.age=self.properties.age+(1*game_speed)

   -- jamais satisfait
   if (self.properties.bonheur > 0) then
      self.properties.bonheur=self.properties.bonheur-(5*game_speed)
   end
   
   if (self.properties.sante > 0) then
      self.properties.sante=self.properties.sante-(5*game_speed)
   else
      -- meurt par manque de nourriture
      local gm=root.stages.engine.game
      gm.meurt(self)
      gm.map.objet.delete_object(self.get_id());
      
   end
   
--   print(size(self))
end



function self.connait_nombre_type(t)
   local ct=0
   local n=0

   while n < self.n_connait do
      local obj=self.recup_object(self.connait[n])
      if obj~=nil and obj.get_type()==t then
	 ct=ct+1
      end
      n=n+1
   end

--      print(ct)
   return ct

end

function self.connait_premier_vide()
   local n=0

   while n < self.n_connait do
      if self.connait[n]==nil then
	 return n
      end
      n=n+1
   end

   return nil
end


function self.recup_object(id)
   local root=main()
   local obj=root.stages.engine.game.map.objet[id]
   if obj==nil then
      obj=root.stages.engine.game.map.decor[id]
   end
   return obj
end


function self.plus_proche(t)
   local h=1000
   local robj=nil
   
   local n=0
   while n < self.n_connait do
      if self.connait[n]~=nil then
	 local obj=self.recup_object(self.connait[n])
	 if obj~=nil then
	    if obj.get_type()==t then
	       local mx=self.get_case_x()-obj.get_case_x()
	       local my=self.get_case_y()-obj.get_case_y()
	       local ch=sqrt(mx*mx+my*my)

	       -- heuristics
	       ch=ch+obj.proche_heuristic(self);

	       if ch < h then		  
		  h=ch
		  robj=obj
	       end
	    end
	 end
      end
      n=n+1
    end

    return robj
end

function self.reflechir()
   local n=0

   local ct_poule=0
   local nb_poule=self.connait_nombre_type("poule")

   local ct_nourriture=0
   local nb_nourriture=self.connait_nombre_type("nourriture")

   local po=nil

   if (self.veut=="couver") then	     
      po=self.plus_proche("nid")
      return po
   end

   if (self.veut=="manger") then	     
      po=self.plus_proche("nourriture")
      return po
   end

   if (self.veut=="pondre" ) then
      po=self.plus_proche("nid")
     return po
   end

   if (self.veut=="reproduire") then	     
      po=self.plus_proche("poule")
     return po
   end
      
   return nil
end

function self.connait_disparu(aoid)
   local n=0
   while n < self.n_connait do
      if (self.connait[n] == aoid) then
	 self.connait[n]=nil
      end
      n=n+1
   end
end

function self.connait_deja(aoid)
   local n=0
   while n < self.n_connait do
      if (self.connait[n] == aoid) then
	 return 1
      end
      n=n+1
   end
   
   return nil
end


function self.voir_autour()
   local root=main()
   -- maj environement
   local ax=-4
   while ax~=4 do
      local ay=-4
      while ay~=4 do
	 local ao=root.stages.engine.game.map.decor.get_object_at_position(self.get_case_x()+ax,self.get_case_y()+ay)
	 if ao~=nil and (self.connait_deja(ao.get_id()) == nil) then
--	    print("-- connait")
--	    print(ao.get_type())
	    self.connait[self.n_connait]=ao.get_id()
	    self.n_connait=self.n_connait+1
	 end

	 if ax ~= 0 or ay ~= 0 then

	    local ao=root.stages.engine.game.map.objet.get_object_at_position(self.get_case_x()+ax,self.get_case_y()+ay)
	    if ao~=nil and (self.connait_deja(ao.get_id()) == nil) then
--  plante !
--	       self.faire_face(ao)
	       self.connait[self.n_connait]=ao.get_id()
	       self.n_connait=self.n_connait+1
	    end
	    
	 end
	 ay=ay+1
      end
      ax=ax+1
   end
end


-- tourner

function self.tourner()
   if self.dir=="west" then self.turn(2) end;
   if self.dir=="east" then self.turn(6) end;
   if self.dir=="north" then self.turn(0) end;
   if self.dir=="south" then self.turn(4) end;
end

function self.meme_sens(o)
   self.turn(o.get_direction())
end

function self.faire_face(o)
   local sx=self.get_case_x()
   local sy=self.get_case_y()
   local ax=o.get_case_x()
   local ay=o.get_case_y()


   if sx < ax then
      self.dir="west"
   end
   
   if sx > ax then
      self.dir="east"
   end
   
   if sy < ay then
      self.dir="south"
   end
   
   if sy > ay then
      self.dir="north"
   end

end

function self.affiche_pense()
   local root=main()
   local vis=root.stages.engine.game.visual
   local cx=floor((vis.get_x())/32);
   local cy=floor((vis.get_y())/32);
   local scr=screen_size()
   local game=root.stages.engine.game
   game.compter_bulles()
   
   if self.get_case_x()>cx and self.get_case_y()>cy and self.get_case_x()<cx+scr.w/32 and self.get_case_y()<cy+scr.h/32 then
      if self.bulle == nil and root.bulle == nil then

	 local sprites=root.stages.engine.ui.sprites
	 local spr="bulle"
	 sprites[spr].bulle_type=1	   
	 sprites[spr].attache=self	     
	 self.bulle=sprites[spr]
	 root.bulle=sprites[spr]
	 sprites[spr].graphics.main.show();
	 sprites[spr].states.set_state ("fadin",{});
      end
   end
end



function self.change_state(st,args)
   if self.states.get_state() ~= st and self.states.get_state() ~= "manger" and self.states.get_state() ~= "vendre" then
      self.states.set_state (st,args)
   end
end

function self.vivre()
   local root=main()
   self.voir_autour();

   self.veut="rien"

   if (self.properties.sante < 50) then
      self.veut="manger"
   end

   if (self.properties.bonheur < 25) then
      self.veut="bouger"
   end

   if (self.properties.sante < 35) then
      self.veut="manger"
   end

   self.veut_couvaison();

   self.veut_reproduction();
   
   -- vital !
   if (self.properties.sante < 25) then
      self.veut="manger";
   end

  
   local ao=self.reflechir();

   if ao and self.states.get_state() ~= "vendre" then
      -- a cote
      if self.veut=="manger" then
	 
	 if ((self.dcase_x == 0 and self.dcase_y == -1) or
	     (self.dcase_x == 0 and self.dcase_y == 1) or
		(self.dcase_y == 0 and self.dcase_x == -1) or
		(self.dcase_y == 0 and self.dcase_x == 1) or
		(self.dcase_y == 0 and self.dcase_x == 0)) 
	 then


	    if self.states.get_state() ~= "marcher" and self.states.get_state() ~= "manger" then
	       local o=root.stages.engine.game.map.objet.get_object_at_position(ao.get_case_x()+self.dcase_x,ao.get_case_y()+self.dcase_y)
	       if o~=nil and o~=self then
		  self.dcase_x=randomize(3)-1
		  self.dcase_y=randomize(3)-1	 
	       else
		  self.affiche_pense();		  
		  self.pathfinding_start(ao.get_case_x()+self.dcase_x,ao.get_case_y()+self.dcase_y);
		  self.pathfinding();		  
	       end
	    end

	    if self.at_position(ao.get_case_x()+self.dcase_x,ao.get_case_y()+self.dcase_y) then
	       local co=root.stages.engine.game.map.objet.get_object_at_position(self.get_case_x(),self.get_case_y())

	       if co~=nil and co~=self then
		  self.dcase_x=randomize(3)-1
		  self.dcase_y=randomize(3)-1	 
	       else
		  if self.states.get_state()~="marcher" and self.states.get_state() ~= "manger" then
		     
		     self.faire_face(ao)
		     self.tourner()
		     self.change_state("manger",{
					  mange={val_time(0,0,1,0)}
				       });
		  end
	       end
	    end
	    
	 else
	    self.dcase_x=randomize(3)-1
	    self.dcase_y=randomize(3)-1	 

	 end

      else
    
      -- dessus        
	 if self.at_position(ao.get_case_x(),ao.get_case_y()) then	     	    	    
	 -- poule seulement
	 if self.veut=="pondre" and self.states.get_state()~="marcher" then
	    self.change_state("pondre",{
				       pond={val_time(0,0,2,0)}
				    });
	 end

	 if self.veut=="couver" and self.states.get_state()~="marcher" then
	    self.change_state("couver",{
				       couve={val_time(0,0,1,0)}
				    });
	 end
	    
	 -- coq seulement
	 if self.veut=="reproduire" then
	    if self.states.get_state() ~= "reproduire" and self.states.get_state()~="marcher" then		  
	       ao.properties.fertile=1
	       self.meme_sens(ao)
	       --	       print(ao.get_type())
	       self.change_state("reproduire",{
				    feconde={val_time(0,0,1,0)}
				 });
	    end
	 end
      else
	 if self.states.get_state() ~= "marcher" then
	    
	    self.affiche_pense();
	    self.pathfinding_start(ao.get_case_x(),ao.get_case_y());
	    self.pathfinding();
	 end
      end
      
   end
end
   
   if self.veut=="rien" then
      if self.states.get_state() ~= "marcher" and  self.states.get_state() ~= "vendre" then
	 self.states.set_state("immobile",{
			   attendre={val_time(0,0,5,0)}
			});
      end
   end
   
   if self.veut=="bouger" then

      if self.states.get_state() ~= "marcher" then
	 self.affiche_pense();
	 local rx=randomize(root.stages.engine.game.map.get_w() - 1);
	 local ry=randomize(root.stages.engine.game.map.get_h() - 1);
	 
	 local o=root.stages.engine.game.map.objet.get_object_at_position(rx,ry)
	 if o==nil or o==self then
	    self.pathfinding_start(rx,ry)
	    self.pathfinding();
	 end
      end
   end
   

end


