#Adding a link from busybox to vi
ALL_MODULES.busybox.INSTALLED := \
    $(ALL_MODULES.busybox.INSTALLED) /system/xbin/vi

DATE_ZIP := $(shell date +%Y%m%d_%H%M%S)

NOM_ZIP := jelly_$(DATE_ZIP)
bacon: otapackage
ifneq ($(TARGET_CUSTOM_RELEASETOOL),)
	@echo "Running custom releasetool..."
	$(hide) $(TARGET_CUSTOM_RELEASETOOL)
else
	@echo "Running releasetool..."
	$(hide) OTAPACKAGE=$(PWD)/$(INTERNAL_OTA_PACKAGE_TARGET) ./vendor/cm/tools/squisher
	cd $(PRODUCT_OUT); \
		[[ -d repack ]] && \rm -rf repack; \
		mkdir -p repack/data/app; \
		cd repack; \
		unzip ../cm-.zip; \
		grep -v recovery META-INF/com/google/android/updater-script > /tmp/updater-script; \
		mv /tmp/updater-script META-INF/com/google/android/updater-script; \
		echo 'mount("yaffs2", "MTD", "userdata", "/data");' >> META-INF/com/google/android/updater-script; \
		echo 'ui_print("Installing Data");' >> META-INF/com/google/android/updater-script; \
		echo 'package_extract_dir("data", "/data");' >> META-INF/com/google/android/updater-script; \
		echo 'unmount("/data");' >> META-INF/com/google/android/updater-script; \
		zip -r ../$(NOM_ZIP).zip .;
	java -Xmx1024m -jar out/host/linux-x86/framework/signapk.jar \
		-w build/target/product/security/testkey.x509.pem \
		build/target/product/security/testkey.pk8 \
		$(PRODUCT_OUT)/$(NOM_ZIP).zip $(PRODUCT_OUT)/$(NOM_ZIP)_signe.zip
	mkdir -p ../Build/$(DATE_ZIP)
	cp $(PRODUCT_OUT)/$(NOM_ZIP)_signe.zip ../Build/$(DATE_ZIP)/
	repo diff > ../Build/$(DATE_ZIP)/diff.txt
	repo manifest -r -o ../Build/$(DATE_ZIP)/build.xml
endif

