function mine(ins)
  if turtle.detect() then
    turtle.dig()
  end
  ins.goForward()
end


function load()
  return settings.get("cbstate", {})
end

function save(state)
  settings.set("cbstate", state)
  settings.save(".settings")
end



-- excavate from pos1 to pos2
function excavate3(ins, navigation, pos1, pos2)
  local state = load();

  -- setup
  if state.state == nil then
    state.state = 0
    state.size = vector.new(math.abs(pos1.x - pos2.x), math.abs(pos1.y - pos2.y), math.abs(pos1.z - pos2.z))
    state.startpos = vector.new(math.max(pos1.x, pos2.x), math.max(pos1.y, pos2.y), math.max(pos1.z, pos2.z))
    print("mining init")
  end

  -- travel to start pos state
  if state.state == 0 then
    print("minemove")
    if navigation.goTo(ins, state.startpos, state.startpos.y, true) then
      state.state = 1
      ins.turnTo(180)
    end
  end

  --mine state 1
  if state.state == 1 then
    print("mining 1")
    mine(ins)

    if ins.getPos().x == state.startpos.x-state.size.x then
      if (ins.getPos().z == state.startpos.z-state.size.z) then
        state.startpos.y = state.startpos.y - 1
        state.size.y = state.size.y -1
        state.state = 0
        if (state.size.y < 0) then
          return true
        end
        return false
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

-- digs tunnel
function tunnel(ins, navigation, pos, dir, length, height, automine)
  local state = load();

  -- setup
  if state.state == nil then
    state.state = 0
    state.length = length
    print("tunnel init")
  end

  -- travel to start pos state
  if state.state == 0 then
    print("tunnelmove")
    if navigation.goTo(ins, pos, pos.y, true) then
      state.state = 1
      ins.turnTo(dir)
    end
  end

  if state.state == 1 then
    local turtle_pos = ins.getPos()

    -- if down - go up - mine from top to bottom
    if turtle_pos.y == pos.y then
      if state.length <= 0 then
        return true
      end

      --go up
      for i=1,height-1,1 do
        turtle.digUp()
        ins.goUp()
      end

      -- at the top: mine forward
      turtle.dig()
      ins.goForward()
      state.length = state.length -1
      save()
      return false
    end

    --not at the bottom (at the top or somewhere in between)
    turtle.digDown()
    ins.goDown()
  end

  save(state)
  return false
end
