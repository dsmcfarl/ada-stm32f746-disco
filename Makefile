TOOLS=~/opt/GNAT/2021-arm-elf/bin
GPRBUILD=$(TOOLS)/gprbuild
GPRCLEAN=$(TOOLS)/gprclean
GDB=$(TOOLS)/arm-eabi-gdb
OPENOCD=/bin/openocd -f openocd.cfg

ASIS_DIR=asis-2019-20190517-18AB5-src
GNATCHECK=ASIS/$(ASIS_DIR)/tools/gnatcheck/gnatcheck
GNATTEST=ASIS/$(ASIS_DIR)/tools/gnattest/gnattest

main:
	$(GPRBUILD) -d -largs -Wl,-Map=map.txt
flash: main
	$(OPENOCD) -c "program $< verify reset exit"
gdb-server:
	$(OPENOCD) -c "gdb_port 4242" -c init -c "arm semihosting enable"
debug:
	$(GDB) -x gdbinit main

gnatcheck: $(GNATCHECK)
	$(GNATCHECK) -P my_project.gpr

gnattest: $(GNATTEST)
	$(GNATTEST) -P my_project.gpr

$(GNATTEST) $(GNATCHECK): ASIS/asis-2019-20190517-18AB5-src.tar.gz
	rm -rf $(ASIS_DIR) && \
		cd ASIS && \
		tar xf $(ASIS_DIR).tar.gz && \
		cd $(ASIS_DIR) && \
		make tools
clean:
	$(GPRCLEAN) -r
	rm -rf obj
distclean: clean
	rm -rf ASIS/$(ASIS_DIR)
.PHONY: flash server clean debug main gnatcheck gnattest
