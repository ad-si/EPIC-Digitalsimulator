SQUEAK_VERSION := 6.1
SQUEAK_BUILD := Squeak6.1-23976-64bit
SQUEAK_DMG := $(SQUEAK_BUILD)-202606270913-macOS-ARMv8.dmg
SQUEAK_URL := https://files.squeak.org/$(SQUEAK_VERSION)/$(SQUEAK_BUILD)/$(SQUEAK_DMG)

SQUEAK_DIR ?= $(HOME)/.local/share/squeak-epic
SQUEAK_APP := $(SQUEAK_DIR)/$(SQUEAK_BUILD).app
SQUEAK_VM := $(SQUEAK_APP)/Contents/MacOS/Squeak
SQUEAK_RES := $(SQUEAK_APP)/Contents/Resources
IMAGE := $(SQUEAK_DIR)/epic.image

APP_STAGE := $(SQUEAK_DIR)/EPIC.app
APP_RES := $(APP_STAGE)/Contents/Resources
APP_PLIST := $(APP_STAGE)/Contents/Info.plist

# UI scale factor in percent (same as Squeak's "Extras > Scale factor" menu)
SCALE_PERCENT ?= 200

PACKAGE_FILES := $(shell find packages -type f)
RESOURCE_FILES := $(shell find epic-resources -type f)


.PHONY: help
help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "%-10s %s\n", $$1, $$2}'


$(SQUEAK_VM):
	mkdir -p $(SQUEAK_DIR)
	curl -fL -o $(SQUEAK_DIR)/$(SQUEAK_DMG) $(SQUEAK_URL)
	set -e; \
	mnt=$$(hdiutil attach -nobrowse -readonly $(SQUEAK_DIR)/$(SQUEAK_DMG) \
		| grep -o '/Volumes/.*' | tail -1); \
	cp -R "$$mnt/$(SQUEAK_BUILD).app" $(SQUEAK_DIR)/; \
	hdiutil detach "$$mnt" >/dev/null
	rm $(SQUEAK_DIR)/$(SQUEAK_DMG)


$(IMAGE): Makefile scripts/load.st $(SQUEAK_VM) $(PACKAGE_FILES) $(RESOURCE_FILES)
	cp $(SQUEAK_RES)/$(SQUEAK_BUILD).image $(IMAGE)
	cp $(SQUEAK_RES)/$(SQUEAK_BUILD).changes $(SQUEAK_DIR)/epic.changes
	cp $(SQUEAK_RES)/*.sources $(SQUEAK_DIR)/
	rm -rf $(SQUEAK_DIR)/epic-resources
	cp -R epic-resources $(SQUEAK_DIR)/
	mkdir -p $(SQUEAK_DIR)/epic
	rm -f $(SQUEAK_DIR)/load-error.txt
	cd $(SQUEAK_DIR) && $(SQUEAK_VM) -headless epic.image \
		$(CURDIR)/scripts/load.st $(CURDIR)/packages default
	@if test -f $(SQUEAK_DIR)/load-error.txt; then \
		cat $(SQUEAK_DIR)/load-error.txt; rm -f $(IMAGE); exit 1; \
	fi


.PHONY: image
image: $(IMAGE) ## Build the Squeak image with EPIC loaded


.PHONY: open
open: $(IMAGE) ## Open EPIC (override scale with SCALE_PERCENT=150)
	cd $(SQUEAK_DIR) && { nohup $(SQUEAK_VM) epic.image \
		$(CURDIR)/scripts/start.st $(SCALE_PERCENT) \
		>$(SQUEAK_DIR)/squeak.log 2>&1 </dev/null & }


.PHONY: test
test: $(IMAGE) ## Run the EPIC tests headlessly (at SCALE_PERCENT)
	cp $(IMAGE) $(SQUEAK_DIR)/test.image
	cp $(SQUEAK_DIR)/epic.changes $(SQUEAK_DIR)/test.changes
	rm -f $(SQUEAK_DIR)/test-results.txt
	cd $(SQUEAK_DIR) && $(SQUEAK_VM) -headless test.image \
		$(CURDIR)/scripts/test.st $(CURDIR)/packages $(SCALE_PERCENT)
	rm -f $(SQUEAK_DIR)/test.image $(SQUEAK_DIR)/test.changes
	@cat $(SQUEAK_DIR)/test-results.txt; echo
	@test "$$(tail -n 1 $(SQUEAK_DIR)/test-results.txt)" = PASSED


.PHONY: screenshots
screenshots: $(IMAGE) ## Render the README screenshots into img/
	cp $(IMAGE) $(SQUEAK_DIR)/screenshots.image
	cp $(SQUEAK_DIR)/epic.changes $(SQUEAK_DIR)/screenshots.changes
	rm -f $(SQUEAK_DIR)/screenshots-error.txt
	cd $(SQUEAK_DIR) && $(SQUEAK_VM) -headless screenshots.image \
		$(CURDIR)/scripts/screenshots.st $(CURDIR)/img $(SCALE_PERCENT)
	rm -f $(SQUEAK_DIR)/screenshots.image $(SQUEAK_DIR)/screenshots.changes
	@if test -f $(SQUEAK_DIR)/screenshots-error.txt; then \
		cat $(SQUEAK_DIR)/screenshots-error.txt; exit 1; \
	fi


# The bundle is staged outside the repo, because file syncing services
# (e.g. Dropbox) keep adding extended attributes, which break code signing.
build/EPIC.app: $(IMAGE) scripts/lockdown.st
	rm -rf $(APP_STAGE) $@ build/EPIC.zip
	cp -R $(SQUEAK_APP) $(APP_STAGE)
	rm -f $(APP_RES)/$(SQUEAK_BUILD).image $(APP_RES)/$(SQUEAK_BUILD).changes \
		$(APP_RES)/SqueakDebug.log
	cp $(IMAGE) $(APP_RES)/EPIC.image
	cp $(SQUEAK_DIR)/epic.changes $(APP_RES)/EPIC.changes
	cp -R epic-resources $(APP_RES)/
	mkdir -p $(APP_RES)/epic
	plutil -replace SqueakImageName -string EPIC.image $(APP_PLIST)
	plutil -replace CFBundleName -string EPIC $(APP_PLIST)
	plutil -replace CFBundleIdentifier -string org.hpi-swa.epic $(APP_PLIST)
	plutil -replace CFBundleGetInfoString -string EPIC $(APP_PLIST)
	@# macOS kills the VM if the edited bundle isn't re-signed
	xattr -cr $(APP_STAGE)
	codesign --force --deep --sign - $(APP_STAGE)
	cd $(APP_RES) && ../MacOS/Squeak -headless EPIC.image \
		$(CURDIR)/scripts/lockdown.st $(SCALE_PERCENT)
	@if test -f $(APP_RES)/lockdown-error.txt; then \
		cp $(APP_RES)/lockdown-error.txt $(SQUEAK_DIR)/; \
		cat $(SQUEAK_DIR)/lockdown-error.txt; rm -rf $(APP_STAGE); exit 1; \
	fi
	xattr -cr $(APP_STAGE)
	codesign --force --deep --sign - $(APP_STAGE)
	mkdir -p build
	ditto -c -k --keepParent $(APP_STAGE) build/EPIC.zip
	ditto $(APP_STAGE) $@


.PHONY: app
app: build/EPIC.app ## Build a locked-down stand-alone EPIC.app and EPIC.zip


.PHONY: clean
clean: ## Remove the built image and app (keeps the Squeak download)
	rm -rf $(IMAGE) $(SQUEAK_DIR)/epic.changes $(APP_STAGE) build
