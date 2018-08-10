'''
Created on 28.03.2018

@author: pfeiffer
''' 
import socket
import time
if _name_ == '__main__':
    

    UDP_IP = "192.168.1.1"
    UDP_PORT = 5005
    MESSAGE = "EMS08IKC1I100T150G"
    count = 0
    numberMes = 3
    countDown = 0
    countDownto = 5
    
    print "UDP target IP:", UDP_IP
    print "UDP target port:", UDP_PORT
    print "message:", MESSAGE
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
    
    while True:
        
        # UDP
        while countDown <= countDownto:
            time.sleep( 1 )
            print "Count down (countDownto):", str( countDown)
            countDown =countDown+1
            
            
            
        sock.sendto(MESSAGE, (UDP_IP, UDP_PORT))
        print "message:", MESSAGE+" " +str( count)
        count=count+1
        if count >= numberMes:
            break
        countDown = 0
        time.sleep( 5 )