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
        sha256 = "7beed9c511d632cff7c22ac0094dd7720e550153039d5da7e059bcceb488474a",
        strip_prefix = "protobuf-25.0",
        urls = [
            "https://mirror.bazel.build/github.com/protocolbuffers/protobuf/archive/v25.0.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v25.0.tar.gz",
        ],
    )

    # Stuff used by Buildifier transitively:
    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "91585017debb61982f7054c9688857a2ad1fd823fc3f9cb05048b0025c47d023",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
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
        sha256 = "e81e9deaae0d9d99ef3dd5f6c1b32338447fe16d5564155531ea4eb7ef38854b",
        url = "https://github.com/bazelbuild/rules_java/releases/download/7.0.6/rules_java-7.0.6.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "b5f106ca596f2b0554c2faec7260c0a16359be930be8e85af738af2441338098",
        strip_prefix = "rules_python-3eebda1a602c083442a4c70eb1ca626b7db466f9",
        url = "https://github.com/bazelbuild/rules_python/archive/3eebda1a602c083442a4c70eb1ca626b7db466f9.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_cc",
        sha256 = "0d060bbfe3446804ca668a807522712fb460200d4eaefb41b4137bf9fbdf3f93",
        strip_prefix = "rules_cc-51b77439a109b8c8f75ad70a130293291ed8b851",
        url = "https://github.com/bazelbuild/rules_cc/archive/51b77439a109b8c8f75ad70a130293291ed8b851.zip",
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
        sha256 = "fdee402598331f361628f5539d776c1ab5e2a2efbd46cd4172df4637a4d3b4ef",
        strip_prefix = "rules_proto-7188888362a203892dec354f52623f9970bff48c",
        url = "https://github.com/bazelbuild/rules_proto/archive/7188888362a203892dec354f52623f9970bff48c.zip",
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
