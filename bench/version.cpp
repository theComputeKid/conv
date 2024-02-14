#include <conv.h>
#include <gtest/gtest.h>
#include <nanobench.h>
#include <string>

namespace {
	auto getBenchName(auto const i) -> std::string {
		std::string const ts = i->current_test_info()->test_suite_name();
		std::string const t = i->current_test_info()->name();
		return ts + ":" + t;
	}
} // namespace

TEST(version, major) {
	auto const n = getBenchName(::testing::UnitTest::GetInstance());
	ankerl::nanobench::Bench().run(n, [&] {
		auto v = convVersionMajor();
		ankerl::nanobench::doNotOptimizeAway(v);
	});
}

TEST(version, minor) {
	auto const n = getBenchName(::testing::UnitTest::GetInstance());
	ankerl::nanobench::Bench().run(n, [&] {
		auto v = convVersionMinor();
		ankerl::nanobench::doNotOptimizeAway(v);
	});
}

TEST(version, patch) {
	auto const n = getBenchName(::testing::UnitTest::GetInstance());
	ankerl::nanobench::Bench().run(n, [&] {
		auto v = convVersionPatch();
		ankerl::nanobench::doNotOptimizeAway(v);
	});
}
