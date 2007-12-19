
function self.on_start(v)
   local obj=self.parent.parent.parent;
end

function self.on_loop()
   local obj=self.parent.parent.parent;
   local map=obj.parent.parent;
   local speed=obj.properties.speed;
   local np=obj.next_position();   

   local st=obj.states.get_state_val();

   if st.deplacement[0].dir=="west" then obj.turn(2) end;
   if st.deplacement[0].dir=="east" then obj.turn(6) end;
   if st.deplacement[0].dir=="north" then obj.turn(0) end;
   if st.deplacement[0].dir=="south" then obj.turn(4) end;

  if obj.dpix>=32 then
      obj.dpix=0;
      obj.pathfinding();
   else
      obj.dpix=obj.dpix+obj.properties.speed;
   end

end