################################################################################
#
# RTL8188C_8192C_wpa_supplicant_hostapd
#
################################################################################

RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_VERSION = 59d8585776ca184f2c564a34a160de82a7231266
RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_SITE = git@github.com:YesVideo/RTL8188C_8192C_wpa_supplicant_hostapd.git
RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_SITE_METHOD = git
RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_LICENSE = GPLv2
RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_LICENSE_FILES = COPYING

define RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/hostapd all
endef

define RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/hostapd/hostapd $(TARGET_DIR)/usr/sbin
	$(INSTALL) -D -m 755 package/RTL8188C_8192C_wpa_supplicant_hostapd/S80hostapd \
		$(TARGET_DIR)/etc/init.d/S80hostapd
endef

define RTL8188C_8192C_WPA_SUPPLICANT_HOSTAPD_PERMISSIONS
	/usr/sbin/hostapd  f  4755  0  0  -  -  -  -  -
endef

$(eval $(generic-package))
