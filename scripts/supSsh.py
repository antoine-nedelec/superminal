
import curses
from fileinput import filename
import sys
import os
import pexpect
import json
import signal
import struct
import fcntl
import termios

jsonfile = os.path.dirname(__file__) + "/supSsh.json"
title = "SUPERMINAL SSH MANAGER"
descriptions = [
    "[ESC]: Exit",
    "[M]:   Manage SSH list",
    "[A]:   Add entry",
    "[D]:   Delete entry",
    "[P]:   Move entry up",
    "[M]:   Move entry down"
]

f = open(jsonfile)
ssh_list = json.load(f)
ssh_index = 0
ssh_session = False

# 0: menu, 1: in ssh client, 2: add, 3: remove
status = 0

### FUNCTIONS ###
def display_title_bar(window, title):
    drawFirstLine(window)
    drawLine(window, title)
    drawFullLine(window)
    for index, description in enumerate(descriptions):
        drawLine(window, description)
    drawFullLine(window)
    drawLine(window, "")
    return 5 + len(descriptions)

def show_ssh_list(window):
    length = 0
    for index, ssh_data in enumerate(ssh_list.get('list')):
        length = max(length, len(ssh_data.get('name')))

    length += 2

    for index, ssh_data in enumerate(ssh_list.get('list')):
        if ssh_index == index:
            drawLine(window, "[>] " + (str(ssh_data.get('name'))).ljust(length, ' ') + "("+ ssh_data.get('ip') +")")
        else:
            drawLine(window, "[ ] " + (str(ssh_data.get('name'))).ljust(length, ' ') + "("+ ssh_data.get('ip') +")")
    return len(ssh_list.get('list'))

def print_all(window):
    global status
    global key
    try:
        lines = 0
        lines += display_title_bar(window, title)
        if status == 0:
            lines += show_ssh_list(window)
        elif status == 2:
            global status_add
            lines += 1
            drawLine(window, 'IP:')
        elif status == 5:
            lines += 1
            drawLine(window, 'Do you want to delete ['+ ssh_list.get('list')[ssh_index].get('name') +'] ? y/n')
        elif status == 1000:
            drawLine(window, key+" ")

        drawRestScreen(window, lines)
    except curses.error:
        pass

def listen(window):
    global ssh_index
    global status
    global ssh_session
    global key

    print_all(window)

    while status != -1:
        if status == 0: # MAIN MENU

            # CLEAR
            window.clear()

            # PRINT
            print_all(window)

            # FETCH DATA
            key = window.getch()
            
            # UPDATE DATA OR EXIT
            if key == 258:
                ssh_index = downPressed(window)
            elif key == 259:
                ssh_index = upPressed(window)
            elif key == 97: # ADD (A)
                status = 2
            elif key == 100: # DELETE (D) 
                status = 3
            elif key == 27: # QUIT (ESC)
                saveJson()
                status = -1
            elif key == 10: # GO IN SSH (RETURN)
                os.system('clear')
                status = 1
                selection(window)
            else:
                status = 1000


        elif status == 1: # EXIT SSH CLIENT
            if ssh_session.isalive() == False:
                status = 0
                print_all(window)

        elif status == 2: # ADD
            global new_list

            # CLEAR
            window.clear()
        
            # PRINT
            print_all(window)

            input = window.getstr().decode(encoding="utf-8")

            # GET IP
            if 'ip' in globals():
                ip = input
            elif 'name' in globals():
                name = input
            elif 'port' in globals():
                port = input
            elif 'user' in globals():
                user = input
            else:
                # Add to list
                ssh_list.get('list').append({"name": name, "ip": ip})
                # SAVE
                saveJson()
                status = 0
                ip = None
                name = None
                port = None
                user = None

        elif status == 3: # REMOVE
            # CLEAR
            window.clear()
        
            # PRINT
            print_all(window)

            key = window.getch()
            if key == 121 or key == 89: # Y
                status = 0
                ssh_list.get('list').remove(ssh_list.get('list')[ssh_index])
                ssh_index = min(ssh_index, len(ssh_list.get('list'))-1)
            elif key == 110 or key == 78: # N
                status = 0

        elif status == 1000:

            # CLEAR
            window.clear()
        
            # PRINT
            print_all(window)

      
### EVENTS ###
def upPressed(window):
    return max(0, ssh_index-1)

def downPressed(window):
    return min(len(ssh_list.get('list'))-1, ssh_index+1)

def drawRestScreen(window, lines):
    for i in range(os.get_terminal_size().lines - lines - 1):
        drawLine(window, "")
    drawLastLine(window)

def drawLine(window, string):
    window.addstr("║ " + string)
    for i in range(os.get_terminal_size().columns - len(string) - 4):
        window.addstr(" ")
    window.addstr(" ║")

def drawFullLine(window):
    window.addstr("╠")
    for i in range(os.get_terminal_size().columns - 2):
        window.addstr("═")
    window.addstr("╣")

def drawFirstLine(window):
    window.addstr("╔")
    for i in range(os.get_terminal_size().columns - 2):
        window.addstr("═")
    window.addstr("╗")

def drawLastLine(window):
    window.addstr("╚")
    for i in range(os.get_terminal_size().columns - 2):
        window.addstr("═")
    window.addstr("╝")

def selection(window):
    global ssh_session
    ssh_session = pexpect.spawn('ssh ' + ssh_list.get('list')[ssh_index].get('ip'))
    ssh_session.setwinsize(*get_terminal_size_2())
    #signal.signal(signal.SIGWINCH, sigwinch_passthrough)
    ssh_session.interact()
    ssh_session.wait()

def saveJson():
    with open(jsonfile, 'w') as outfile:
        json.dump(ssh_list, outfile)

def exitHandler(signum, frame):
    saveJson()
    exit(1)

def sigwinch_passthrough(sig, data):
    global ssh_session, status
    if ssh_session.isalive():
        ssh_session.setwinsize(*get_terminal_size_2())

def get_terminal_size_2():
    s = struct.pack("HHHH", 0, 0, 0, 0)
    a = struct.unpack('hhhh', fcntl.ioctl(sys.stdout.fileno(), termios.TIOCGWINSZ, s))
    return a[0], a[1]

### MAIN PROGRAM ###
signal.signal(signal.SIGINT, exitHandler)
curses.wrapper(listen)
