
function self.my_drawing_script(drf,fr)
   local root=main()
   local obj=self.parent.parent.parent;
   local sprites=root.stages.engine.ui.sprites;
   local graphics=self.parent.parent.parent.graphics;
   local drb=self.create_from_vault(graphics.bulle.get_drawing_id());
   local dr=self.create_from_vault(graphics.pic.get_drawing_id());
   
   self.compose(drb,0,drf,0,0,0)
   self.compose(dr,obj.bulle_type,drf,0,32,32)
   
   local ico=nil
   
   if obj.attache.veut=="manger" then
      ico=self.create("load",{"medias/icones/pense/faim.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drf,0,10,4)
   end
   
   if obj.attache.veut=="pondre" or obj.attache.veut=="couver" then
      ico=self.create("load",{"medias/icones/pense/pondre.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drf,0,10,4)
   end
   
   if obj.attache.veut=="bouger" then
      ico=self.create("load",{"medias/icones/pense/move.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drf,0,10,4)
   end
   
   if obj.attache.veut=="reproduire" then
      ico=self.create("load",{"medias/icones/32x32/sexe_femelle.png"})
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drf,0,16,2)
   end
   
   if obj.attache.veut=="rien" then
      ico=self.create("create_text",{{r=0,g=0,b=0},"?",18,"medias/fonts/samos.ttf"})		
      
      self.write(ico,0,"set_alpha",{255,{r=255,g=255,b=255}});
      self.compose(ico,0,drf,0,28,8)
   end
   
   self.write(drf,0,"set_alpha",{fr,{r=255,g=255,b=255}});
   return drf
end

function self.on_loop()
   if (self.get_frame()==7) then
      
      self.parent.parent.set_state("statique",{afficher={val_time(0,0,5,0)}})
   end
end