print("Starting Redstone Server")
peripheral.find("modem", rednet.open)

while true do
  sender_id, message = rednet.receive("rtp")
  if message.key == "fdoor" do
    redstone.setOutput("top", message.value)
  end
end



--os.pullEvent = os.pullEventRaw
peripheral.find("modem", rednet.open)
msg = {key = "fdoor", value = true}
rednet.broadcast(msg, rtp)
