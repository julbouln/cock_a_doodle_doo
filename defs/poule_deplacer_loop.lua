
function self.on_start(v)
   local obj=self.parent.parent.parent;


end

function self.on_loop()
   local obj=self.parent.parent.parent;
   local map=obj.parent.parent;
   local speed=obj.properties.speed;
   local np=obj.next_position();   



   local st=obj.states.get_state_val();
--   obj.tourner()

   if st.deplacement[0].dir=="west" then obj.turn(2) end;
   if st.deplacement[0].dir=="east" then obj.turn(6) end;
   if st.deplacement[0].dir=="north" then obj.turn(0) end;
   if st.deplacement[0].dir=="south" then obj.turn(4) end;


   
   local fo=map.objet.get_object_at_position(np.x,np.y)

--   if map.is_position_blocking(np.x,np.y)~=nil or fo~=nil or self.dpix>=96 then

--      rt=randomize(30)+1;
--      rtf=randomize(15)+1;
--      obj.states.set_state ("immobile",{
--			       attendre={val_time(0,0,rt,rtf)}
--			    });

--  if mod(obj.get_pixel_x(),32)==0 and mod(obj.get_pixel_y(),32)==0 then
--     print(obj.get_pixel_x())
--     print(obj.get_bcentre_x())

   

  if obj.dpix>=32 then

      obj.rendre_heureux()
      
      obj.dpix=0;
      obj.pathfinding();


   else
      obj.dpix=obj.dpix+obj.properties.speed;
   end

end