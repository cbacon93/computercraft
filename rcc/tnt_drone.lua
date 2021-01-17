local tnt_block = "minecraft:tnt"

function tntDrone(ins, navigation, start, dir, number)
  local state = load();

  -- setup
  if state.state == nil then
    state.state = 0
    print("tunnel init")
  end

  -- travel to start pos state
  if state.state == 0 then
    print("tntmove")
    if navigation.goTo(ins, start, start.y, true) then
      state.state = 1
      state.number = number
      ins.turnTo(dir)
    end
  end

  --todo wait for other drones
  if state.state == 1 then
    state.state = 2
  end

  -- move
  if state.state == 2 then
    for i=1,5,1 do
      ins.goForward();
    end
    state.state = 3
    save()
    return false
  end

  -- drop
  if state.state == 3 then
    --select tnt and drop
    if not layBomb() then
      return true
    end
    state.number = state.number -1
    state.state = 2

    if state.number <= 0 then
      return true
    end
  end

  save(state)
  return false
end



function layBomb()
  details = turtle.getItemDetail()
  if details ~= nil and details.name == tnt_block then
    placeAndIgnite()
    return true
  else
    for i=1,16,1 do
      turtle.select(i)
      details = turtle.getItemDetail()
      if details ~= nil and details.name == tnt_block then
        placeAndIgnite()
        return true
      end
    end
    return false
  end
end


function placeAndIgnite()
  turtle.placeDown()
  redstone.setOutput("bottom", true )
  sleep(0.1)
  redstone.setOutput("bottom", false )
  return true
end
