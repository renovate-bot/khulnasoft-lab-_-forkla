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
        sha256 = "9bd87b8280ef720d3240514f884e56a712f2218f0d693b48050c836028940a42",
        strip_prefix = "protobuf-25.1",
        urls = [
            "https://mirror.bazel.build/github.com/protocolbuffers/protobuf/archive/v25.1.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v25.1.tar.gz",
        ],
    )

    # Stuff used by Buildifier transitively:
    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "c8035e8ae248b56040a65ad3f0b7434712e2037e5dfdcebfe97576e620422709",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.44.0/rules_go-v0.44.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.44.0/rules_go-v0.44.0.zip",
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
        sha256 = "4018e97c93f97680f1650ffd2a7530245b864ac543fd24fae8c02ba447cb2864",
        url = "https://github.com/bazelbuild/rules_java/releases/download/7.3.1/rules_java-7.3.1.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "6538de5cc53911dd509828ca592f78fac65b61bdffe8bde404e7aea4f2170af4",
        strip_prefix = "rules_python-94c89e6ed247e30cb86b469ffaf43f6ffc0b2365",
        url = "https://github.com/bazelbuild/rules_python/archive/94c89e6ed247e30cb86b469ffaf43f6ffc0b2365.zip",
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
        sha256 = "be4e49498069703739b3f2120cd9327809de8e0071dc5d33a24dc9bcfd9f11a0",
        strip_prefix = "rules_proto-f9b0b880d1e10e18daeeb168cef9d0f8316fdcb5",
        url = "https://github.com/bazelbuild/rules_proto/archive/f9b0b880d1e10e18daeeb168cef9d0f8316fdcb5.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "b7387f72efb59f876e4daae42f1d3912d0d45563eac7cb23d1de0b094ab588cf",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.34.0/bazel-gazelle-v0.34.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.34.0/bazel-gazelle-v0.34.0.tar.gz",
        ],
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "JCommander",
        sha256 = "4176cf69846751cd3f9682cb1ea7b6f1e9691239daa9b48bb02d15bb9543833f",
        urls = [
            "https://github.com/cbeust/jcommander/archive/bee2d3920630c281b89d471e9428e0ab0c923e02.zip",
        ],
        build_file = Label("//external/third_party:jcommander.BUILD"),
    )
