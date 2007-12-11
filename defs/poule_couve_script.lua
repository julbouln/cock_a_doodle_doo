function self.on_loop()
   local root=main()
   local obj=self.parent.parent.parent;
   local ao=root.stages.engine.game.map.decor.get_object_at_position(obj.get_case_x(),obj.get_case_y())
      local game_speed=root.stages.engine.game.game_speed

   ao.properties.couvaison=ao.properties.couvaison+(1*game_speed)

end