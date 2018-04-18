.DEFAULT_GOAL := all

INSTALL_VENDOR := vendor/.installed

# Install reveal.js
$(INSTALL_VENDOR): install_vendor.sh
	$(abspath $<) vendor/
	touch $(INSTALL_VENDOR)

all: $(INSTALL_VENDOR)
