      self.open=nil

function self.demarre_niveau_info()
   self.game.map.pause();
   self.ui.sprites.pause.graphics.main.show();
   self.ui.sprites.niveau_info.graphics.main.show();
   self.ui.sprites.valider_niveau.graphics.main.show();
   self.ui.sprites.valider_niveau.visible=1
   
end

function self.on_load()
   print("* load engine")
   if self.open ~= nil then
      self.game.charger_niveau(self.open)
   else
      self.game.charger_niveau("niveau1.xml")
   end
   self.demarre_niveau_info()
 
   self.game.compter_volailles()	  
end