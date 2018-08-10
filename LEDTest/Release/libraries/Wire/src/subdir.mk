################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src\Wire.cpp 

LINK_OBJ += \
.\libraries\Wire\src\Wire.cpp.o 

CPP_DEPS += \
.\libraries\Wire\src\Wire.cpp.d 


# Each subdirectory must supply rules for building sources it contributes
libraries\Wire\src\Wire.cpp.o: F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src\Wire.cpp
	@echo 'Building file: $<'
	@echo 'Starting C++ compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++" -c -g -Os -Wall -Wextra -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 -x c++ "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


