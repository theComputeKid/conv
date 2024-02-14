/**
 * @brief Information about the build version.
 *
 * @copyright Copyright (c) 2023-2024 theComputeKid
 */
#include "conv.h"

// Ensure the version is provided by the build system.
#ifndef CONV_VERSION_MAJOR
#	error Project major version not defined.
#endif

#ifndef CONV_VERSION_MINOR
#	error Project minor version not defined.
#endif

#ifndef CONV_VERSION_PATCH
#	error Project patch version not defined.
#endif

int convVersionMajor(void) {
	return CONV_VERSION_MAJOR;
}

int convVersionMinor(void) {
	return CONV_VERSION_MINOR;
}

int convVersionPatch(void) {
	return CONV_VERSION_PATCH;
}
