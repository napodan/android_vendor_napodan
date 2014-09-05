.PHONY: myclean
installclean: myclean

myclean:
	$(hide) rm -rf $(PRODUCT_OUT)/*.md5sum

.PHONY: oxygen
oxygen: otapackage
	$(hide) ./vendor/oxygen/tools/squisher

