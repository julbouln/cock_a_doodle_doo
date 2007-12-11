function self.veut_reproduction()
   local root=main()
   local game_speed=root.stages.engine.game.game_speed

   if (self.properties.fertilite < 100) then
      if self.properties.fertile==1 then
	 self.properties.fertilite=self.properties.fertilite+(5*game_speed)
      end
   else
      self.properties.fertile=0
      self.veut="pondre";
   end

end

function self.veut_couvaison()
   local root=main()
   local ancien_veut=self.veut
   self.veut="couver";
   local ao=self.reflechir();
   local o=root.stages.engine.game.map.objet.get_object_at_position(ao.get_case_x(),ao.get_case_y())
   if ao.properties.oeufs >= 12 and ao.properties.couvaison < 100 and (o==nil or o==self) then	 
      --	 ao.properties.couvaison
   else
      self.veut=ancien_veut
   end
end

function self.pondre()
   local root=main()
   local nid=root.stages.engine.game.map.decor.get_object_at_position(self.get_case_x(),self.get_case_y())
   nid.properties.oeufs=nid.properties.oeufs+1

end