bet = 0

m = peripheral.wrap("monitor_10")
d = "drive_3"
os.loadAPI("encryptor")
disk.eject(d)
m.setBackgroundColor(colors.green)
m.clear()
m.setTextColor(colors.white)
m.setCursorPos(7,6)
m.write("Please enter card")
os.pullEvent("disk")
m.clear()

m.setCursorPos(4,6)
m.setTextColor(colors.red)
m.write("Modified card detected!")
m.setCursorPos(4,8)
m.write("Error: 0FFFX12")
secure = fs.open("/disk/securefile", "r")
encmoney = secure.readAll()
secure.close()
money = encryptor.decrypt(encmoney, "vFhKE@k!U4F>xZXR")
print("Amount on card ".. money)

function drawbalance() --this is a stupid way how to do this but it will work (hopefully)
m.setTextColor(colors.white)
m.setBackgroundColor(colors.green)
m.clear()
m.setCursorPos(9,3)
m.write("Your Balance:")

dist = string.len(money)

if money > 9 then
m.setCursorPos(16-dist+1,5)
else
m.setCursorPos(15,4)
end
m.write(tostring(money))
m.setCursorPos(22,11)
m.setBackgroundColor(colors.white)
m.setTextColor(colors.black)
m.write("+")

betdist = string.len(bet)

m.setCursorPos(8,11)
m.write("-")

if betdist == 1 then
m.setCursorPos(15,11)
m.write(tostring(bet))
else
m.setCursorPos(15-betdist+2,11)
m.write(tostring(bet))
end

m.setCursorPos(12,9)
m.write(" Play! ")


end

drawbalance()

while true do
event, side, x, y = os.pullEvent("monitor_touch")

if x == 22 and y == 11 then
bet = bet + 1
drawbalance()
elseif x == 8 and y == 11 then
bet = bet - 1
drawbalance()
elseif x > 12 and x < 19 and y == 9 then
if bet < 0 then
bet = money
end
print("Start game")
print("Bet is ".. bet)
break
end
end
--Delete old files
fs.delete("/bet.png")
fs.delete("/money.png")
--Write bet to file
h = fs.open("/bet.png", "w")
h.write(tostring(bet))
h.close()
--Write current money to file
h = fs.open("/money.png", "w")
h.write(tostring(money))
h.close()
--Run game
m.setBackgroundColor(colors.green)
m.clear()
shell.run("blackjack")
