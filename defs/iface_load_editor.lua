
-- donnée pour l'outil
self.outil={};
-- type d'outil : objet, terrain, supprime, deplace
self.outil.type=nil;
-- valeur specifique a l'outil
-- objet : map, id
-- terrain : num
self.outil.valeur={};
-- taille du pinceau
self.outil.pinceau=1;


function self.reset_outils()
   local iface=self.iface;
   iface["suppr_button"].set_released();
   iface["move_button"].set_released();
end

function self.reset_pinceaux()
   local iface=self.iface;
   iface["1x1_button"].set_released();
   iface["3x3_button"].set_released();
   iface["5x5_button"].set_released();
end

function self.reset_objets()
   local iface=self.iface;
   if self.outil.type=="objet" then
      engine=self.parent.engine;
      local mo=engine.map[self.outil.valeur.map];
      local o=mo[self.outil.valeur.id];
      iface[o.get_type()].set_released();
   end
end

function self.clear_objet()
   local iface=self.iface;
   if self.outil.type=="objet" then
      engine=self.parent.engine;
      local mo=engine.map[self.outil.valeur.map];
      mo.delete_object(self.outil.valeur.id);
   end
end

function self.reset_terrains()
   local iface=self.iface;
   if self.outil.type=="terrain" then
      if self.outil.valeur.num~=nil then
	 tn=(format("terrain_%i",self.outil.valeur.num));	
	 iface[tn].set_released();
      end
   end
end

-- creer dynamiquement la fenetre d'outil pour un type de carte 
function self.ajout_editeur(m,k,o)
   local stages=self.parent;
   local iface=self.iface;
   local engine=self.parent.engine;
   local mo=engine.map[m];

   if o.graphics.thumb~=nil then
--      print(o.graphics.thumb.get_drawing_id())
--      o.graphics.thumb.make_thumb(o.graphics.main);   

      o.graphics.thumb.reinit_drawing();
      cont=(format("%s_container",m));

      iface.add_object_from_type_to(o.get_id(),"case_editeur",cont);
      n=mo.add_object_named_from_type(o.get_id(),o.get_id(),-32,-32);

      if o.properties.nom~=nil then
	 local nom=iface[o.get_id()].sprite.graphics.nom_editeur;
	 nom.set_text(o.properties.nom);
      end

      mo[o.get_id()].graphics.thumb.show();
--      mo[o.get_id()].graphics.thumb.reinit_drawing();
      
      oid=(format("%s#%s",m,o.get_id()));
--      print (format("Ajout de %s",oid));
      stages.copy_graphic("thumb","engine",oid,"iface",o.get_id());
      stages.copy_graphic("main","engine",oid,"iface",o.get_id());

      
      local spr=iface[o.get_id()].sprite;
      spr.graphics.thumb.on_update=spr.graphics.thumb.iface_update;
      if spr.graphics.main.iface_update~=nil then
      spr.graphics.main.on_update=spr.graphics.main.iface_update;
      else
	 print(format("!Erreur thumb: %s",o.get_id()))
      end
      mo.delete_object(o.get_id());
      
      iface[o.get_id()].sprite.graphics.thumb.set_layer(30);
     iface[o.get_id()].sprite.graphics.main.hide();

--      iface[o.get_id()].show();
      
   end   
end

function self.ajout_faune(k,o)
   self.ajout_editeur("faune",k,o);
end
function self.ajout_flore(k,o)
   self.ajout_editeur("flore",k,o);
end
function self.ajout_decor(k,o)
   self.ajout_editeur("decor",k,o);
end
function self.ajout_objet(k,o)
   self.ajout_editeur("objet",k,o);
end
function self.ajout_unite(k,o)
   self.ajout_editeur("unite",k,o);
end


function self.ajout_property(l,v)
   local iface=self.iface;
   if type(v)~="table" then
   cid=(format("prop_%s_container",l));	
   iface.add_object_from_type_to(cid,"properties_edit_container","objedit_container");
   iface[cid].init(l,v);
   end
end


function foreach(t,f)
 local l,v = next(t, nil);
  while l ~= nil do
    f(l,v);
    l,v = next(t, l)
  end
end


function self.on_load()
   local iface=self.iface;
   local engine=self.parent.engine;
   

   -- test	
   local tprops={};
   tprops.nom="blabla";
   tprops.masse=10;
   tprops.test="bla";
   tprops.test2="bla";
   tprops.test3="bla";
   tprops.test4="bla";
   tprops.size={}
   tprops.size.w=10;


--   foreach(tprops,self.ajout_property);


	

   -- tiles
   local nbt=0;
   while nbt~=12 do
      tn=(format("terrain_%i",nbt));	
      iface.add_object_from_type_to(tn,"case_terrain","terrains_container");
      iface[tn].sprite.graphics.case_terrain.set_cur_drawing(nbt*3);
      nbt=nbt+1;
   end	
   
   -- objets de la carte dans le menu
--   engine.map.faune.types.foreach_object(self.ajout_faune);
--   engine.map.flore.types.foreach_object(self.ajout_flore);
   engine.map.decor.types.foreach_object(self.ajout_decor);
   engine.map.objet.types.foreach_object(self.ajout_objet);
--   engine.map.unite.types.foreach_object(self.ajout_unite);

   -- placement des fenetre d'objets
   iface.faune_win.move(randomize(600),randomize(400));
   iface.flore_win.move(randomize(600),randomize(400));
   iface.decor_win.move(randomize(600),randomize(400));
   iface.objet_win.move(randomize(600),randomize(400));
   iface.unite_win.move(randomize(600),randomize(400));
   
   iface.terrains_win.move(randomize(600),randomize(400));

      
end