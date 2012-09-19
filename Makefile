LOCAL_PATH := .
TOPDIR := ../../

empty :=
space := $(empty) $(empty)

define word-colon
$(word $(1),$(subst :,$(space),$(2)))
endef

define generate_mkfile
$(1): $(2)
	patch -o $(1) $(2) $(3)
endef

NAPODAN_MKFILE := \
	$(LOCAL_PATH)/products/small_bravo.mk:$(TOPDIR)device/htc/bravo/ev.mk:$(LOCAL_PATH)/patchs/ev_mk.patch \
	$(LOCAL_PATH)/products/common.mk:$(TOPDIR)vendor/ev/config/common.mk:$(LOCAL_PATH)/patchs/common_mk.patch

OUTMKFILE :=

$(foreach cf,$(NAPODAN_MKFILE), \
	$(eval $(call generate_mkfile, $(call word-colon,1,$(cf)), $(call word-colon,2,$(cf)), $(call word-colon,3,$(cf)))) \
	$(eval OUTMKFILE += $(call word-colon,1,$(cf))) )

mkfile: $(OUTMKFILE)

