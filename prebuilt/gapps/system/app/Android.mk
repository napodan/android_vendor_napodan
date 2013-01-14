LOCAL_PATH := $(call my-dir)

LIST_APK = \
					ChromeBookmarksSyncAdapter.apk \
					GenieWidget.apk \
					Gmail2.apk \
					GmsCore.apk \
					GoogleBackupTransport.apk \
					GoogleCalendarSyncAdapter.apk \
					GoogleContactsSyncAdapter.apk \
					GoogleEars.apk \
					GoogleFeedback.apk \
					GoogleLoginService.apk \
					GoogleServicesFramework.apk \
					GooglePartnerSetup.apk \
					GoogleTTS.apk \
					LatinImeDictionaryPack.apk \
					MediaUploader.apk \
					NetworkLocation.apk \
					OneTimeInitializer.apk \
					Phonesky.apk \
					SetupWizard.apk \

$(call add-prebuilt-apk-files, $(LIST_APK))

