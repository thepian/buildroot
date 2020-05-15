################################################################################
#
# qt5websockets
#
################################################################################

QT5WEBSOCKETS_VERSION = $(QT5_VERSION)
QT5WEBSOCKETS_SITE = $(QT5_SITE)
QT5WEBSOCKETS_SOURCE = qtwebsockets-$(QT5_SOURCE_TARBALL_PREFIX)-$(QT5WEBSOCKETS_VERSION).tar.xz
QT5WEBSOCKETS_DEPENDENCIES = qt5base
QT5WEBSOCKETS_INSTALL_STAGING = YES

QT5WEBSOCKETS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools)
QT5WEBSOCKETS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3
ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
QT5WEBSOCKETS_LICENSE := $(QT5WEBSOCKETS_LICENSE), BSD-3-Clause (examples)
endif

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT5WEBSOCKETS_DEPENDENCIES += qt5declarative
endif

define QT5WEBSOCKETS_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QT5WEBSOCKETS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WEBSOCKETS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE_QUICK),y)
define QT5WEBSOCKETS_INSTALL_TARGET_QMLS
	cp -dpfr $(STAGING_DIR)/usr/qml/Qt/WebSockets $(TARGET_DIR)/usr/qml/Qt/
	cp -dpfr $(STAGING_DIR)/usr/qml/QtWebSockets $(TARGET_DIR)/usr/qml/
endef
endif

ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
define QT5WEBSOCKETS_INSTALL_TARGET_EXAMPLES
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/examples/websockets $(TARGET_DIR)/usr/lib/qt/examples/
endef
endif

ifneq ($(BR2_STATIC_LIBS),y)
define QT5WEBSOCKETS_INSTALL_TARGET_LIBS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5WebSockets.so.* $(TARGET_DIR)/usr/lib
endef
endif

define QT5WEBSOCKETS_INSTALL_TARGET_CMDS
	$(QT5WEBSOCKETS_INSTALL_TARGET_LIBS)
	$(QT5WEBSOCKETS_INSTALL_TARGET_QMLS)
	$(QT5WEBSOCKETS_INSTALL_TARGET_EXAMPLES)
endef

$(eval $(generic-package))
