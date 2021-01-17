os.loadAPI("rcc.lua")

-- Programs:
-- goto [Vector:Pos]
-- excavate3 [Vector:Pos1] [Vector:Pos2]
-- tunnel [Vector:Pos] [Int:Direction] [Int:Length] [Int:Height]
-- floor [Vector:Pos1] [Vector:Pos2] [String:Material]
-- tntdrop [Vector:Pos] [Int:Direction] [Int:Number]

local tasks = {
  {task="goto", param=vector.new(-254, 63, 154)},
  {task="excavate3", param={vector.new(-253, 63, 155), vector.new(-239, 74, 169)}},
  {task="goto", param=vector.new(-241, 72, 126)},
}

settings.set("cbtasks", tasks)
rcc.startup()

-- {task="floor", param={vector.new(213, 69, 214), vector.new(218, 69, 207), "minecraft:planks"}}
