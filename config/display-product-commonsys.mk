PRODUCT_PACKAGES += libdisplayconfig.system \
                    libgralloc.system.qti \
                    libdrm \
                    liblayerext.qti \
                    libsmomoconfig.qti \
                    libcomposerextn.qti \
                    libdisplayconfig.system.qti

SOONG_CONFIG_NAMESPACES += qtidisplaycommonsys
# Soong Keys
SOONG_CONFIG_qtidisplaycommonsys := displayextension composer3ext qticomposerversion
# Soong Values

# displayextension controls global compile time disablement of SF extensions
SOONG_CONFIG_qtidisplaycommonsys_displayextension := false

# Variables can be added here on a transient basis to merge
# features that are not yet consumed in keystone
# Once the feature has been consumed, these can be removed
# and the feature can be enabled/disabled at run time via android
# properties
SOONG_CONFIG_qtidisplaycommonsys_composer3ext := false

ifeq ($(call is-vendor-board-platform,QCOM),true)
    SOONG_CONFIG_qtidisplaycommonsys_displayextension := true
    SOONG_CONFIG_qtidisplaycommonsys_composer3ext := true
endif

# Enable conditional compilation for HWC's version in the system image.
# Properly determine the system image version to select the appropriate version for the internal
# composer's interface. Two key build properties are PLATFORM_VERSION_CODENAME and PLATFORM_VERSION.
# PLATFORM_VERSION_CODENAME holds the string codename of the current Android version.
# PLATFORM_VERSION contains the version number of the current Android version, which matches
# PLATFORM_VERSION_CODENAME until the FRC stage.
SOONG_CONFIG_qtidisplaycommonsys_qticomposerversion := composer3_v3

# TODO: Update VanillaIceCream to Android W's code name
ifeq ($(PLATFORM_VERSION_CODENAME), VanillaIceCream)
    ifeq ($(PLATFORM_VERSION), $(filter $(PLATFORM_VERSION), VanillaIceCream 16))
        SOONG_CONFIG_qtidisplaycommonsys_qticomposerversion := composer3_v4
    else
        SOONG_CONFIG_qtidisplaycommonsys_qticomposerversion := composer3_v3
    endif
endif
