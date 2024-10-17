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
        sha256 = "8ff511a64fc46ee792d3fe49a5a1bcad6f7dc50dfbba5a28b0e5b979c17f9871",
        strip_prefix = "protobuf-25.2",
        urls = [
            "https://mirror.bazel.build/github.com/protocolbuffers/protobuf/archive/v25.2.tar.gz",
            "https://github.com/protocolbuffers/protobuf/archive/v25.2.tar.gz",
        ],
    )

    # Stuff used by Buildifier transitively:
    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "f74c98d6df55217a36859c74b460e774abc0410a47cc100d822be34d5f990f16",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.47.1/rules_go-v0.47.1.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.47.1/rules_go-v0.47.1.zip",
        ],
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_pkg",
        sha256 = "d250924a2ecc5176808fc4c25d5cf5e9e79e6346d79d5ab1c493e289e722d1d0",
        url = "https://github.com/bazelbuild/rules_pkg/releases/download/0.10.1/rules_pkg-0.10.1.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_java",
        sha256 = "a9690bc00c538246880d5c83c233e4deb83fe885f54c21bb445eb8116a180b83",
        url = "https://github.com/bazelbuild/rules_java/releases/download/7.12.2/rules_java-7.12.2.tar.gz",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "9d0610f87151527d0d8e8af51a91a91de036796e34339871c4dbc2f91bce92ae",
        strip_prefix = "rules_python-fbeb06090796d6f79b0617108fcf7b595d10ebbf",
        url = "https://github.com/bazelbuild/rules_python/archive/fbeb06090796d6f79b0617108fcf7b595d10ebbf.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "rules_cc",
        sha256 = "ad66eb77e008ff5a1bbfba68a43cb3cf079c2ea89d2b1f7fddabd6632ff6498d",
        strip_prefix = "rules_cc-833f17060cb7c68778e79f121172ed93b10ca46e",
        url = "https://github.com/bazelbuild/rules_cc/archive/833f17060cb7c68778e79f121172ed93b10ca46e.zip",
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
        sha256 = "3a2e8da2fbb25ba4b60cfedb0d12ed6dd6d8d6c1a303f91c9b5f731c645beaef",
        strip_prefix = "rules_proto-d4c3498677e7fbda6f717585276ea4d8b75acec0",
        url = "https://github.com/bazelbuild/rules_proto/archive/d4c3498677e7fbda6f717585276ea4d8b75acec0.zip",
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "32938bda16e6700063035479063d9d24c60eda8d79fd4739563f50d331cb3209",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.35.0/bazel-gazelle-v0.35.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.35.0/bazel-gazelle-v0.35.0.tar.gz",
        ],
    )

    # LICENSE: The Apache Software License, Version 2.0
    maybe(
        http_archive,
        name = "JCommander",
        sha256 = "dd6b43c78b5e470c05948dbca6bcfbe66b88cfe31ea3766185962fcd44d34672",
        urls = [
            "https://github.com/cbeust/jcommander/archive/d53cdce4b396398fea76968c4be8f2e209a151b1.zip",
        ],
        build_file = Label("//external/third_party:jcommander.BUILD"),
    )
