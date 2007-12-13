
function self.verification(k,ao)
   if ao.get_type()=="nourriture" then
      if ao.properties.qty <= 0 then
	 
	 self.map.decor.delete_object(ao.get_id())


      end
   end

end


self.buy=nil
self.buy_list={"nourriture","nid"}
self.current_buy=0

self.pose_achat=nil

self.game_speed=1

self.volaille_compteur=0
self.victoire=nil

self.pause=nil

function self.verifier_victoire()
   if self.victoire then
      print("Victory!")
   end
end

function self.compter_volaille(k,obj)
   self.volaille_compteur=self.volaille_compteur+1;
end

function self.compter_volailles()
   local stages=self.parent.parent;
   self.volaille_compteur=0
   self.map.objet.foreach_object(self.compter_volaille)   

   stages.engine.ui.sprites.population.properties.total=self.volaille_compteur
   stages.engine.ui.sprites.population.graphics.main.set_text(format("%i",stages.engine.ui.sprites.population.properties.total))

end

function self.current_buy_object()
   local ot=self.buy_list[self.current_buy];
   return self.map.decor.types[ot]
end

-- selection
self.selection=nil
self.current_poule=0


function self.select_object(obj)
   local sprites=self.parent.ui.sprites;
   self.unselect_all()
   self.selection=obj;
   obj.graphics.main.hide();
   obj.graphics.main_border.show();
   
   sprites.vente_info.states.set_state ("fadin",{});
   sprites.vente_info.graphics.main.show();
   
   sprites.achat_info.states.set_no_state();
   sprites.achat_info.graphics.main.hide();
   
end

function self.unselect_object(k,obj)
   obj.graphics.main_border.hide();
   obj.graphics.main.show();
end

function self.unselect_all()
   local sprites=self.parent.ui.sprites;


   sprites.achat_info.states.set_state("fadout",{});
   sprites.vente_info.states.set_state("fadout",{});

   self.map.objet.foreach_object(self.unselect_object)
   self.map.decor.foreach_object(self.unselect_object)


end


function self.select_poules()
   local sprites=self.parent.ui.sprites;	  
   local poules={};
   local n_poules=0;
   local x=0;
   while x < 10 do
      local y=0;
      while y < 8 do
	 local obj=self.map.objet.get_object_at_position(floor(self.visual.get_x()/32+x),floor(self.visual.get_y()/32+y)) 
	 if(obj ~= nil) then
	    	    

	    
	    if(self.current_poule==n_poules) then
	       self.select_object(obj)
	    else
	       self.unselect_object("",obj)
	    end
	    poules[n_poules]=obj;
	    n_poules=n_poules+1;
	    
	 end
	 y=y+1
      end
      x=x+1
   end 
   if(self.current_poule >= n_poules) then
      sprites.vente_info.states.set_state ("fadout",{});
      self.current_poule=-1;
   end
   
   
end

function self.enclos()
   local barriere=self.map.decor.add_object_from_type("barriere_s",6,9)
   barriere=self.map.decor.add_object_from_type("barriere_s",8,8)
   
   
   barriere=self.map.decor.add_object_from_type("barriere",6,10)
   barriere=self.map.decor.add_object_from_type("barriere",8,11)

   
   barriere=self.map.decor.add_object_from_type("barriere_s",10,11)
   barriere=self.map.decor.add_object_from_type("barriere_s",12,10)
   
   
   barriere=self.map.decor.add_object_from_type("barriere",10,8)
   barriere=self.map.decor.add_object_from_type("barriere",12,9)
end

self.n_bulles=0

function self.compter_bulle(k,o)
   if o.get_type()=="bulle" then
      self.n_bulles=self.n_bulles+1
   end
end

function self.compter_bulles()
   local sprites=self.parent.ui.sprites
   self.n_bulles=0
   sprites.foreach_sprite(self.compter_bulle)
end

function self.eclosion(k,o)
   local ox=o.get_case_x();
   local oy=o.get_case_y();

   if (o.get_type()=="nid" and o.properties.oeufs >= 12 and o.properties.couvaison >= 100) then
      o.properties.oeufs=0
      o.properties.couvaison=0
      local n=0
      while n < 3 do
	 local sexe=randomize(8)
	 local oid=self.map.objet.add_object_from_type("poussin",ox,oy);   
	 if sexe<3 then
	    self.map.objet[oid].properties.sexe="male"
	 end
	 self.faire_vieillir(oid);
	 self.faire_vivre(oid);
	 n=n+1
      end
   end
end

function self.transformation(k,o)
   local oid=o.get_id();
   local ox=o.get_case_x();
   local oy=o.get_case_y();

   if ((o.get_type()=="poule" or o.get_type()=="coq") and o.properties.age > 200) then
      -- meurt
      o.nettoyer();
      self.meurt(o);
      self.map.objet.delete_object(oid);
   end
   
   if (o.get_type()=="poussin" and o.properties.age > 50) then

      local sexe=o.properties.sexe
      local connait=o.connait
      local n_connait=o.n_connait
      o.timer.clear();
      self.map.objet.delete_object(oid);
      if sexe=="male" then
	 self.map.objet.add_object_named_from_type(oid,"coq",ox,oy);   
      else
	 self.map.objet.add_object_named_from_type(oid,"poule",ox,oy);   
      end
      local no=self.map.objet[oid]
      no.connait=connait
      no.n_connait=n_connait
      self.faire_vieillir(oid);
      self.faire_vivre(oid);

   end


end

function self.meurt(o)
   local sprites=self.parent.ui.sprites
   local ax=o.get_pixel_x() - self.visual.get_x()
   local ay=o.get_pixel_y() - self.visual.get_y()
   local m=sprites.add_sprite_from_type("mort",ax,ay);
   sprites[m].ax=ax
   sprites[m].ay=ay
   sprites[m].states.set_state ("effet",{
				     translation={60,val_position(ax,ay-50)}
				  });
end

function self.eclosions()
   self.map.decor.foreach_object(self.eclosion)
end

function self.transformations()
   self.map.objet.foreach_object(self.transformation)
end

function self.verifications()
   self.map.decor.foreach_object(self.verification)
end



function self.faire_vieillir(poule)
  self.map.objet[poule].timer.add_task(val_time(0,0,10,0), self.map.objet[poule].vieillir);
end

function self.faire_vieillir_l(k,obj)
   self.faire_vieillir(k)
end


function self.faire_vivre(poule)
   self.map.objet[poule].timer.add_task(val_time(0,0,1,0), self.map.objet[poule].vivre);
end

function self.faire_vivre_l(k,obj)
   self.faire_vivre(k)
end

function self.autosave()
   self.map.save_to_file("autosave.xml")
end

function self.charger_niveau(f)
   self.map.load_from_file(f);

   self.map.objet.foreach_object(self.faire_vivre_l)
   self.map.objet.foreach_object(self.faire_vieillir_l)
end

function self.on_load()
   print ("* load game")

   self.timer.add_task(val_time(0,0,5,0),self.transformations);
   self.timer.add_task(val_time(0,0,5,0),self.eclosions);
   self.timer.add_task(val_time(0,0,10,0),self.verifications);

   self.timer.add_task(val_time(0,1,0,0),self.autosave);

   self.timer.add_task(val_time(0,0,10,0),self.compter_volailles);
   self.timer.add_task(val_time(0,0,10,0),self.verifier_victoire);

--   self.timer.add_task(val_time(0,0,10,0),gc_infos);
--   self.timer.add_task(val_time(0,0,20,0),gc_full);
--   self.timer.add_task(val_time(0,0,10,0),gc_dump_heap);

--   self.timer.add_task(val_time(0,1,0,0),sync_caches);
--   self.timer.add_task(val_time(0,1,0,0),gc_full);

   self.timer.start();

end

function self.on_loop()
--   gc_infos();

      self.timer.step();

end