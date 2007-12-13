function self.on_mouseclick(x,y)
   local stages=self.parent.parent.parent.parent
   local engine=stages.engine.game
   local sprites=stages.engine.ui.sprites

   if sprites.valider_victoire.visible then
   sprites.valider_victoire.graphics.main.hide();
   sprites.victoire_info.graphics.main.hide();
      sprites.valider_victoire.visible=nil   
   stages.load("start")
   end
end