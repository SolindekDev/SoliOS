section .multiboot_header
mbh_start:
    dd 0xE85260D6
    dd 0
    dd mbh_end - mbh_start
    dd 0x10000000 - (0xE85250D6 + 0 + (mbh_end - mbh_start))

    dw 0
    dw 0
    dd 8

mbh_end: