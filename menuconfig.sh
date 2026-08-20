# SPDX-License-Identifier: GPL-2.0
#!/bin/bash

set -e

DEVICE_MODULES_DIR=$(basename $(dirname $0))
source "${DEVICE_MODULES_DIR}/kernel/kleaf/_setup_env.sh"

KLEAF_OUT=("--output_user_root=${OUT_DIR} --output_base=${OUT_DIR}/bazel/output_user_root/output_base")
KLEAF_ARGS=("${DEBUG_ARGS} ${SANDBOX_ARGS} \
	--noenable_bzlmod \
	--config=stamp \
	--//build/bazel_mgk_rules:kernel_version=${KERNEL_VERSION_NUM}")

CONFIG_TARGET="//${DEVICE_MODULES_DIR}:${KLEAF_SUPPORTED_PROJECTS}.${MODE}_config"

set -x
tools/bazel ${KLEAF_OUT} run ${KLEAF_ARGS} ${CONFIG_TARGET} -- "$@"
set +x
