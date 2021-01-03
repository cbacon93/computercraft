os.loadAPI("rcc.lua")


local tasks = {
  {task="goto", param=vector.new(-265, 60, 150)},
  {task="excavate3", param={vector.new(-265, 60, 150), vector.new(-265, 60, 150)}}
}

settings.set("cbtasks", {{task="goto", param=vector.new(-265, 60, 150)}})
rcc.startup()
