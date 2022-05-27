import sys
import os 
from subprocess import run 

def query_yes_no(prompt, default = "yes"):
    valid = {"yes": True, "y": True, "no": False, "n": False} 
    
    while True: 
        user_input = input(prompt).lower()
        if default is not None and user_input == "":
            return valid[default]
        elif user_input in valid:
            return valid[user_input]
        else:
            sys.stdout.write("Please answer with 'yes' or 'no'.\n") 
        return user_input

#user_input =  query_yes_no(prompt="Parse the next naughty string? [yes/no]:  ")

with open("blns.txt", "r") as f:
    i = 0
    strings_list = f.read().split("\n")
    for line in strings_list:
        user_input = query_yes_no(prompt="Parse the next naughty string? [yes/no]:   ")
        if user_input is not None:
            i = i+1
            if user_input is True:
                try:
                    print("ID {}".format(i) + ". Text string: " + line)
                    os.system("sudo {0} run.py -i wlan0 -dV -ssid {1}".format(sys.executable, line))
                except EOFError:
                    print("Something went wrong")
                    break
        else:
            break
