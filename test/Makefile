
OBJFMT=$(shell \
  $(CC) -x c -o $$$$.o -c /dev/null; \
  objdump -f $$$$.o | awk '/format/{print $$NF}'; \
  rm -f $$$$.o \
)

OBJARCH=$(shell $(CC) -x c -o $$$$.o -c /dev/null; \
  objdump -f $$$$.o | awk '/arch/{print $$2}' | tr -d ','; \
	rm -f $$$$.o \
)

core_info_BINARY = $(wildcard core_info.binX)
OBJS += $(patsubst %.bin, %.o, $(core_info_BINARY))
CFLAGS += -DEXTERN_CORE_INFO=$(words $(core_info_BINARY))

csl_test: csl_test.o csl.o core_info.o
	$(CC) -o $@ $^

csl_test.o: csl_test.c ../csl.h
	$(CC) -I.. $(CFLAGS) -o $@ -c $<

csl.o: ../csl.c ../csl.h
	$(CC) -I.. $(CFLAGS) -o $@ -c $<

core_info.o:core_info.bin
	objcopy -I binary -O $(OBJFMT) -B $(OBJARCH) $< $@

test:
	@echo CC=$(CC)
	@echo OBJFMT=$(OBJFMT)
	@echo OBJARCH=$(OBJARCH)

clean:
	rm csl_test *.o

.PHONY: test clean
