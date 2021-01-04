os.loadAPI("ins.lua")
os.loadAPI("navigation.lua")
os.loadAPI("mine.lua")
os.loadAPI("floor.lua")
os.loadAPI("tnt_drone.lua")
os.loadAPI("labels.lua")

-- settings
local RCC_MIN_FUEL = 100
local RCC_MAX_FUEL = 1000
local RCC_VERSION = "0.1"


function startup()
  -- init position
  ins.init()
  setupLabel()

  term.clear()
  term.setCursorPos(1, 1)
  print("Turtle RCC - v"..RCC_VERSION)

  -- main program loop
  local i = 1
  while 1 do
    checkAndRefuel()
    workTasks()

    if i >= 256 then
      cleanInventory()
      i = 1
    end
    i = i+1
  end
end

function workTasks()
  local tasks = settings.get("cbtasks", {})
  if tasks[1] ~= nil then
    if execute(tasks[1]) then
      table.remove(tasks, 1)
      settings.set("cbtasks", tasks)
      settings.save(".settings")
      resetState()
      print("task finished")
    end
    return
  end
  os.sleep(1)
end

--executes a task
--{task: "", param: ...}
function execute(task)
  if task.task == "goto" then
    return navigation.goTo(ins, vector.new(task.param.x, task.param.y, task.param.z), 100, true)
  end
  if task.task == "excavate3" then
    return mine.excavate3(
      ins,
      navigation,
      vector.new(task.param[1].x, task.param[1].y, task.param[1].z),
      vector.new(task.param[2].x, task.param[2].y, task.param[2].z)
    )
  end
  if task.task == "floor" then
    return floor.floor(
      ins,
      navigation,
      vector.new(task.param[1].x, task.param[1].y, task.param[1].z),
      vector.new(task.param[2].x, task.param[2].y, task.param[2].z),
      task.param[3]
    )
  end
  if task.task == "tntdrop" then
    return tnt_drone.tntDrone(
      ins,
      navigation,
      vector.new(task.param[1].x, task.param[1].y, task.param[1].z),
      task.param[2]
    )
  end
  --not recognized task - delete
  return true
end

-- checks if refuel is necessary and refuel
function checkAndRefuel()
  if turtle.getFuelLevel() < RCC_MIN_FUEL then
    refuel()
  end
end

-- loop through inventory and refuel
function refuel()
  local selected_slot = turtle.getSelectedSlot()

  for i=1,32,1 do
    turtle.select(i)
    while turtle.getFuelLevel() < RCC_MAX_FUEL do
      if not turtle.refuel(1) then
        break
      end
    end
  end

  --select original item
  turtle.select(selected_slot)
end

function has_value(arr, val)
  for i, v in ipairs(arr) do
    if v == val then
      return true
    end
  end
  return false
end

function cleanInventory()
  print("cleaning inventory")
  local selected_slot = turtle.getSelectedSlot()
  for i=1,16,1 do
    --check if slot is one of the following items...
    turtle.select(i)
    local details = turtle.getItemDetail()
    if details ~= nil and has_value(labels.useful_items, details.name) then
      -- keep it
    else
      -- drop it
      -- maybe keep if current task is crafting or replicating
    end
  end
  turtle.select(selected_slot)
end

function setupLabel()
  if os.getComputerLabel() == nil then
    os.setComputerLabel(labels.turtle_names[math.random(table.getn(labels.turtle_names))])
  end
end

function resetState()
    settings.set("cbstate", {})
    settings.save(".settings")
end
