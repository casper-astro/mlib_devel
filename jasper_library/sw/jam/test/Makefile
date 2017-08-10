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

all: csl_find_key_test csl_find_by_payload_test

%_test: %_test.o csl.o $(OBJS)
	$(CC) -o $@ $^

%_test.o: %_test.c ../csl.h
	$(CC) -I.. $(CFLAGS) -o $@ -c $<

csl.o: ../csl.c ../csl.h
	$(CC) -I.. $(CFLAGS) -o $@ -c $<

dummy_info.o: dummy_info.bin
	$(OBJCOPY) -I binary -O $(OBJFMT) -B $(OBJARCH) \
		--redefine-sym \
		_binary_dummy_info_bin_start=_core_info \
		-N _binary_dummy_info_bin_end \
		-N _binary_dummy_info_bin_size \
		--rename-section .data=.core_info \
		$< $@

core_info.o: core_info.bin
	$(OBJCOPY) -I binary -O $(OBJFMT) -B $(OBJARCH) \
		--redefine-sym \
		_binary_core_info_bin_start=_core_info \
		-N _binary_core_info_bin_end \
		-N _binary_core_info_bin_size \
		--rename-section .data=.core_info \
		$< $@

core_info.bin: core_info.tab
	ruby ../util/cit2bin.rb $< > $@

test:
	@echo CC=$(CC)
	@echo OBJFMT=$(OBJFMT)
	@echo OBJARCH=$(OBJARCH)

clean:
	rm csl_find_key_test csl_find_by_payload_test *.o core_info.bin

.PHONY: test clean
