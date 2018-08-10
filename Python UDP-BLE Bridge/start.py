import pygatt
import logging
import socket
from binascii import hexlify
from binascii import unhexlify
from binascii import a2b_uu

#logging.basicConfig()
#logging.getLogger('pygatt').setLevel(logging.DEBUG)

#adapter = pygatt.BGAPIBackend()
myPort = 'COM6'
#EMSAddress = '00:1E:C0:32:59:B2' # 09RH
EMSAddress = '00:1E:C0:3C:B9:28' # 14YM

def handle_data(handle, value):
    #handle -- integer, characteristic read handle the data was received on
    #value -- bytearray, the data returned in the notification

    print("Received data: %s" % hexlify(value))

#adapter = pygatt.BGAPIBackend(serial_port=myPort)
adapter = pygatt.BGAPIBackend()
print 'Attempting to connect to the BGAPI compatible device on port', myPort 
adapter.start()
print 'OK!!!' 
print 'Attempting to connect to the EMS device', EMSAddress 
device = adapter.connect(EMSAddress)
print 'OK!!! Connected to ', device.char_read("00002a00-0000-1000-8000-00805f9b34fb")

print 'Attempting to read device characteristics' 
for uuid in device.discover_characteristics().keys():
	try:
		value = device.char_read(uuid)
		print("    Read UUID %s: %s" % (uuid, value))
	except:
		print("    Read UUID %s: unable to read characteristic" % uuid)
print 'DONE!!!'

print 'Suscribing for first characteristic'
char = device.discover_characteristics().keys()[0]
device.subscribe(char, callback=handle_data)
print 'OK!!!'

#"C" + channel + "I" + intensities[channel] + "T" + signalLenghtes[channel] + "G"
print 'writting on charasteristic' 
#device.char_write(charasteristic, message)
#device.char_write(char, "C1I100T2000G")
device.char_write('454d532d-5374-6575-6572-756e672d4348', b'\x43\x31\x49\x31\x30\x30\x54\x32\x30\x30\x30\x47')   
#device.char_write('00002a25-0000-1000-8000-00805f9b34fb', b'\x43\x31\x49\x31\x30\x30\x54\x32\x30\x30\x30\x47')   
#device.char_write('00002a25-0000-1000-8000-00805f9b34fb', unhexlify("433149313030543230303047"))


print 'OK!!!'

print 'Attempting to read device characteristics' 
for uuid in device.discover_characteristics().keys():
	try:
		value = device.char_read(uuid)
		print("    Read UUID %s: %s" % (uuid, value))
	except:
		print("    Read UUID %s: unable to read characteristic" % uuid)
print 'DONE!!!'

adapter.stop()


#device.subscribe("454D532D-5374-6575-6572-756E672D4348", callback=handle_data)

#value = device.char_read("a1e8f5b1-696b-4e4c-87c6-69dfe0b0093b")
	
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
udp = False
if udp:
	UDP_IP = "127.0.0.1"
	UDP_PORT = 5000

	sock = socket.socket(socket.AF_INET, # Internet
						 socket.SOCK_DGRAM) # UDP
	sock.bind((UDP_IP, UDP_PORT))

	while True:
		data, addr = sock.recvfrom(1024) # buffer size is 1024 bytes
		print "received message:", data
		# write to the BLE device