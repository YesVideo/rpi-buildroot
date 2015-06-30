################################################################################
#
# pi_blaster
#
################################################################################

PI_BLASTER_VERSION = cd318cd63031a30249a4c08435b97263fa76d7b7
PI_BLASTER_SITE = $(call github,YesVideo,pi-blaster,$(PI_BLASTER_VERSION))
PI_BLASTER_LICENSE = MIT

define PI_BLASTER_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
PI_BLASTER_PRE_CONFIGURE_HOOKS += PI_BLASTER_RUN_AUTOGEN

define PI_BLASTER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 package/pi-blaster/S50pi-blaster \
		$(TARGET_DIR)/etc/init.d/S50pi-blaster
endef

$(eval $(autotools-package))
