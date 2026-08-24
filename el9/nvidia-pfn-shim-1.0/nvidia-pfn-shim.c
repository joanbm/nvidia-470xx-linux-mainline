#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/mm.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Compatibility shim for NVIDIA 470 for EL9 follow_pfn");
MODULE_AUTHOR("GCS ENCS AITS, Concordia, Serguei Mokhov");

int nvidia_follow_pfnmap_start(struct follow_pfnmap_args *args)
{
    return follow_pfnmap_start(args);
}
EXPORT_SYMBOL(nvidia_follow_pfnmap_start);

void nvidia_follow_pfnmap_end(struct follow_pfnmap_args *args)
{
    follow_pfnmap_end(args);
}
EXPORT_SYMBOL(nvidia_follow_pfnmap_end);

MODULE_VERSION("1.0");
