-- A faire en ocaml
function self.finalize_tracked()
--   print ("default finalize tracked")

end

function self.on_mouseclick(x,y,b)
   local root=main()
--   print (root.tracked)
   if root.tracked then
   else
      root.tracked=self.on_tracked_mouseclick(x,y,b)   

   end
   self.finalize_tracked()   
   
end

function self.on_click(x,y)
   local root=main()
--   print (root.tracked)
   if root.tracked then
   else
      root.tracked=self.on_tracked_click(x,y)   

   end
   self.finalize_tracked()   
   
end