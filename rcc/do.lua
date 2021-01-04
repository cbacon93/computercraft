os.loadAPI("rcc.lua")


local tasks = {
  {task="goto", param=vector.new(-254, 63, 154)},
  {task="excavate3", param={vector.new(-253, 63, 155), vector.new(-239, 74, 169)}},
  {task="goto", param=vector.new(-241, 72, 126)},
}

settings.set("cbtasks", tasks)
rcc.startup()
