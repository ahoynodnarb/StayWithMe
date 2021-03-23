ARCHS = arm64 arm64e

TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StayWithMe

StayWithMe_FILES = Tweak.xm
StayWithMe_CFLAGS = -fobjc-arc
StayWithMe_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += staywithmeprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
