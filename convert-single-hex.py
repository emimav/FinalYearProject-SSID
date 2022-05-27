# Convert to a string of bytes 
# Author: Emima Vaipan 

value = input("Enter something: ")
hex_value = "\\" + "\\".join(hex(ord(x))[1:] for x in value)

#lemmeconfig_file = open("config-ssid.sh", "w")


print("Appended value: ", hex_value)

