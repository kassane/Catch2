const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const tests = b.option(bool, "Tests", "Build tests [default: false]") orelse false;
    const shared = b.option(bool, "Shared", "Build the Shared Library [default: false]") orelse false;

    const lib = if (shared) b.addStaticLibrary(.{
        .name = "Catch2",
        .target = target,
        .optimize = optimize,
    }) else b.addSharedLibrary(.{
        .name = "Catch2",
        .target = target,
        .optimize = optimize,
        .version = .{
            .major = 3,
            .minor = 4,
            .patch = 0,
        },
    });
    const config = b.addConfigHeader(.{
        .style = .blank,
        .include_path = "catch2/catch_user_config.hpp",
    }, .{
        .CATCH_CONFIG_DEFAULT_REPORTER = "console",
        .CATCH_CONFIG_CONSOLE_WIDTH = 80,
        .CATCH_CONFIG_SHARED_LIBRARY = if (lib.linkage.? == .dynamic) {} else null,
        .CATCH_CONFIG_RUNTIME_STATIC_REQUIRE = {}, // void == def without value
        // .CATCH_PLATFORM_WINDOWS = if (target.isWindows()) {} else null,
        .CATCH_CONFIG_ANDROID_LOGWRITE = null,
        .CATCH_CONFIG_BAZEL_SUPPORT = null,
        .CATCH_CONFIG_COLOUR_WIN32 = null,
        .CATCH_CONFIG_COUNTER = {},
        .CATCH_CONFIG_CPP11_TO_STRING = null, // null == undef
        .CATCH_CONFIG_CPP17_BYTE = null,
        .CATCH_CONFIG_CPP17_OPTIONAL = null,
        .CATCH_CONFIG_CPP17_STRING_VIEW = null,
        .CATCH_CONFIG_CPP17_UNCAUGHT_EXCEPTIONS = null,
        .CATCH_CONFIG_CPP17_VARIANT = null,
        .CATCH_CONFIG_DISABLE_EXCEPTIONS_CUSTOM_HANDLER = null,
        .CATCH_CONFIG_DISABLE_EXCEPTIONS = null,
        .CATCH_CONFIG_DISABLE_STRINGIFICATION = null,
        .CATCH_CONFIG_DISABLE = null,
        .CATCH_CONFIG_ENABLE_ALL_STRINGMAKERS = null,
        .CATCH_CONFIG_ENABLE_OPTIONAL_STRINGMAKER = null,
        .CATCH_CONFIG_ENABLE_PAIR_STRINGMAKER = null,
        .CATCH_CONFIG_ENABLE_TUPLE_STRINGMAKER = null,
        .CATCH_CONFIG_ENABLE_VARIANT_STRINGMAKER = null,
        .CATCH_CONFIG_EXPERIMENTAL_REDIRECT = null,
        .CATCH_CONFIG_FALLBACK_STRINGIFIER = null,
        .CATCH_CONFIG_FAST_COMPILE = null,
        .CATCH_CONFIG_GETENV = null,
        .CATCH_CONFIG_GLOBAL_NEXTAFTER = null,
        .CATCH_CONFIG_NO_ANDROID_LOGWRITE = null,
        .CATCH_CONFIG_NO_COLOUR_WIN32 = null,
        .CATCH_CONFIG_NO_COUNTER = null,
        .CATCH_CONFIG_NO_CPP11_TO_STRING = null,
        .CATCH_CONFIG_NO_CPP17_BYTE = null,
        .CATCH_CONFIG_NO_CPP17_OPTIONAL = null,
        .CATCH_CONFIG_NO_CPP17_STRING_VIEW = null,
        .CATCH_CONFIG_NO_CPP17_UNCAUGHT_EXCEPTIONS = null,
        .CATCH_CONFIG_NO_CPP17_VARIANT = null,
        .CATCH_CONFIG_NO_GETENV = null,
        .CATCH_CONFIG_NO_GLOBAL_NEXTAFTER = null,
        .CATCH_CONFIG_NO_POSIX_SIGNALS = null,
        .CATCH_CONFIG_NO_USE_ASYNC = null,
        .CATCH_CONFIG_NO_WCHAR = null,
        .CATCH_CONFIG_NO_WINDOWS_SEH = null,
        .CATCH_CONFIG_NOSTDOUT = null,
        .CATCH_CONFIG_POSIX_SIGNALS = null,
        .CATCH_CONFIG_PREFIX_ALL = null,
        .CATCH_CONFIG_USE_ASYNC = null,
        .CATCH_CONFIG_WCHAR = null,
        .CATCH_CONFIG_WINDOWS_CRTDBG = null,
        .CATCH_CONFIG_WINDOWS_SEH = null,
    });
    lib.addConfigHeader(config);
    lib.addIncludePath(config.include_path);
    lib.addIncludePath("src");
    lib.addCSourceFiles(&.{
        "src/catch2/benchmark/catch_chronometer.cpp",
        "src/catch2/benchmark/detail/catch_benchmark_function.cpp",
        "src/catch2/benchmark/detail/catch_run_for_at_least.cpp",
        "src/catch2/benchmark/detail/catch_stats.cpp",
        "src/catch2/catch_approx.cpp",
        "src/catch2/catch_assertion_result.cpp",
        "src/catch2/catch_config.cpp",
        "src/catch2/catch_get_random_seed.cpp",
        "src/catch2/catch_message.cpp",
        "src/catch2/catch_registry_hub.cpp",
        "src/catch2/catch_session.cpp",
        "src/catch2/catch_tag_alias_autoregistrar.cpp",
        "src/catch2/catch_test_case_info.cpp",
        "src/catch2/catch_test_spec.cpp",
        "src/catch2/catch_timer.cpp",
        "src/catch2/catch_tostring.cpp",
        "src/catch2/catch_totals.cpp",
        "src/catch2/catch_translate_exception.cpp",
        "src/catch2/catch_version.cpp",
        "src/catch2/generators/catch_generator_exception.cpp",
        "src/catch2/generators/catch_generators.cpp",
        "src/catch2/generators/catch_generators_random.cpp",
        "src/catch2/interfaces/catch_interfaces_capture.cpp",
        "src/catch2/interfaces/catch_interfaces_config.cpp",
        "src/catch2/interfaces/catch_interfaces_exception.cpp",
        "src/catch2/interfaces/catch_interfaces_generatortracker.cpp",
        "src/catch2/interfaces/catch_interfaces_registry_hub.cpp",
        "src/catch2/interfaces/catch_interfaces_reporter.cpp",
        "src/catch2/interfaces/catch_interfaces_reporter_factory.cpp",
        "src/catch2/interfaces/catch_interfaces_testcase.cpp",
        "src/catch2/internal/catch_assertion_handler.cpp",
        "src/catch2/internal/catch_case_insensitive_comparisons.cpp",
        "src/catch2/internal/catch_clara.cpp",
        "src/catch2/internal/catch_commandline.cpp",
        "src/catch2/internal/catch_console_colour.cpp",
        "src/catch2/internal/catch_context.cpp",
        "src/catch2/internal/catch_debug_console.cpp",
        "src/catch2/internal/catch_debugger.cpp",
        "src/catch2/internal/catch_decomposer.cpp",
        "src/catch2/internal/catch_enforce.cpp",
        "src/catch2/internal/catch_enum_values_registry.cpp",
        "src/catch2/internal/catch_errno_guard.cpp",
        "src/catch2/internal/catch_exception_translator_registry.cpp",
        "src/catch2/internal/catch_fatal_condition_handler.cpp",
        "src/catch2/internal/catch_floating_point_helpers.cpp",
        "src/catch2/internal/catch_getenv.cpp",
        "src/catch2/internal/catch_istream.cpp",
        "src/catch2/internal/catch_lazy_expr.cpp",
        "src/catch2/internal/catch_leak_detector.cpp",
        "src/catch2/internal/catch_list.cpp",
        "src/catch2/internal/catch_main.cpp",
        "src/catch2/internal/catch_message_info.cpp",
        "src/catch2/internal/catch_output_redirect.cpp",
        "src/catch2/internal/catch_parse_numbers.cpp",
        "src/catch2/internal/catch_polyfills.cpp",
        "src/catch2/internal/catch_random_number_generator.cpp",
        "src/catch2/internal/catch_random_seed_generation.cpp",
        "src/catch2/internal/catch_reporter_registry.cpp",
        "src/catch2/internal/catch_reporter_spec_parser.cpp",
        "src/catch2/internal/catch_result_type.cpp",
        "src/catch2/internal/catch_reusable_string_stream.cpp",
        "src/catch2/internal/catch_run_context.cpp",
        "src/catch2/internal/catch_section.cpp",
        "src/catch2/internal/catch_singletons.cpp",
        "src/catch2/internal/catch_source_line_info.cpp",
        "src/catch2/internal/catch_startup_exception_registry.cpp",
        "src/catch2/internal/catch_stdstreams.cpp",
        "src/catch2/internal/catch_string_manip.cpp",
        "src/catch2/internal/catch_stringref.cpp",
        "src/catch2/internal/catch_tag_alias_registry.cpp",
        "src/catch2/internal/catch_test_case_info_hasher.cpp",
        "src/catch2/internal/catch_test_case_registry_impl.cpp",
        "src/catch2/internal/catch_test_case_tracker.cpp",
        "src/catch2/internal/catch_test_failure_exception.cpp",
        "src/catch2/internal/catch_test_registry.cpp",
        "src/catch2/internal/catch_test_spec_parser.cpp",
        "src/catch2/internal/catch_textflow.cpp",
        "src/catch2/internal/catch_uncaught_exceptions.cpp",
        "src/catch2/internal/catch_wildcard_pattern.cpp",
        "src/catch2/internal/catch_xmlwriter.cpp",
        "src/catch2/matchers/catch_matchers.cpp",
        "src/catch2/matchers/catch_matchers_container_properties.cpp",
        "src/catch2/matchers/catch_matchers_exception.cpp",
        "src/catch2/matchers/catch_matchers_floating_point.cpp",
        "src/catch2/matchers/catch_matchers_predicate.cpp",
        "src/catch2/matchers/catch_matchers_quantifiers.cpp",
        "src/catch2/matchers/catch_matchers_string.cpp",
        "src/catch2/matchers/catch_matchers_templated.cpp",
        "src/catch2/matchers/internal/catch_matchers_impl.cpp",
        "src/catch2/reporters/catch_reporter_automake.cpp",
        "src/catch2/reporters/catch_reporter_common_base.cpp",
        "src/catch2/reporters/catch_reporter_compact.cpp",
        "src/catch2/reporters/catch_reporter_console.cpp",
        "src/catch2/reporters/catch_reporter_cumulative_base.cpp",
        "src/catch2/reporters/catch_reporter_event_listener.cpp",
        "src/catch2/reporters/catch_reporter_helpers.cpp",
        "src/catch2/reporters/catch_reporter_junit.cpp",
        "src/catch2/reporters/catch_reporter_multi.cpp",
        "src/catch2/reporters/catch_reporter_registrars.cpp",
        "src/catch2/reporters/catch_reporter_sonarqube.cpp",
        "src/catch2/reporters/catch_reporter_streaming_base.cpp",
        "src/catch2/reporters/catch_reporter_tap.cpp",
        "src/catch2/reporters/catch_reporter_teamcity.cpp",
        "src/catch2/reporters/catch_reporter_xml.cpp",
    }, cxxFlags);
    lib.linkLibCpp();
    switch (optimize) {
        .Debug, .ReleaseSafe => lib.bundle_compiler_rt = true,
        else => lib.strip = true,
    }
    lib.installHeadersDirectoryOptions(.{
        .source_dir = .{ .path = "src" },
        .install_dir = .header,
        .install_subdir = "",
        .exclude_extensions = &.{
            "cpp",
            "txt",
            "build",
        },
    });
    b.installArtifact(lib);

    if (tests) {
        if (target.isWindows())
            return error.SkipZigTest catch {};
        buildTest(b, .{
            .lib = lib,
            .path = "examples/010-TestCase.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/020-TestCase-1.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/020-TestCase-2.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/030-Asn-Require-Check.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/100-Fix-Section.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/110-Fix-ClassFixture.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/120-Bdd-ScenarioGivenWhenThen.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/210-Evt-EventListeners.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/300-Gen-OwnGenerator.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/301-Gen-MapTypeConversion.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/302-Gen-Table.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/310-Gen-VariablesInGenerators.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "examples/311-Gen-CustomCapture.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "tests/ExtraTests/X03-DisabledExceptions-DefaultHandler.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "tests/ExtraTests/X04-DisabledExceptions-CustomHandler.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "tests/ExtraTests/X05-DeferredStaticChecks.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "tests/ExtraTests/X10-FallbackStringifier.cpp",
        });
        buildTest(b, .{
            .lib = lib,
            .path = "tests/ExtraTests/X11-DisableStringification.cpp",
        });
    }
}

fn buildTest(b: *std.Build, info: BuildInfo) void {
    const test_exe = b.addExecutable(.{
        .name = info.filename(),
        .optimize = info.lib.optimize,
        .target = info.lib.target,
    });
    for (info.lib.include_dirs.items) |include_dir| {
        test_exe.include_dirs.append(include_dir) catch @panic("Includes append error!");
    }
    if (test_exe.target.isWindows()) {
        test_exe.subsystem = .Console;
        test_exe.defineCMacro("_UNICODE", null);
        test_exe.defineCMacro("DO_NOT_USE_WMAIN", null);
    }
    test_exe.addIncludePath("third_party");
    test_exe.addCSourceFile(info.path, cxxFlags);
    test_exe.linkLibCpp();
    test_exe.linkLibrary(info.lib);
    b.installArtifact(test_exe);

    const run_cmd = b.addRunArtifact(test_exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step(
        b.fmt("{s}", .{info.filename()}),
        b.fmt("Run the {s} test", .{info.filename()}),
    );
    run_step.dependOn(&run_cmd.step);
}

const cxxFlags: []const []const u8 = &.{
    "-Wall",
    "-Wextra",
};

const BuildInfo = struct {
    lib: *std.Build.Step.Compile,
    path: []const u8,

    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.split(u8, std.fs.path.basename(self.path), ".");
        return split.first();
    }
};
