#
# Copyright (C) 2012-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=easydrcom
PKG_VERSION:=0.9
PKG_RELEASE:=4

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_SOURCE:=master.zip
PKG_SOURCE_URL:=https://github.com/coverxit/EasyDrcom/archive
PKG_MD5SUM:=c2677b598480ba65174a08f0bf05b32f

include $(INCLUDE_DIR)/package.mk

define Package/easydrcom
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpcap +libstdcpp +libpthread
  TITLE:=Dr.COM client
endef

define Package/easydrcom/description
  Dr.COM client
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)

	unzip $(DL_DIR)/$(PKG_SOURCE) -d $(PKG_BUILD_DIR)/
	$(CP) $(PKG_BUILD_DIR)/EasyDrcom-master/EasyDrcom/* $(PKG_BUILD_DIR)
	
	rm -r $(PKG_BUILD_DIR)/EasyDrcom-master

	$(Build/Patch)
#	cat ./patches/* > $(PKG_BUILD_DIR)/src/patch
#	patch -p1 < patch
#	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

TARGET_CFLAGS += 
TARGET_CXXFLAGS += -Wno-error=format-security 

define Package/easydrcom/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/easydrcom $(1)/usr/bin
	$(CP) -a files/* $(1)/
	chmod 755 $(1)/etc/init.d/easydrcom
endef

$(eval $(call BuildPackage,easydrcom))
