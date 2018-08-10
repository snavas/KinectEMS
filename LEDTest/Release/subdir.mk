################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
INO_SRCS += \
..\ArduinoSoftware.ino 

CPP_SRCS += \
..\.ino.cpp \
..\AD5252.cpp \
..\AltSoftSerial.cpp \
..\EMSChannel.cpp \
..\EMSSystem.cpp \
..\Rn4020BTLe.cpp 

LINK_OBJ += \
.\.ino.cpp.o \
.\AD5252.cpp.o \
.\AltSoftSerial.cpp.o \
.\EMSChannel.cpp.o \
.\EMSSystem.cpp.o \
.\Rn4020BTLe.cpp.o 

INO_DEPS += \
.\ArduinoSoftware.ino.d 

CPP_DEPS += \
.\.ino.cpp.d \
.\AD5252.cpp.d \
.\AltSoftSerial.cpp.d \
.\EMSChannel.cpp.d \
.\EMSSystem.cpp.d \
.\Rn4020BTLe.cpp.d 


# Each subdirectory must supply rules for building sources it contributes
.ino.cpp.o: ..\.ino.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

AD5252.cpp.o: ..\AD5252.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

AltSoftSerial.cpp.o: ..\AltSoftSerial.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

ArduinoSoftware.o: ..\ArduinoSoftware.ino
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

EMSChannel.cpp.o: ..\EMSChannel.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

EMSSystem.cpp.o: ..\EMSSystem.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '

Rn4020BTLe.cpp.o: ..\Rn4020BTLe.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


