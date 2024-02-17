DEPEND =
VOC = /opt/voc/bin/voc
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

ifndef BUILD
BUILD := $(mkfile_dir_path)/build
endif

DPS := deps
DEPS_PATH := $(mkfile_dir_path)/$(DPS)

# Targets for dependency management
.PHONY: all get_deps build_deps build_this clean

all: get_deps build_deps build_this

get_deps:
		@echo "Fetching and updating dependencies..."
		@mkdir -p $(DEPS_PATH)
		@for dep in $(DEPEND); do \
				dep_dir="$(DEPS_PATH)/$$dep"; \
				if [ ! -d "$$dep_dir" ]; then \
					git clone "https://$$dep.git" "$$dep_dir"; \
				else \
					(cd "$$dep_dir" && git pull); \
				fi; \
		done

build_deps:
		@echo "Building dependencies..."
		@mkdir -p $(BUILD)
		@for dep in $(DEPEND); do \
				dep_dir="$(DEPS_PATH)/$$dep"; \
				if [ -f "$$dep_dir/GNUmakefile" ] || [ -f "$$dep_dir/Makefile" ]; then \
						$(MAKE) -C "$$dep_dir" -f "$${dep_dir}/GNUmakefile" BUILD=$(BUILD) || \
						$(MAKE) -C "$$dep_dir" -f "$${dep_dir}/Makefile" BUILD=$(BUILD); \
				fi; \
		done

build_this:
		@echo "Building this project..."
		cd $(BUILD) && $(VOC) -s $(mkfile_dir_path)/src/time.Mod

tests:
		cd $(BUILD) && $(VOC) $(mkfile_dir_path)/test/testStrUtils.Mod -m
clean:
		@echo "Cleaning build directory..."
		@rm -rf $(BUILD)

