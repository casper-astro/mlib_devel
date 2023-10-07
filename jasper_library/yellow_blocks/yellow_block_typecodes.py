"""
Here lie device typecode definitions.
These codes get baked into toolflow-generate firmware can be used by
embedded software to determine what types of devices are present on
the CPU bus at different memory locations.

For example, a typical use case would be:

1. MicroBlaze wakes up on programming a board
2. Microblaze looks for an Ethernet core in the running firmware by
   searching for something in the firmware's memory map with typecode
   TYPECODE_ETHCORE.
3. MicroBlaze manipulates this device so as to talk to the outside world.

Values chosen are non-critical, but should be unique, and <256.
"""

TYPECODE_SWREG     = 0
TYPECODE_ETHCORE   = 1
TYPECODE_ADC16CTRL = 2
TYPECODE_SYSBLOCK  = 3
TYPECODE_BRAM      = 4
TYPECODE_RFDC      = 5
