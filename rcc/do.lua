os.loadAPI("rcc.lua")


local tasks = {
  {task="goto", param=vector.new(-228, 63, 174)},
  {task="excavate3", param={vector.new(-227, 63, 175), vector.new(-224, 63, 179)}}
}

settings.set("cbtasks", tasks)
rcc.startup()
