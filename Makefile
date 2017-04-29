#
# Copyright (C) 2012-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=easydrcom
PKG_VERSION:=0.9
PKG_RELEASE:=15

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_SOURCE:=master.zip
PKG_SOURCE_URL:=https://github.com/presisco/EasyDrcom/archive
PKG_MD5SUM:=d4165da3103b17d221f3923e2a025179

PKG_CONFIG_DEPENDS := EASYDRCOM_DEBUG

include $(INCLUDE_DIR)/package.mk

define Package/easydrcom
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpcap +libstdcpp +libpthread
  TITLE:=Dr.COM client
  MENU:=1
endef

define Package/easydrcom/description
  Dr.COM client v$PKG_VERSION r$PKG_RELEASE
endef

define Package/easydrcom/config
  source "$(SOURCE)/Config.in"
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)

	unzip $(DL_DIR)/$(PKG_SOURCE) -d $(PKG_BUILD_DIR)/
	$(CP) $(PKG_BUILD_DIR)/EasyDrcom-master/EasyDrcom/* $(PKG_BUILD_DIR)
	
	rm -r $(PKG_BUILD_DIR)/EasyDrcom-master

	$(Build/Patch)
endef

TARGET_CFLAGS += 
TARGET_CXXFLAGS += -Wno-error=format-security -DOPENWRT $(if $(CONFIG_EASYDRCOM_DEBUG),-DEASYDRCOM_DEBUG, )

define Package/easydrcom/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/easydrcom $(1)/usr/bin
	$(CP) -a files/* $(1)/
	chmod 755 $(1)/etc/init.d/easydrcom
endef

$(eval $(call BuildPackage,easydrcom))
