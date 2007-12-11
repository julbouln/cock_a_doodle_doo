function self.on_update()
   local obj=self.parent.parent;
   self.move(obj.get_pixel_x()-33,obj.get_pixel_y()-25)
   self.parent.main_border.move(obj.get_pixel_x()-33,obj.get_pixel_y()-25)
   self.parent.main_border_wont.move(obj.get_pixel_x()-33,obj.get_pixel_y()-25)

   self.set_cur_drawing(2);
   self.parent.main_border.set_cur_drawing(2);
   self.parent.main_border_wont.set_cur_drawing(2);

   if obj.properties.qty < 250 then
      self.set_cur_drawing(1)
      self.parent.main_border.set_cur_drawing(1)
      self.parent.main_border_wont.set_cur_drawing(1)
   end
   if obj.properties.qty < 100 then
      self.set_cur_drawing(0)
      self.parent.main_border.set_cur_drawing(0)
      self.parent.main_border_wont.set_cur_drawing(0)
   end

   
end


function self.iface_update()
   local obj=self.parent.parent;
   self.move(-1000,-1000)
end
