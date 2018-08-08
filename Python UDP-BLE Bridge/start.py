
import pygatt
import logging
import socket
from binascii import hexlify

#logging.basicConfig()
#logging.getLogger('pygatt').setLevel(logging.DEBUG)

#adapter = pygatt.BGAPIBackend()
myPort = 'COM6'
EMSAddress = '00:1E:C0:32:59:B2'

def handle_data(handle, value):
    #handle -- integer, characteristic read handle the data was received on
    #value -- bytearray, the data returned in the notification

    print("Received data: %s" % hexlify(value))

adapter = pygatt.BGAPIBackend(serial_port=myPort)
print 'Attempting to connect to the BGAPI compatible device on port', myPort 
adapter.start()
print 'OK!!!' 
print 'Attempting to connect to the EMS device', EMSAddress 
device = adapter.connect(EMSAddress)
print 'OK!!!'

#device.subscribe("454D532D-5374-6575-6572-756E672D4348", callback=handle_data)
#value = device.char_read("a1e8f5b1-696b-4e4c-87c6-69dfe0b0093b")

print 'Attempting to read device characteristics' 
for uuid in device.discover_characteristics().keys():
    print("    Read UUID %s: %s" % (uuid, hexlify(device.char_read(uuid))))
print 'DONE!!!'
	
#try:
#    adapter.start()
#    device = adapter.connect('00:1E:C0:32:59:B2')
#
#    device.subscribe("454D532D-5374-6575-6572-756E672D4348", callback=handle_data)
#finally:
#    adapter.stop()

#####################################################################################
#
# If we can not send BLE messages from c# we could send the message to our localhost
# python UDP server (minimising latency) and send it from this file
#
#####################################################################################

UDP_IP = "127.0.0.1"
UDP_PORT = 5000

sock = socket.socket(socket.AF_INET, # Internet
					 socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1024) # buffer size is 1024 bytes
    print "received message:", data
	# write to the BLE device