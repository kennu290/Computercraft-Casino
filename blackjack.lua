local debug = true

m = peripheral.wrap("monitor_10")
d = "drive_3"
--Fix screen
m.setCursorPos(1,1)
m.setBackgroundColor(colors.green)
m.clear()
--Set money and bet into variables
h = fs.open("/bet.png", "r")
bet = h.readAll()
h.close()
h = fs.open("/money.png", "r")
money = h.readAll()
h.close()
--print money and bet again
if debug == true then
print("")
print("Bet is ".. bet)
print("Money is ".. money)
end
--calculate and encrypt money to set on disk
money = money - bet
if money < tonumber(bet) then
money = money + bet
m.setBackgroundColor(colors.green)
m.clear()
m.setTextColor(colors.red)
m.setCursorPos(2,6)
m.write("Not enough money on card")
m.setCursorPos(2,7)
m.write("To continue")
end
securemoney = encryptor.encrypt(money,"vFhKE@k!U4F>xZXR")
--make and write securemoney variable to file
fs.delete("securefile")
h = fs.open("securefile", "w")
h.write(securemoney)
h.close()
--copy it to the disk
fs.delete("/disk/securefile")
fs.copy("securefile", "/disk/securefile")
--let the games begin
print("")
print("Generating cards... this may take a while")
m.setTextColor(colors.white)
m.setCursorPos(7,6)
m.write("Generating cards!")
--generate the cards
math.randomseed(os.time()*os.clock())
playercard1 = math.random(2, 10)

os.sleep(1)
math.randomseed(os.time()*os.clock())
playercard2 = math.random(2, 10)

os.sleep(2)
math.randomseed(os.time()*os.clock())
dealercard1 = math.random(2, 10)

os.sleep(1)
math.randomseed(os.time()*os.clock())
dealercard2 = math.random(2, 10)

playertotal = tonumber(playercard1)+tonumber(playercard2)
dealertotal = tonumber(dealercard1)+tonumber(dealercard2)

if debug == true then
print("")
print("Player's first card is ".. playercard1)
print("Player's second card is ".. playercard2)
print("Player's total is ".. playertotal)
print("")
print("Dealer's first card is ".. dealercard1)
print("Dealer's second card is ".. dealercard2)
print("Dealer's total is ".. dealertotal)
end

function bust()
    m.setTextColor(colors.red)
    m.setBackgroundColor(colors.green)
    m.setCursorPos(8,5)
    m.write("BUST")
    print("Player is bust. house wins")
    m.setTextColor(colors.white)
    m.setBackgroundColor(colors.green)
end

function drawgame() --Dose what you expect it to do
    m.setBackgroundColor(colors.green)
    m.setTextColor(colors.white)
    m.clear()
    m.setCursorPos(6,1)
    m.write("Dealer's first card")
    m.setCursorPos(14,3)
    m.write(tostring(dealercard1))

    m.setCursorPos(8,6)
    m.write("Player's cards")
    m.setCursorPos(14,8)
    m.write(tostring(playertotal))

    m.setCursorPos(14,10)
    m.setBackgroundColor(colors.white)
    m.setTextColor(colors.black)
    m.write("Hit")
    m.setCursorPos(13,12)
    m.write("Stand")
end
drawgame()

while true do
    event, side, x, y = os.pullEvent("monitor_touch")
    
    if x > 13 and x < 17 and y == 10 then
        print("Hit")
        math.randomseed(os.time()*os.clock())
        playertotal = playertotal + math.random(2, 10)
        if playertotal > 21 then
            drawgame()
            bust()
        else
        drawgame()
        end
    elseif x == 8 and y == 12 then
        print("Stand!")
    end
end