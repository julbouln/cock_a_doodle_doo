function self.on_loop()
   local root=main()
   local obj=self.parent.parent.parent;
   local ao=root.stages.engine.game.map.decor.get_object_at_position(obj.get_case_x(),obj.get_case_y())
   
      local game_speed=root.stages.engine.game.game_speed

   if ao and ao.properties.metatype=="nourriture" then

      ao.properties.qty=ao.properties.qty-(1*game_speed)
      ao.graphics.main.on_update();

      if obj.properties.pelage < 200 then
	 obj.properties.pelage=obj.properties.pelage+ao.properties.bonus_pelage
      end
      obj.properties.sante=obj.properties.sante+((5+ao.properties.bonus_nourriture)*game_speed)

      if obj.properties.masse < 5.0 then
	 obj.properties.masse=obj.properties.masse + (0.01*game_speed)
      end
   end
   
end

function self.on_start(ev)
   local obj=self.parent.parent.parent;

   local r=randomize(1)
   
   if r==0 then
      obj.rand_nourriture=0
   end

end

function self.on_stop(ev)
   local obj=self.parent.parent.parent;
--   print("reinit")
--   print(obj.get_id())
--   obj.rand_nourriture=0
   --obj.rand_poule=0

end