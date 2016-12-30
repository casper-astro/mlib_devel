OBJCOPY = objcopy

OBJFMT = $(shell \
  $(CC) -x c -o $$$$.o -c /dev/null; \
  objdump -f $$$$.o | awk '/format/{print $$NF}'; \
  rm -f $$$$.o \
)

OBJARCH = $(shell $(CC) -x c -o $$$$.o -c /dev/null; \
  objdump -f $$$$.o | awk '/arch/{print $$2}' | tr -d ','; \
	rm -f $$$$.o \
)

# Use core_info if .bin or .tab exists, otherwise use dummy_info.bin
core_info_BINARY = $(word 1, \
									 $(wildcard core_info.bin core_info.tab) \
									 dummy_info.bin)

OBJS += $(patsubst %.bin, %.o, \
				$(patsubst %.tab, %.o, $(core_info_BINARY)))

csl_test: csl_test.o csl.o $(OBJS)
	$(CC) -o $@ $^

csl_test.o: csl_test.c ../csl.h
	$(CC) -I.. $(CFLAGS) -o $@ -c $<

csl.o: ../csl.c ../csl.h
	$(CC) -I.. $(CFLAGS) -o $@ -c $<

dummy_info.o: dummy_info.bin
	$(OBJCOPY) -I binary -O $(OBJFMT) -B $(OBJARCH) --redefine-sym \
		_binary_dummy_info_bin_start=_binary_core_info_bin_start \
		$< $@

core_info.o: core_info.bin
	objcopy -I binary -O $(OBJFMT) -B $(OBJARCH) $< $@

core_info.bin: core_info.tab
	ruby ../util/cit2bin.rb $< > $@

test:
	@echo CC=$(CC)
	@echo OBJFMT=$(OBJFMT)
	@echo OBJARCH=$(OBJARCH)

clean:
	rm csl_test *.o

.PHONY: test clean
