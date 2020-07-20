IPC_DAEMON_SITE = $(TOPDIR)/../app/ipc-daemon
IPC_DAEMON_VERSION = release
IPC_DAEMON_SITE_METHOD = local

ifeq ($(BR2_PACKAGE_RK_OEM), y)
	IPC_DAEMON_INSTALL_TARGET_OPTS = DESTDIR=$(BR2_PACKAGE_RK_OEM_INSTALL_TARGET_DIR) install/fast
	IPC_DAEMON_DEPENDENCIES += rk_oem
endif

ifeq ($(BR2_PACKAGE_IPC_DAEMON_MINILOGGER), y)
    IPC_DAEMON_DEPENDENCIES += minilogger
endif

$(eval $(cmake-package))
