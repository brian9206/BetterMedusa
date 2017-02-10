include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BetterMedusa
BetterMedusa_FILES = Tweak.xm BetterMedusaPreference.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS = bettermedusapreference
include $(THEOS_MAKE_PATH)/aggregate.mk
