load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//third_party:bazel.bzl", "bazel_sha256", "bazel_version")
load("//third_party:bazel_buildtools.bzl", "buildtools_sha256", "buildtools_version")
load("//third_party:bazel_skylib.bzl", "skylib_sha256", "skylib_version")

def forkla_repositories():
    RULES_JVM_EXTERNAL_TAG = "4.2"

    RULES_JVM_EXTERNAL_SHA = "cd1a77b7b02e8e008439ca76fd34f5b07aecb8c752961f9640dea15e9e5ba1ca"

    maybe(
        http_archive,
        name = "platforms",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/platforms/releases/download/0.0.8/platforms-0.0.8.tar.gz",
            "https://github.com/bazelbuild/platforms/releases/download/0.0.8/platforms-0.0.8.tar.gz",
        ],
        sha256 = "8150406605389ececb6da07cbcb509d5637a3ab9a24bc69b1101531367d89d74",
    )

    maybe(
        http_archive,
        name = "rules_jvm_external",
        sha256 = RULES_JVM_EXTERNAL_SHA,
        strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
        url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "io_bazel",
        sha256 = bazel_sha256,
        strip_prefix = "bazel-" + bazel_version,
        url = "https://github.com/bazelbuild/bazel/archive/" + bazel_version + ".zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    # Buildifier and friends:
    maybe(
        http_archive,
        name = "buildtools",
        sha256 = buildtools_sha256,
        strip_prefix = "buildtools-" + buildtools_version,
        url = "https://github.com/bazelbuild/buildtools/archive/" + buildtools_version + ".zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    # Additional bazel rules:
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = skylib_sha256,
        strip_prefix = "bazel-skylib-" + skylib_version,
        url = "https://github.com/bazelbuild/bazel-skylib/archive/" + skylib_version + ".zip",
    )

    EXPORT_WORKSPACE_IN_BUILD_FILE = [
        "test -f BUILD && chmod u+w BUILD || true",
        "echo >> BUILD",
        "echo 'exports_files([\"WORKSPACE\"], visibility = [\"//visibility:public\"])' >> BUILD",
    ]

    EXPORT_WORKSPACE_IN_BUILD_FILE_WIN = [
        "Add-Content -Path BUILD -Value \"`nexports_files([`\"WORKSPACE`\"], visibility = [`\"//visibility:public`\"])`n\" -Force",
    ]

    # Stuff used by Bazel Starlark syntax package transitively:
    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "com_google_protobuf",
        patch_args = ["-p1"],
        patches = ["@io_bazel//third_party/protobuf:21.7.patch"],
        patch_cmds = EXPORT_WORKSPACE_IN_BUILD_FILE,
        patch_cmds_win = EXPORT_WORKSPACE_IN_BUILD_FILE_WIN,
        sha256 = "22fdaf641b31655d4b2297f9981fa5203b2866f8332d3c6333f6b0107bb320de",
        strip_prefix = "protobuf-21.12",
        urls = [
            "https://mirror.bazel.build/github.com/protocolbuffers/protobuf/archive/v21.12.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v21.12.tar.gz",
        ],
    )

    # Stuff used by Buildifier transitively:
    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "dd926a88a564a9246713a9c00b35315f54cbd46b31a26d5d8fb264c07045f05d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
        ],
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_pkg",
        sha256 = "8f9ee2dc10c1ae514ee599a8b42ed99fa262b757058f65ad3c384289ff70c4b8",
        url = "https://github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_java",
        sha256 = "220b87d8cfabd22d1c6d8e3cdb4249abd4c93dcc152e0667db061fb1b957ee68",
        url = "https://github.com/bazelbuild/rules_java/releases/download/0.1.1/rules_java-0.1.1.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "e3b2cc2a9e81aad81a1978628fb8fe5d35cfd524c2ba7513d9439e042ea43d68",
        strip_prefix = "rules_python-36e8c81607c6fb6a194afd3dbf507cd899793c3a",
        url = "https://github.com/bazelbuild/rules_python/archive/36e8c81607c6fb6a194afd3dbf507cd899793c3a.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_cc",
        sha256 = "5f862a44bbd032e1b48ed53c9c211ba2a1da60e10c5baa01c97369c249299ecb",
        strip_prefix = "rules_cc-c8c38f8c710cbbf834283e4777916b68261b359c",
        url = "https://github.com/bazelbuild/rules_cc/archive/c8c38f8c710cbbf834283e4777916b68261b359c.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_license",
        sha256 = "00ccc0df21312c127ac4b12880ab0f9a26c1cff99442dc6c5a331750360de3c3",
        url = "https://mirror.bazel.build/github.com/bazelbuild/rules_license/releases/download/0.0.3/rules_license-0.0.3.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "8e17336df2b78e40b9287a19b4a890f84c563f405c7221060975198c8cfa3bdc",
        strip_prefix = "rules_proto-367e3b5757b9a6f9ee326a6e55da2013a5c65710",
        url = "https://github.com/bazelbuild/rules_proto/archive/367e3b5757b9a6f9ee326a6e55da2013a5c65710.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "d3fa66a39028e97d76f9e2db8f1b0c11c099e8e01bf363a923074784e451f809",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.33.0/bazel-gazelle-v0.33.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.33.0/bazel-gazelle-v0.33.0.tar.gz",
        ],
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "JCommander",
        sha256 = "f54f6c2fb67bb9efd2530a6a67279badd226d6f53c0f6aa360c5d23c596c12e8",
        urls = [
            "https://github.com/cbeust/jcommander/archive/d7ec08c66ee5569089161725f433c7e96ec9403b.zip",
        ],
        build_file = Label("//external/third_party:jcommander.BUILD"),
    )
