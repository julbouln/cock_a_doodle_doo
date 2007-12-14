function self.count_text(c)
   local v=self.create("create_text",{{r=0,g=0,b=0},c,18,"medias/fonts/Vera.ttf"})		
   self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
 
   return v
end


function self.count_bar_simple(c,r,g,b)
   local col=val_color(r,g,b)

   local bg=self.create("box",{val_color(255,255,255),val_size(50,16)})
   local cb=self.create("box",{col,val_size(floor(c/2),16)})
   local fg=self.create("rect",{val_color(0,0,0),val_size(50,16)})
   self.write(fg,0,"set_alpha",{255,{r=255,g=255,b=255}});
   self.compose(cb,0,bg,0,0,0)
   self.compose(fg,0,bg,0,0,0)
   self.write(bg,0,"set_alpha",{255,{r=255,g=255,b=255}});
   return bg
end

function self.count_bar(c)
   local col=val_color(53,195,26)
   if c < 50 then
      col=val_color(255,255,0)
   end
   if c<20 then
      col=val_color(216,19,19)
   end
   local bg=self.create("box",{val_color(255,255,255),val_size(50,16)})
   local cb=self.create("box",{col,val_size(floor(c/2),16)})
   local fg=self.create("rect",{val_color(0,0,0),val_size(50,16)})
   self.write(fg,0,"set_alpha",{255,{r=255,g=255,b=255}});
   self.compose(cb,0,bg,0,0,0)
   self.compose(fg,0,bg,0,0,0)
   self.write(bg,0,"set_alpha",{255,{r=255,g=255,b=255}});
   return bg
end

function self.my_drawing_script(drf,fr)
   local root=main()
   local sprites=root.stages.engine.ui.sprites;
   
   local p=sprites.types.win_info_pattern;
   local drc=self.create_from_vault(p.graphics.main.get_drawing_id());
   
   local obj=root.stages.engine.game.selection

   if obj~=nil then
   --		poule=self.parent.parent.parent.parent.parent.parent.engine.poule
      local nom=self.create("create_text",{{r=0,g=0,b=0},obj.properties.nom,16,"medias/fonts/samos.ttf"})
   self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
   self.compose(nom,0,drc,0,50,12)
   
   if obj.properties.metatype=="nourriture" then
      local nom=self.create("create_text",{{r=0,g=0,b=0},"Reserve",13,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,10,44)

      local ico=self.create("load",{"medias/icones/pense/faim.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,80,38)

      local v=self.count_bar(floor(obj.properties.qty/5))
      self.compose(v,0,drc,0,134,44)
   end

   if obj.properties.metatype=="nid" then
      local nom=self.create("create_text",{{r=0,g=0,b=0},"Quantity",12,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,10,44)

      local ico=self.create("load",{"medias/icones/pense/pondre.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,80,38)

      local v=self.count_bar(floor((100*obj.properties.oeufs)/12))
      self.compose(v,0,drc,0,134,44)

      local v=self.count_bar_simple(obj.properties.couvaison,30,172,3)
      self.compose(v,0,drc,0,134,44)
   end

   if obj.properties.metatype=="poule" or obj.properties.metatype=="coq" or obj.properties.metatype=="poussin" then

      -- bonheur
      local nom=self.create("create_text",{{r=0,g=0,b=0},"Happiness",12,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,10,44)

      local ico=self.create("load",{"medias/icones/32x32/smiley.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,90,38)
      
      local v=self.count_bar(obj.properties.bonheur)
      self.compose(v,0,drc,0,134,44)
      
      -- sante
      local nom=self.create("create_text",{{r=0,g=0,b=0},"Health",13,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,10,78)

      local ico=self.create("load",{"medias/icones/32x32/sante.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,90,70)
      
      local v=self.count_bar(obj.properties.sante)
      self.compose(v,0,drc,0,134,78)
   
      -- pelage
      local nom=self.create("create_text",{{r=0,g=0,b=0},"Pelt",13,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,10,108)

      ico=self.create("load",{"medias/icones/32x32/pelage.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,90,102)

      local v=self.count_bar(obj.properties.pelage/2)
      self.compose(v,0,drc,0,134,108)
      
      -- sexe
      local nom=self.create("create_text",{{r=0,g=0,b=0},"Reproduction",11,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,10,138)

--      if (obj.properties.sexe=="female") then
      local ico=self.create("load",{"medias/icones/32x32/sexe_femelle.png"})
--      end
      if (obj.properties.sexe=="male") then
	 ico=self.create("load",{"medias/icones/32x32/sexe_male.png"})
      end
      
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,90,134)
   
      local v=self.count_bar(obj.properties.fertilite)
      self.compose(v,0,drc,0,134,138)


      -- vieillesse
      local nom=self.create("create_text",{{r=0,g=0,b=0},"Aging",13,"medias/fonts/samos.ttf"})
      self.write(nom,0,"set_alpha",{255,{r=255,g=255,b=255}});   
      self.compose(nom,0,drc,0,10,168)

      local ico=self.create("load",{"medias/icones/autres/mourrir.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,84,166)

      local v=self.count_bar((200 - obj.properties.age)/2)
      self.compose(v,0,drc,0,134,168)

-- prix
--      local price=floor(obj.properties.masse*10*(obj.properties.sante + obj.properties.bonheur)/200)
      local price=obj.prix()
      local v=self.create("create_text",{{r=0,g=0,b=0},price,20,"medias/fonts/samos.ttf"})		
      self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(v,0,drc,0,124,276)

   end

   if obj.properties.metatype=="nid" then
      if obj.properties.oeufs >= 6 then
	 local v=self.create("create_text",{{r=0,g=0,b=0},"6",20,"medias/fonts/samos.ttf"})		
	 self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
	 self.compose(v,0,drc,0,124,276)
      end
  end
 
   if obj.properties.metatype~="nourriture" then

      local v=self.create("create_text",{{r=0,g=0,b=0},"Sell",16,"medias/fonts/samos.ttf"})		
      self.write(v,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(v,0,drc,0,50,278)
   
      local ico=self.create("load",{"medias/icones/32x32/vente.png"})
      self.write(ico,0,"set_alpha",{64,{r=255,g=255,b=255}});
      self.compose(ico,0,drc,0,90,272)
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

   local obj=root.stages.engine.game.selection
   if obj~=nil then	
      if obj.properties.metatype=="nid" then	 
	 if obj.properties.oeufs >= 6 then
	    sprites.vente_icon.graphics.main.show()
	 end
      end
      if  obj.properties.metatype=="poule" then
	 sprites.vente_icon.graphics.main.show()
      end
      if obj.properties.metatype=="coq" then
	 sprites.vente_icon.graphics.main.show()
      end
   end
end