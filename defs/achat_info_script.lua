function self.thumb(id)
   local root=main()
   local decor=root.stages.engine.game.map.decor;
   local o=decor.types[id]
   local dri=self.create_from_vault(o.graphics.main.get_drawing_id());
   local w=o.graphics.main.get_w();
   local h=o.graphics.main.get_h();
   local wm=32/w * 100;
   local hm=32/h * 100;   

   self.write(dri,0,"unset_alpha",{});

   local dr=nil

   if o.properties.metatype=="nourriture" then
      dr=self.copy(dri,2,"resize",{{w=wm,h=hm}});
   end
   if o.properties.metatype=="nid" then
      dr=self.copy(dri,0,"resize",{{w=wm,h=hm}});
   end
   if o.properties.metatype=="decoration" then
      dr=self.copy(dri,0,"resize",{{w=wm,h=hm}});
   end

   self.write(dr,0,"set_alpha",{{r=255,g=255,b=255}});
   self.write(dri,0,"set_alpha",{{r=255,g=255,b=255}});
   return dr
end


function self.my_drawing_script(drf,fr)
   local root=main()
   local sprites=root.stages.engine.ui.sprites;
   local p=sprites.types.win_info_pattern;
   local drc=self.create_from_vault(p.graphics.main.get_drawing_id());
   
   local obj=root.stages.engine.game.current_buy_object()
   
   if obj~=nil then   
--   obj=root.stages.engine.game.selection

      --		poule=self.parent.parent.parent.parent.parent.parent.engine.poule
      local nom=self.create("create_text",{{r=0,g=0,b=0},obj.properties.nom,16,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,50,12)
      
      local ico=self.thumb(obj.get_type())
      self.compose(ico,0,drc,0,10,4)
      
      --   nom=self.create("create_text",{{r=0,g=0,b=0},"Grain",16,"medias/fonts/samos.ttf"})
      --   self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      --   self.compose(nom,0,drc,0,64,38)
      
      local v=self.create("create_text",{{r=0,g=0,b=0},"Buy",16,"medias/fonts/samos.ttf"})		
      self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(v,0,drc,0,50,148)
      
      local ico=self.create("load",{"medias/icones/32x32/achat.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,90,142)
      
      local v=self.create("create_text",{{r=0,g=0,b=0},obj.properties.price,20,"medias/fonts/samos.ttf"})		
      self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(v,0,drc,0,124,146)

      if obj.properties.metatype=="nourriture" then
	 local v=self.create("create_text",{{r=0,g=0,b=0},format("%i/%i",root.stages.engine.game.selection_nourriture,size(root.stages.engine.game.achats_nourriture)),20,"medias/fonts/Vera.ttf"})		
      self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(v,0,drc,0,88,186)
      end

      if obj.properties.metatype=="nid" then
	 local v=self.create("create_text",{{r=0,g=0,b=0},format("%i/%i",root.stages.engine.game.selection_batiment,size(root.stages.engine.game.achats_batiment)),20,"medias/fonts/Vera.ttf"})		
      self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(v,0,drc,0,88,186)
   end

      if obj.properties.metatype=="decoration" then
	 local v=self.create("create_text",{{r=0,g=0,b=0},format("%i/%i",root.stages.engine.game.selection_decoration,size(root.stages.engine.game.achats_decoration)),20,"medias/fonts/Vera.ttf"})		
	 self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
	 self.compose(v,0,drc,0,88,186)
      end


      
      self.write(drc,0,"set_alpha",{fr,{r=255,g=255,b=255}});
      
   end
   return drc
end

function self.on_loop()
   if (self.get_frame()==7) then
      self.parent.parent.set_state("statique",{})
   end
end

function self.on_start(ev)
   local root=main()
   local sprites=root.stages.engine.ui.sprites;

   root.stages.engine.ui.sprites.achat_icon.graphics.main.hide()
   root.stages.engine.ui.sprites.vente_icon.graphics.main.hide()
--   root.stages.engine.ui.sprites.vente_icon.graphics.main.hide()
   
   local obj=root.stages.engine.game.current_buy_object()
   if obj~=nil then
      sprites.achat_icon.graphics.main.show()
   end
end
