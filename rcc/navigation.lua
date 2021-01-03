
function goTo(ins, pos, travel_alt, agressive)
  local turtle_pos = ins.getPos()
  print(turtle_pos)
  print(pos)
  print("")

  -- we are already there?
  if pos.x == turtle_pos.x and pos.y == turtle_pos.y and pos.z == turtle_pos.z then
    return true
  end

  -- on top of location, go down
  if turtle_pos.x == pos.x and turtle_pos.z == pos.z then
    if agressive and turtle.detectDown() then
      turtle.digDown()
    end
    ins.goDown()
    return false
  end

  -- climb to altitude
  if turtle_pos.y < travel_alt then
    if agressive and turtle.detectUp() then
      turtle.digUp()
    end
    ins.goUp()
    return false
  end

  -- determine direction
  local to_vector = vector.new(pos.x-turtle_pos.x, pos.y-turtle_pos.y, pos.z-turtle_pos.z)
  to_vector.y = 0
  local target_dir = 0
  if math.abs(to_vector.x) >= math.abs(to_vector.z) then
    if to_vector.x > 0 then
      target_dir = 0
    else
      target_dir = 180
    end
  else
    if to_vector.z > 0 then
      target_dir = 90
    else
      target_dir = 270
    end
  end

  -- rotate to target position
  if target_dir ~= ins.getRot() then
    ins.turnTo(target_dir)
  else
    if agressive and turtle.detect() then
      turtle.dig()
    end
    ins.goForward()
  end
  return false
end
