--delete everything
fs.delete("rcc.lua")
fs.delete("ins.lua")
fs.delete("labels.lua")
fs.delete("mine.lua")
fs.delete("do.lua")
fs.delete("startup.lua")


-- basics
shell.run("wget https://raw.githubusercontent.com/cbacon93/computercraft/master/rcc/rcc.lua rcc.lua")
shell.run("wget https://raw.githubusercontent.com/cbacon93/computercraft/master/rcc/ins.lua ins.lua")
shell.run("wget https://raw.githubusercontent.com/cbacon93/computercraft/master/rcc/labels.lua labels.lua")
shell.run("wget https://raw.githubusercontent.com/cbacon93/computercraft/master/rcc/mine.lua mine.lua")
shell.run("wget https://raw.githubusercontent.com/cbacon93/computercraft/master/rcc/floor.lua floor.lua")

-- management scripts
shell.run("wget https://raw.githubusercontent.com/cbacon93/computercraft/master/rcc/startup.lua startup.lua")
shell.run("wget https://raw.githubusercontent.com/cbacon93/computercraft/master/rcc/do.lua do.lua")
