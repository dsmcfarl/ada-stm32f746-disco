TOOLS=~/opt/GNAT/2019-arm-elf/bin
GPRBUILD=$(TOOLS)/gprbuild
GPRCLEAN=$(TOOLS)/gprclean
GDB=$(TOOLS)/arm-eabi-gdb
OPENOCD=/bin/openocd -f scripts/openocd.cfg

ASIS_VER=asis-2019-20190517-18AB5-src
ASIS_DIR=ASIS/$(ASIS_VER)
GNATCHECK=$(ASIS_DIR)/tools/gnatcheck/gnatcheck
GNATTEST=$(TOOLS)/arm-eabi-gnattest
GNATTEST_FILES= \
		src/motor.ads \
		src/ui.ads \
		src/debug.ads

main:
	$(GPRBUILD) -d -largs -Wl,-Map=map.txt
flash: main
	$(OPENOCD) -c "program $< verify reset exit"
openocd:
	$(OPENOCD)
debug: main
	$(GDB) -x scripts/debug.gdb main

test: gnattest
	$(GPRBUILD) -P obj/gnattest/harness/test_driver.gpr
	$(GDB) -batch-silent -x scripts/test.gdb obj/gnattest/harness/test_runner

gnatcheck: $(GNATCHECK)
	mkdir -p obj
	$(GNATCHECK) -P my_project.gpr

gnattest:
	$(GNATTEST) -P my_project.gpr $(GNATTEST_FILES)

$(GNATCHECK): ASIS/asis-2019-20190517-18AB5-src.tar.gz
	rm -rf $(ASIS_DIR)
	tar -C ASIS -xf ASIS/$(ASIS_VER).tar.gz
	make -C $(ASIS_DIR) tools
clean:
	$(GPRCLEAN) -r
	rm -rf obj
distclean: clean
	rm -rf ASIS/$(ASIS_DIR)
.PHONY: flash server clean debug main gnatcheck gnattest test
