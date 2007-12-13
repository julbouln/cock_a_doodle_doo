function self.on_mouseclick(x,y)
   local stages=self.parent.parent.parent.parent
   local engine=stages.engine.game
   local sprites=stages.engine.ui.sprites

   if sprites.valider_niveau.visible then   
   sprites.valider_niveau.graphics.main.hide();
   sprites.niveau_info.graphics.main.hide();
   sprites.valider_niveau.visible=nil
   engine.map.unpause();   
   engine.parent.ui.sprites.pause.graphics.main.hide();

   end
end