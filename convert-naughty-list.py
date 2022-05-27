# Convert the list with naughty strings to bytestrings 
# Author: Emima Vaipan

with open("blns.txt", "r") as f:
    i = 0
    strings_list = f.read().split("\n")
    for knotty_string in strings_list:
        i+=1
        bytestring = "\\" + "\\".join(hex(ord(x))[1:] for x in knotty_string)
        print("ID {}".format(i) + ". Text string: " + knotty_string)
        print("ID {}".format(i) + ". Bytestring: " + bytestring)
        
