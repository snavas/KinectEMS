################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src\utility\twi.c 

C_DEPS += \
.\libraries\Wire\src\utility\twi.c.d 

LINK_OBJ += \
.\libraries\Wire\src\utility\twi.c.o 


# Each subdirectory must supply rules for building sources it contributes
libraries\Wire\src\utility\twi.c.o: F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src\utility\twi.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"F:\sloeber\/arduinoPlugin/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -Wall -Wextra -std=gnu11 -ffunction-sections -fdata-sections -flto -fno-fat-lto-objects -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10802 -DARDUINO_AVR_NANO -DARDUINO_ARCH_AVR   -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\cores\arduino" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\variants\eightanaloginputs" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire" -I"F:\sloeber\arduinoPlugin\packages\arduino\hardware\avr\1.6.20\libraries\Wire\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


