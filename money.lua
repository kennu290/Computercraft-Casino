os.loadAPI("encryptor")

function setMoney(money)
    local securemoney = encryptor.encrypt(money,"vFhKE@k!U4F>xZXR")
    --make and write securemoney file
    fs.delete("securefile")
    local h = fs.open("securefile", "w")
    h.write(securemoney)
    h.close()
    --copy it to the disk
    fs.delete("/disk/securefile")
    fs.copy("securefile", "/disk/securefile")
end

function addMoney(money)
    setMoney(checkBalance()+money)
end

function removeMoney(money)
    setMoney(checkBalance-money)
end

function checkBalance()
    local secure = fs.open("/disk/securefile", "r")
    local encmoney = secure.readAll()
    secure.close()
    local realmoney = encryptor.decrypt(encmoney, "vFhKE@k!U4F>xZXR")
    return realmoney
end