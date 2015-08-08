PREFIX=arm-none-eabi-
AS=$(PREFIX)as
OBJCOPY=$(PREFIX)objcopy
OBJDUMP=$(PREFIX)objdump

ASFLAGS=-mcpu=cortex-m3

TARGETS=blinky.bin blinky.dump

all: $(TARGETS)

%.dump: %.o
	$(OBJDUMP) -d $< > $@

%.bin: %.o
	$(OBJCOPY) $< -O binary $@

clean:
	rm -f $(TARGETS)

.PHONY: clean
