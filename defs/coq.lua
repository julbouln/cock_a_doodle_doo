function self.veut_reproduction()
   local root=main()
   local game_speed=root.stages.engine.game.game_speed

   if (self.properties.fertilite < 100) then
      self.properties.fertilite=self.properties.fertilite+(4*game_speed)
   else
      self.veut="reproduire";
   end
   
end

function self.veut_couvaison()
end