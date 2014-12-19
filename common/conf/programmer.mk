# Incoming Variables:
# CONFIG_HEX_PATH  (optional)

UTILSPATH = $(PSOC_PROG_DIR)
#UTILSPATH = ~/projects/PSoC/programmer

MERGEHEX = POSIXLY_CORRECT=1 $(UTILSPATH)/bin/mergehex -nm $(UTILSPATH)/config/nm.hex
BURNCMD = $(UTILSPATH)/bin/prog -C $(UTILSPATH)/config -d $(DEVICE_NAME) program

ifdef CONFIG_HEX_PATH
CONFIG_HEX = -d $(CONFIG_HEX_PATH)
endif

%.hex: %.elf
	$(OBJCOPY) -O ihex  $< $*_tmp.hex
	$(MERGEHEX) -c $*_tmp.hex $(CONFIG_HEX) -o $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
