function self.on_loop()
   local obj=self.parent.parent.parent;
   local tot=obj.graphics.main.get_drawings_size();
   local fr=obj.get_direction() * (tot/8) + self.get_frame();
   obj.graphics.main.set_cur_drawing (fr);
   obj.graphics.main_border.set_cur_drawing (fr);
end