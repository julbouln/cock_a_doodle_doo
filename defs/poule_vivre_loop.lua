self.init_bcentre("main");
local rt=randomize(60)+1;
local rtf=randomize(30)+1;
self.states.set_state ("immobile",{
			  attendre={val_time(0,0,rt,rtf)}
		       });

function self.pondre()
   local o=root.stages.engine.game.map.objet.add_object_from_type("oeuf",self.get_case_x(),self.get_case_y())
   return o
end

function self.vieillir()
   self.properties.age=self.properties.age+1
end

function self.vivre()
   if (self.properties.fertilite < 100) then
      self.properties.fertilite=self.properties.fertilite+1
   else
      self.properties.fertilite=0;
      local o=self.pondre();
      root.stages.engine.game.faire_vieillir(o);
   end

end