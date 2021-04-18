drive = "right"

os.loadAPI("encryptor")

secure = fs.open("/disk/securefile", "r")
encmoney = secure.readAll()
secure.close()
realmoney = encryptor.decrypt(encmoney, "vFhKE@k!U4F>xZXR")
print("Amount on card ".. realmoney)
print("")

local money = 0

function setmoney(money)
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

print("Please enter either 'set'")
input = read()
if input == "set" then
shell.run("clear")
print("Please put new value (number only)")
input = read()
setmoney(input)
print("Done")
os.sleep(2)
os.reboot()
else
print("Unknown command, please make sure the caps are correct")
end