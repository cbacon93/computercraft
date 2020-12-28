-- Server
redstone_side = "top"
message_key = "fdoor"

print("Starting Redstone Server")
peripheral.find("modem", rednet.open)

while true do
  sender_id, message = rednet.receive("rtp")
  if message.key == message_key then
    mvalue = message.value == "true" or message.value == "1"
    redstone.setOutput(redstone_side, mvalue)
  end
end



-- terminal client
peripheral.find("modem", rednet.open)
local tArgs = {...}
msg = {key = tArgs[1], value = tArgs[2]}
rednet.broadcast(msg, "rtp")




--- password client
permitted = {"andi", "andy", "crazzak", "andreas", "kerwer", "de kerwer", "raphael", "raphi", "de_kerwer", "lol"}
msg_key = "fdoor"
open_time = 5

function has_value(arr, val)
  for i, v in ipairs(arr) do
    if v == val then
      return true
    end
  end
  return false
end

peripheral.find("modem", rednet.open)
_pullEvent = os.pullEvent
os.pullEvent = os.pullEventRaw
while true do
  term.clear()
  term.setCursorPos(1, 1)
  print("Hallo, wer ist da?")
  write("Name: ")
  local input = read()
  if has_value(permitted, input:lower()) then
    print("Willkommen! Die Tür öffnet!")
    os.pullEvent = _pullEvent
    rednet.broadcast({key = msg_key, value = "true"}, "rtp")
    sleep(open_time)
    rednet.broadcast({key = msg_key, value = "false"}, "rtp")
    os.pullEvent = os.pullEventRaw
  else
    print("Zutritt verweigert!")
    sleep(open_time)
  end
end
