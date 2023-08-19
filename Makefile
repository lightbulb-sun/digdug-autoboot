.DELETE_ON_ERROR:

AS = rgbasm
ASFLAGS = -E
LD = rgblink
FIX = rgbfix
FIXFLAGS = -f gh

ROM = digdug.gb
NAME = hack
SOURCE_FILE = $(NAME).asm

OBJECT_FILE_OLD = $(NAME)-old.o
OBJECT_FILE_NEW = $(NAME)-new.o

OUTPUT_ROM_OLD = $(NAME)-old.gb
OUTPUT_ROM_NEW = $(NAME)-new.gb

OBJS = $(OBJECT_FILE_OLD) $(OBJECT_FILE_NEW) $(OUTPUT_ROM_OLD) $(OUTPUT_ROM_NEW)

all: $(OUTPUT_ROM_NEW) $(OUTPUT_ROM_OLD)

$(OUTPUT_ROM_NEW): $(OBJECT_FILE_NEW)
	$(LD) -O $(ROM) -o $@ $<
	$(FIX) $(FIXFLAGS) $@

$(OUTPUT_ROM_OLD): $(OBJECT_FILE_OLD)
	$(LD) -O $(ROM) -o $@ $<
	$(FIX) $(FIXFLAGS) $@

$(OBJECT_FILE_NEW): $(SOURCE_FILE)
	$(AS) $(ASFLAGS) $< -o $@ -D NEW=1

$(OBJECT_FILE_OLD): $(SOURCE_FILE)
	$(AS) $(ASFLAGS) $< -o $@ -D NEW=0

.PHONY:
clean:
	rm -rf $(OBJS)
