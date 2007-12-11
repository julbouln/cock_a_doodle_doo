function self.on_mouseclick(x,y)
   local stages=self.parent.parent.parent.parent
   local game=stages.engine.game
   local obj=stages.engine.game.current_buy_object()
   if obj ~=nil then
      local sprites=self.parent.parent.sprites
--      sprites.achat_info.states.set_state ("fadout",{});
      game.pose_achat=game.map.decor.add_object_from_type(obj.get_type(),0,0);

      
   end
end