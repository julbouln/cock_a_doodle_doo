function self.on_update()
   local obj=self.parent.parent;
   self.move(obj.get_pixel_x(),obj.get_pixel_y())
end

function self.iface_update()
   local obj=self.parent.parent;
   self.move(-1000,-1000)
end