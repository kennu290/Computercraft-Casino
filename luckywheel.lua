os.loadAPI("encryptor")
os.loadAPI("money")

m = peripheral.find("monitor")

m.clear()

bet = 100

function draw()
    local prob = math.random(1,100)   
    
    if prob == 100 then
        return 1000
    end
    
    if prob<100 and prob>=95 then
        return 200
    end
    
    if prob<95 and prob>=87 then
        return 150
    end
    
    if prob<87 and prob>=77 then
        return 130
    end
    
    if prob<77 and prob>=41 then
        return 110
    end
    
    if prob<41 and prob>=37 then
        return 100
    end
    
    if prob<37 and prob>=32 then
        return 50
    end
    
    if prob<32 and prob>=26 then
        return 30
    end
    
    if prob<26 and prob>=19 then
        return 20
    end
    
    if prob<19 and prob>=11 then
        return 10
    end
    
    if prob<11 and prob>=1 then
        return 0
    end
    
end

--Game loop
while true do
    m.setCursorPos(1, 1)
    m.write("Lucky Wheel")
    m.setCursorPos(1, 10)
    m.write("Click To \"SPIN\" ($100)")
    m.setCursorPos(1, 11)
    m.clearLine()
    m.write("Please Enter Casino Card")
    local event, side = os.pullEvent()

    if event == "disk" then
        if not money.checkCard() then
            m.setCursorPos(1, 11)
            m.clearLine()
            m.write("Wrong Card!")
            os.sleep(3)
            os.reboot()
        end
    end

 
    --Show card balance
    m.setCursorPos(1, 11)
    m.clearLine()
    m.write("Card's Balance: $"..tostring(money.checkBalance()))
    
    --Spin
    os.pullEvent("monitor_touch")
    m.setCursorPos(1, 5)
    m.clearLine()

    --Eat the card balance
    if money.checkBalance() < bet or not money.checkCard() then
        m.write("You have insufficent balance!")
        os.sleep(5)
        os.reboot()
    else
        money.removeMoney(bet)
        m.setCursorPos(1, 11)
        m.clearLine()
        m.write("Card's Balance: $"..tostring(money.checkBalance()))
    end
    
    --Spinning screen
    m.setCursorPos(1,5)
    m.write("Spinning")
    os.sleep(0.5)
    m.setCursorPos(9,5)
    m.write(".")
    os.sleep(0.5)
    m.setCursorPos(10,5)
    m.write(".")
    os.sleep(0.5)
    m.setCursorPos(11,5)
    m.write(".")
    os.sleep(0.5)
    m.clearLine()
    m.setCursorPos(1,5)
    m.write("$"..tostring(draw()))

    money.addMoney(draw())

    --Show balance after game
    m.setCursorPos(1, 11)
    m.clearLine()
    m.write("Card's Balance: $"..tostring(money.checkBalance()))

end