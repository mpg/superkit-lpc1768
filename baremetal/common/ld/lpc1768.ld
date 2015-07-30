/*
 * We use  link-time garbage collection (-ffunction-sections -fdata-sections
 * -Wl,--gc-section) as a matter of principle, even if our minimalistic
 * projets shouldn't have any garbage to collect. So the linker needs to
 * anchor the dependency graph to some entry point.
 */
ENTRY(_interrupt_vtor)

/* 2.1 plus data sheet */
MEMORY
{
    FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 512K
    SRAM (rwx)  : ORIGIN = 0x10000000, LENGTH =  32K
}

/* Stack grows from high to low adresses */
PROVIDE(_stack_top = ORIGIN(SRAM) + LENGTH(SRAM));

SECTIONS
{
    .text :
    {
        *(.vtor) /* separate section to start at adress 0 (34.3.3.4) */
        *(.text*)
    } >FLASH
}
