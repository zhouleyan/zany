DBG_MAKEFILE ?=
ifeq ($(DBG_MAKEFILE),1)
    $(warning ***** starting Makefile for goal(s) "$(MAKECMDGOALS)")
    $(warning ***** $(shell date))
else
    # If we're not debugging the Makefile, don't echo recipes.
    MAKEFLAGS += -s
endif

# It's necessary to set this because some environments don't link sh -> bash.
SHELL := /usr/bin/env bash -o errexit -o pipefail -o nounset

# Define variables so `make --warn-undefined-variables` works.
PRINT_HELP ?=

# We don't need make's built-in rules.
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

# Constants used throughout.
.EXPORT_ALL_VARIABLES:
OUT_DIR ?= _output

ifndef GOFLAGS
GOFLAGS :=
endif

define ALL_HELP_INFO
# Build code.
#
# Args:
#   WHAT: Directory names to build.  If any of these directories has a 'main'
#     package, the build will produce executable files under $(OUT_DIR)/bin.
#     If not specified, "everything" will be built.
#     "vendor/<module>/<path>" is accepted as alias for "<module>/<path>".
#     "ginkgo" is an alias for the ginkgo CLI.
#   GOFLAGS: Extra flags to pass to 'go' when building.
#   GOLDFLAGS: Extra linking flags passed to 'go' when building.
#   GOGCFLAGS: Additional go compile flags passed to 'go' when building.
#   DBG: If set to "1", build with optimizations disabled for easier
#     debugging.  Any other value is ignored.
#
# Example:
#   make
#   make all
#   make all WHAT=cmd/kubelet GOFLAGS=-v
#   make all DBG=1
#     Note: Specify DBG=1 for building unstripped binaries, which allows you to use code debugging
#           tools like delve. When DBG is unspecified, it defaults to "-s -w" which strips debug
#           information.
endef
.PHONY: all
ifeq ($(PRINT_HELP),y)
all:
	echo "$$ALL_HELP_INFO"
else
all:
	hack/make-rules/gobuild.sh $(WHAT)
endif
