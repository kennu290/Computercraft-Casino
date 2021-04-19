os.loadAPI("encryptor")

secure = fs.open("/disk/securefile", "r")
encmoney = secure.readAll()
secure.close()
realmoney = encryptor.decrypt(encmoney, "vFhKE@k!U4F>xZXR")

function setMoney(money)
    securemoney = encryptor.encrypt(money,"vFhKE@k!U4F>xZXR")
    --make and write securemoney file
    fs.delete("securefile")
    h = fs.open("securefile", "w")
    h.write(securemoney)
    h.close()
    --copy it to the disk
    fs.delete("/disk/securefile")
    fs.copy("securefile", "/disk/securefile")
end

