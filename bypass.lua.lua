drive = "drive_6"

--Wrap peripherals

m = peripheral.find("monitor")

--Code goes here

m.setBackgroundColor(colors.black)
m.setTextColor(colors.white)
m.clear()
m.setCursorPos(2,7)
m.write("Please throw bypass card at")
m.setCursorPos(2,8)
m.write("Monitor you have 15 seconds")
os.sleep(15)
m.clear()
m.setCursorPos(9,8)
m.write("Checking card")

inserted = disk.isPresent(drive)
label = disk.getLabel(drive)

if inserted == false then

m.clear()
m.setTextColor(colors.red)
m.setCursorPos(7,8)
m.write("Card not detected")
disk.eject(drive)
os.sleep(5)
shell.run(startup)
elseif inserted == true then

if label == "Heygeon's Bypass card" or label == "Ken2ken2's Bypass card" then

print("correct card")
m.clear()
m.setCursorPos(9,8)
m.setTextColor(colors.lime)
m.write("Card accepted")
disk.eject(drive)
redstone.setOutput("back", true)
os.sleep(7)
redstone.setOutput("back", false)
shell.run("startup")

else
disk.eject(drive)
m.clear()
m.setCursorPos(12,8)
m.setTextColor(colors.red)
m.write("Nice try")
os.sleep(2)
os.reboot()
end
end