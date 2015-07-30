COMMON=../common/

PREFIX=arm-none-eabi-
CC=$(PREFIX)gcc
OBJCOPY=$(PREFIX)objcopy

FLAGS=-mcpu=cortex-m3 -mthumb
CFLAGS=$(FLAGS) -I$(COMMON)include -fno-common -Os -std=c99 -Wall -Wextra -Werror -ffunction-sections -fdata-sections
LDFLAGS=$(FLAGS) -T$(COMMON)ld/lpc1768.ld -nostartfiles -nostdlib -lnosys -Wl,--gc-section

all: main.bin main.elf main.o

%.bin: %.elf
	$(OBJCOPY) $< -O binary $@

%.elf: %.o
	$(CC) $(LDFLAGS) $< -o $@

clean:
	rm -f *.o *.elf *.bin
