# SPDX-License-Identifier: GPL-2.0-only
zram-y	:=	zcomp.o zram_drv.o
ccflags-y += -Wno-unused-variable -Wno-unused-function

obj-$(CONFIG_ZRAM)	+=	zram.o
obj-$(CONFIG_ZCOMP_CPU)	+=	zcomp_cpu.o
obj-$(CONFIG_ZCOMP_EH)	+=	zcomp_eh.o
