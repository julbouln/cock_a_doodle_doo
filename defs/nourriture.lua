
function self.proche_heuristic(obj)
   local root=main()
   local ch=0

   local ao=root.stages.engine.game.map.objet.get_object_at_position(self.get_case_x(),self.get_case_y())
   if ao~=nil and ao~=obj then
      ch=ch+1
   end
   ao=root.stages.engine.game.map.objet.get_object_at_position(self.get_case_x()-1,self.get_case_y())
   if ao~=nil and ao~=obj then
      ch=ch+1
   end
   ao=root.stages.engine.game.map.objet.get_object_at_position(self.get_case_x()+1,self.get_case_y())
   if ao~=nil and ao~=obj then
      ch=ch+1
   end
   ao=root.stages.engine.game.map.objet.get_object_at_position(self.get_case_x(),self.get_case_y()-1)
   if ao~=nil and ao~=obj then
      ch=ch+1
   end
   ao=root.stages.engine.game.map.objet.get_object_at_position(self.get_case_x(),self.get_case_y()+1)
   if ao~=nil and ao~=obj then
      ch=ch+1
   end
   
   return ch
end