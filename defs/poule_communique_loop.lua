function self.on_loop()
end

function self.on_stop(ev)
   local obj=self.parent.parent.parent;
   local rt=randomize(30)+1;
   local rtf=randomize(15)+1;
   obj.states.set_state ("immobile",{
			    attendre={val_time(0,0,rt,rtf)}
			 });
end