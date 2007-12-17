function self.cacher_vente()
   local sprites=self.sprites;
   sprites.vente_info.states.set_no_state();
   sprites.vente_info.graphics.main.hide();
   sprites.vente_icon.graphics.main.hide();
   sprites.vente_icon.visible=nil
end

function self.afficher_vente()
   local root=main()
   local sprites=self.sprites;
   sprites.vente_info.states.set_state ("fadin",{});
   sprites.vente_info.graphics.main.show();

   local obj=root.stages.engine.game.selection
   if obj~=nil and (obj.properties.metatype=="poule" or obj.properties.metatype=="coq" or obj.properties.metatype=="nid") then
      sprites.vente_icon.graphics.main.show();
      sprites.vente_icon.visible=1
   end
   self.cacher_achat()
end

function self.cacher_achat()
   local sprites=self.sprites;
   sprites.achat_info.states.set_no_state();
   sprites.achat_info.graphics.main.hide();

   sprites.suivant_icon.graphics.main.hide()
   sprites.precedent_icon.graphics.main.hide()
   sprites.suivant_icon.visible=nil
   sprites.precedent_icon.visible=nil

   sprites.achat_icon.graphics.main.hide();
   sprites.achat_icon.visible=nil
end

function self.afficher_achat(metatype)
   local sprites=self.sprites;
   local stages=self.parent.parent
   local game=stages.engine.game
   
   sprites.achat_info.states.set_state ("fadin",{});
   sprites.achat_info.graphics.main.show();

   if metatype=="nourriture" then
      if game.selection_nourriture < size(game.achats_nourriture) then
	 sprites.suivant_icon.graphics.main.show()
	 sprites.suivant_icon.visible=1
      end
      if game.selection_nourriture > 1 then
	 sprites.precedent_icon.graphics.main.show()
	 sprites.precedent_icon.visible=1
      end

   end

   if metatype=="nid" then
      if game.selection_batiment < size(game.achats_batiment) then
	 sprites.suivant_icon.graphics.main.show()
	 sprites.suivant_icon.visible=1
      end
      if game.selection_batiment > 1 then
	 sprites.precedent_icon.graphics.main.show()
	 sprites.precedent_icon.visible=1
      end
   end

   if metatype=="decoration" then
      if game.selection_decoration < size(game.achats_decoration) then
	 sprites.suivant_icon.graphics.main.show()
	 sprites.suivant_icon.visible=1
      end
      if game.selection_decoration > 1 then
	 sprites.precedent_icon.graphics.main.show()
	 sprites.precedent_icon.visible=1
      end
   end

   sprites.achat_icon.graphics.main.show();
   sprites.achat_icon.visible=1

   if metatype=="nourriture" then
      game.achat_encours=game.achats_nourriture[game.selection_nourriture]
   end

   if metatype=="nid" then
      game.achat_encours=game.achats_batiment[game.selection_batiment]
   end

   if metatype=="decoration" then
      game.achat_encours=game.achats_decoration[game.selection_decoration]
   end

   self.cacher_vente()
end

function self.on_load()
   print("* load ui")
   local sprites=self.sprites;
   local scr=screen_size()
   
   sprites.add_sprite_named_from_type("main_cursor","main",16,12);
   sprites.main_cursor.graphics.main.hide();
   
   sprites.add_sprite_named_from_type("menu_icon","menu_icon",10,4);
   sprites.add_sprite_named_from_type("build_icon","build_icon",100,4);
   sprites.add_sprite_named_from_type("feed_icon","feed_icon",124,4);
   sprites.add_sprite_named_from_type("decoration_icon","decoration_icon",148,4);
   sprites.add_sprite_named_from_type("stats_icon","stats_icon",400,4);
   
   sprites.add_sprite_named_from_type("argent","argent",scr.w-60,4);
   sprites.argent.graphics.main.set_text("$ 50")
   
   sprites.add_sprite_named_from_type("pause","pause",16,32);
   sprites.pause.graphics.main.set_text("PAUSE");
   sprites.pause.graphics.main.hide();
   
   sprites.add_sprite_named_from_type("population","population",scr.w-100,4);
   sprites.population.graphics.main.set_text("0")

   sprites.add_sprite_named_from_type("vente_icon","vente_icon",scr.w-118,296);
   sprites.vente_icon.graphics.main.hide()
   
   sprites.add_sprite_named_from_type("achat_icon","achat_icon",scr.w-118,266);
   sprites.achat_icon.graphics.main.hide()

   sprites.add_sprite_named_from_type("suivant_icon","suivant_icon",scr.w-60,314);
   sprites.suivant_icon.graphics.main.hide()

   sprites.add_sprite_named_from_type("precedent_icon","precedent_icon",scr.w-160,314);
   sprites.precedent_icon.graphics.main.hide()
   
   sprites.add_sprite_named_from_type("bulle","bulle",0,0);
   
   sprites.bulle.graphics.main.hide()
   
   sprites.add_sprite_named_from_type("menu","win_menu",-4,-4);
   
   sprites.add_sprite_named_from_type("vente_info","vente_info",scr.w-208,24);
   sprites.vente_info.graphics.main.hide();
   
   sprites.add_sprite_named_from_type("achat_info","achat_info",scr.w-208,24);
   sprites.achat_info.graphics.main.hide();
   
   sprites.add_sprite_named_from_type("niveau_info","niveau_info",100,100);
   sprites.niveau_info.graphics.main.hide();
   sprites.add_sprite_named_from_type("valider_niveau","valider_icon",450,390);
   sprites.valider_niveau.graphics.main.hide();
   sprites.valider_niveau.visible=nil
   
   sprites.add_sprite_named_from_type("victoire_info","victoire_info",100,100);
   sprites.victoire_info.graphics.main.hide();
   sprites.add_sprite_named_from_type("valider_victoire","valider_icon",450,390);
   sprites.valider_victoire.graphics.main.hide();
   sprites.valider_victoire.visible=nil
   
end