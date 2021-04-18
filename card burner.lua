--define variables
local after = "'s card 0$"
--load apis
os.loadAPI("encryptor")
--encrypt the number 0
securemoney = encryptor.encrypt(0,"vFhKE@k!U4F>xZXR")
--create file
h = fs.open("/disk/securefile", "w")
h.write("")
h.close()
--write to file
local handler = fs.open("disk/securefile", "w")
handler.write(securemoney)
handler.close()
--ask for a name
term.clear()
term.setCursorPos(1,1)
print("Please enter a name")
input = read()
--make a card
disk.setLabel("right", input.. after)
disk.eject("right")
os.reboot()

