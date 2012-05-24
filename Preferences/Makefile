
GO_EASY_ON_ME = 1
include /var/theos/makefiles/common.mk

BUNDLE_NAME = SparrowPrefs
SparrowPrefs_FILES = Preferences.mm
SparrowPrefs_OBJCFLAGS = -I$(THEOS_PROJECT_DIR) -F$(THEOS_PROJECT_DIR)
SparrowPrefs_FRAMEWORKS = UIKit
SparrowPrefs_PRIVATE_FRAMEWORKS = Preferences
SparrowPrefs_INSTALL_PATH = /Library/PreferenceBundles

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp Sparrow.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Sparrow.plist$(ECHO_END)

