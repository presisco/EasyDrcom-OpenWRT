#
# Copyright (C) 2012-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=easydrcom
PKG_VERSION:=0.9
PKG_RELEASE:=3

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

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
	$(CP) ./src/* $(PKG_BUILD_DIR)/
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

