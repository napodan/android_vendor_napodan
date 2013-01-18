LOCAL_PATH := $(call my-dir)

LIST_APK := \
	#Superuser.apk

$(call add-prebuilt-apk-files, $(LIST_APK))

