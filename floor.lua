--floor laying program

floor_id = "minecraft:planks"

function safeDig()
  is_block, details = turtle.inspectDown()
  if details.name ~= floor_id then
    turtle.digDown()
  end
end

function safePlace()
  while true do
    details = turtle.getItemDetail()
    if details ~= nil and details.name == floor_id then
      turtle.placeDown()
      return
    end

    slot = turtle.getSelectedSlot()
    slot = slot +1
    if slot > 16 then
      slot = 1
    end
    turtle.select(slot)
    print("Looking for new floor material")
    sleep(1)
  end
end

while not turtle.detect() do
  turtle.forward()
end
turtle.turnRight()
while not turtle.detect() do
  turtle.forward()
end
turtle.turnRight()

row = 1
while true do
  while not turtle.detect() do
    safeDig()
    safePlace()
    turtle.forward()
  end

  safeDig()
  safePlace()

  if row == 1 then
    turtle.turnRight()
    if not turtle.forward() then return end
    turtle.turnRight()
    row = 2
  elseif row == 2 then
    turtle.turnLeft()
    if not turtle.forward() then return end
    turtle.turnLeft()
    row = 1
  end



end
