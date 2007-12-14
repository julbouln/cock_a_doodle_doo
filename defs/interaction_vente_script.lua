function self.on_mouseclick(x,y)
   local stages=self.parent.parent.parent.parent
   local game=stages.engine.game
   local obj=stages.engine.game.selection
   
   if obj ~=nil then
      if obj.properties.metatype=="poule" or obj.properties.metatype=="coq" then
	 obj.states.set_state("vendre",{vend={val_time(0,0,1,0)}})
	 obj=nil
      end


      if obj~=nil and obj.get_type()=="nid" then
	 if obj.properties.oeufs >= 6 then
	    obj.properties.oeufs=obj.properties.oeufs-6
	    stages.engine.ui.sprites.argent.properties.total=stages.engine.ui.sprites.argent.properties.total + 6
	    stages.engine.ui.sprites.argent.graphics.main.set_text(format("$ %i",stages.engine.ui.sprites.argent.properties.total))
	 end
      end
   end
end