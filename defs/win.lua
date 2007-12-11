function self.drawing_script()
local sprites=self.parent.parent.parent;

p=sprites.types.win_pattern;
drf=self.create_from_vault(p.graphics.main.get_drawing_id());
self.write(drf,0,"set_alpha",{128,{r=255,g=255,b=255}});

return drf
end
