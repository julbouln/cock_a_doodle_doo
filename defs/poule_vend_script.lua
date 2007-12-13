function self.on_loop()
   local root=main()
   local obj=self.parent.parent.parent;
   
   local price=floor(obj.properties.masse*10*(obj.properties.sante + obj.properties.bonheur)/200)
   root.stages.engine.game.map.properties.argent=root.stages.engine.game.map.properties.argent+price
   root.stages.engine.ui.sprites.argent.graphics.main.set_text(format("$ %i",root.stages.engine.game.map.properties.argent))

   root.stages.engine.game.map.objet.delete_object(obj.get_id())
end