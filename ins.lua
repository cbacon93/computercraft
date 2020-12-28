cbpos = nil
cbrot = nil

function abortError(err)
  if err == "gps" then
    print("Error: no gps found")
  elseif err == "rot" then
    print("Error: could not determine facing location")
  end

end

function save()
  settings.set("cbpos", {x=cbpos.x, y=cbpos.y, z=cbpos.z})
  settings.set("cbrot", cbrot)
  settings.save(".settings")
end

function load()
  local pos = settings.get("cbpos", nil)
  local rot = settings.get("cbrot", nil)
  if pos == nil or rot == nil then
    return false
  end

  cbpos = vector.new(pos.x, pos.y, pos.z)
  cbrot = rot
  return true;
end


function turnLeft()
  if not turtle.turnLeft() then
    return false;
  end
  cbrot = cbrot-90
  if cbrot < 0 then
    cbrot = cbrot+360
  end
  save()
  return true
end
function turnRight()
  if not turtle.turnRight() then
    return false;
  end
  cbrot = cbrot+90
  if cbrot >= 360 then
    cbrot = cbrot-360
  end
  save()
  return true
end
function goForward()
  if not turtle.forward() then
    return false
  end
  if cbrot == 0 then cbpos.x = cbpos.x+1
  elseif cbrot == 90 then cbpos.z = cbpos.z+1
  elseif cbrot == 180 then cbpos.x = cbpos.x-1
  elseif cbrot == 270 then cbpos.z = cbpos.z-1
  end
  save()
  return true
end
function goBack()
  if not turtle.back() then
    return false
  end
  if cbrot == 0 then cbpos.x = cbpos.x-1
  elseif cbrot == 90 then cbpos.z = cbpos.z-1
  elseif cbrot == 180 then cbpos.x = cbpos.x+1
  elseif cbrot == 270 then cbpos.z = cbpos.z+1
  end
  save()
  return true
end
function goUp()
  if not turtle.up() then
    return false
  end
  cbpos.y = cbpos.y+1
  save()
end
function goDown()
  if not turtle.down() then
    return false
  end
  cbpos.y = cbpos.y-1
  save()
end

function gpsLocate()
  local x, y, z = gps.locate(5)
  if not x then
    return false
  end

  cbpos = vector.new(x, y, z)
  return true;
end

function rotLocate()
  local turnings = 0
  for i=1,4 do
    if not turtle.detect() then break end
    if not turtle.turnRight() then return false end
    turnings = turnings+1
  end
  if turtle.detect() then return false end
  if not turtle.forward() then return false end

  local x, y, z = gps.locate(5)
  if (x > cbpos.x) then cbrot = 0
  elseif (z > cbpos.z) then cbrot = 90
  elseif (x < cbpos.x) then cbrot = 180
  elseif (z < cbpos.z) then cbrot = 270
  else return false end

  if not turtle.back() then return false end

  for i=1,turnings do
    turnLeft()
  end

  return true
end

function init()
  if not load() then
    if not gpsLocate() then
      abortError("gps")
      return false
    end
    if not rotLocate() then
      abortError("rot")
      return false
    end
    save()
  end
  return true
end

function pos()
  return cbpos
end

function rot()
  return cbrot
end
