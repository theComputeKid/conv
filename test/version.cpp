/**
 * @brief Tests for checking the version functions.
 *
 * @copyright Copyright (c) 2023 theComputeKid
 */
#include <conv.h>
#include <gtest/gtest.h>

TEST(version, major) {
	auto const version = convVersionMajor();
	EXPECT_EQ(version, CONV_VERSION_MAJOR);
}

TEST(version, minor) {
	auto const version = convVersionMinor();
	EXPECT_EQ(version, CONV_VERSION_MINOR);
}

TEST(version, patch) {
	auto const version = convVersionPatch();
	EXPECT_EQ(version, CONV_VERSION_PATCH);
}
