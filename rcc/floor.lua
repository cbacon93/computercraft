--floor laying program

function load()
  return settings.get("cbstate", {})
end

function save(state)
  settings.set("cbstate", state)
  settings.save(".settings")
end

function safeDigDown(floor_material)
  is_block, details = turtle.inspectDown()
  if details.name ~= floor_material then
    turtle.digDown()
  end
end

function safePlaceDown(floor_material)
  while true do
    details = turtle.getItemDetail()
    if details ~= nil and details.name == floor_material then
      turtle.placeDown()
      return
    end

    slot = turtle.getSelectedSlot()
    slot = slot +1
    if slot > 16 then
      slot = 1
    end
    turtle.select(slot)
    print("Waiting for new floor material placed in inventory "..floor_material)
    sleep(1)
  end
end

function placeFloorAndMove(ins, floor_material)
  safeDigDown(floor_material)
  safePlaceDown(floor_material)
  if turtle.detect() then
    turtle.dig()
  end
  ins.goForward()
end


-- place floor from pos1 to pos2
function floor(ins, navigation, pos1, pos2, floor_material)
  local state = load();

  -- setup
  if state.state == nil then
    state.state = 0
    state.size = vector.new(math.abs(pos1.x - pos2.x), 1, math.abs(pos1.z - pos2.z))
    state.startpos = vector.new(math.max(pos1.x, pos2.x), math.min(pos1.y, pos2.y)+1, math.max(pos1.z, pos2.z))
    print("floor init")
  end

  -- travel to start pos state
  if state.state == 0 then
    print("floormove")
    if navigation.goTo(ins, state.startpos, state.startpos.y, true) then
      state.state = 1
      ins.turnTo(180)
    end
  end


  --mine state 1
  if state.state == 1 then
    print("flooring...")

    placeFloorAndMove(ins)

    if ins.getPos().x == state.startpos.x-state.size.x then
      if (ins.getPos().z == state.startpos.z-state.size.z) then
        return true
      end
      ins.turnRight()
      turtle.dig()
      ins.goForward()
      ins.turnRight()
    end
    if ins.getPos().x == state.startpos.x then
      ins.turnLeft()
      turtle.dig()
      ins.goForward()
      ins.turnLeft()
    end
  end

  save(state)
  return false
end
