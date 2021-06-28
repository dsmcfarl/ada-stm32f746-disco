TOOLS=~/opt/GNAT/2021-arm-elf/bin
GPRBUILD=$(TOOLS)/gprbuild
GPRCLEAN=$(TOOLS)/gprclean
GDB=$(TOOLS)/arm-eabi-gdb
OPENOCD=/bin/openocd -f openocd.cfg

main:
	$(GPRBUILD) -d -largs -Wl,-Map=map.txt
flash: main
	$(OPENOCD) -c "program $< verify reset exit"
gdb-server:
	$(OPENOCD) -c "gdb_port 4242" -c init -c "arm semihosting enable"
debug:
	$(GDB) -x gdbinit main
clean:
	$(GPRCLEAN) -r
	rm -rf obj
.PHONY: flash server clean debug main
