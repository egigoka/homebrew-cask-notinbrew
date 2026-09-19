cask "pomodorough" do
  version "1.0,79ee09f720ccbcf90d713885c8d4977de88a58a6"
  sha256 "79b5040e707ca7556545d27ea3641c7831837f06676c2dc2f88d8fa8f904c677"

  url "https://github.com/Pomodoro-Everywhere/pomodorough-apple/archive/#{version.csv.second}.tar.gz?version=#{version.csv.first}"
  name "Pomodorough"
  desc "Pomodoro timer for Apple platforms"
  homepage "https://github.com/Pomodoro-Everywhere/pomodorough-apple"

  livecheck do
    url "https://api.github.com/repos/Pomodoro-Everywhere/pomodorough-apple/commits/main"
    strategy :json do |json|
      "1.0,#{json["sha"]}"
    end
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Pomodorough.app"

  preflight_steps do
    move "pomodorough-apple-*", "src", source_glob: true
    # Xcode shells out to `sandbox-exec` for Swift package work and nested
    # sandboxes are denied inside Homebrew's sandbox, so build with SwiftPM
    # directly (`--disable-sandbox`) and assemble the .app bundle by hand.
    run "/usr/bin/python3",
        network_access: true,
        writable_paths: [
          "~/Library/Caches/org.swift.swiftpm",
          "~/Library/Developer",
        ],
        args: [
          "-c", <<~'EOS',
            import io, json, os, plistlib, re, shutil, subprocess, sys, tarfile, time, urllib.request
            STAGED = sys.argv[1]
            SRC = os.path.join(STAGED, "src")
            SPM = os.path.join(STAGED, "spm")
            APP = os.path.join(STAGED, "Pomodorough.app")
            def run(*args, cwd=None):
                subprocess.run(args, cwd=cwd, check=True)
            def download(url, timeout=120, attempts=8):
                last = None
                for attempt in range(attempts):
                    try:
                        with urllib.request.urlopen(url, timeout=timeout) as r:
                            return r.read()
                    except Exception as e:
                        last = e
                        time.sleep(5 * (attempt + 1))
                raise last
            def yml_value(key):
                with open(os.path.join(SRC, "project.yml")) as f:
                    m = re.search(r'^ *%s: "?([^"\n]+)"?' % key, f.read(), re.M)
                assert m, key
                return m.group(1)
            MARKETING_VERSION = yml_value("MARKETING_VERSION")
            PROJECT_VERSION = yml_value("CURRENT_PROJECT_VERSION")
            GOOGLE_CLIENT_ID = yml_value("GOOGLE_CLIENT_ID")
            GOOGLE_REVERSED_CLIENT_ID = yml_value("GOOGLE_REVERSED_CLIENT_ID")
            resolved = json.load(open(os.path.join(
                SRC, "Pomodorough.xcodeproj", "project.xcworkspace",
                "xcshareddata", "swiftpm", "Package.resolved")))
            DIRECT = {
                "https://github.com/google/GoogleSignIn-iOS.git": ["GoogleSignIn", "GoogleSignInSwift"],
                "https://github.com/n0-computer/iroh-ffi": ["IrohLib"],
                "https://github.com/swiftwasm/WasmKit.git": ["WasmKit"],
                "https://github.com/getsentry/sentry-cocoa.git": ["Sentry"],
            }
            # dependency sources via tarballs (plain HTTPS, no git needed)
            shutil.rmtree(SPM, ignore_errors=True)
            pkgdir = os.path.join(SPM, "checkouts")
            os.makedirs(pkgdir)
            path_lines = []
            pkg_names = {}
            for url in DIRECT:
                base = url[:-4] if url.endswith(".git") else url
                dest = os.path.join(pkgdir, os.path.basename(base))
                for pin in resolved["pins"]:
                    if pin["location"] == url:
                        rev = pin["state"]["revision"]
                        break
                else:
                    raise ValueError("no pin for " + url)
                data = download(base + "/archive/" + rev + ".tar.gz")
                os.makedirs(dest)
                with tarfile.open(fileobj=io.BytesIO(data)) as t:
                    for m in t.getmembers():
                        parts = m.name.split("/", 1)
                        if len(parts) != 2:
                            continue
                        m.name = parts[1]
                        t.extract(m, dest)
                with open(os.path.join(dest, "Package.swift")) as f:
                    m = re.search(r'Package\(\s*name:\s*"([^"]+)"', f.read())
                assert m, "package name not found in " + dest
                pkg_names[url] = m.group(1)
                path_lines.append('        .package(name: "%s", path: "checkouts/%s")' % (m.group(1), os.path.basename(dest)))
            prod_lines = []
            for url, prods in DIRECT.items():
                for prod in prods:
                    prod_lines.append('            .product(name: "%s", package: "%s"),' % (prod, pkg_names[url]))
            tgt = os.path.join(SPM, "Sources", "Pomodorough")
            os.makedirs(tgt)
            for f in sorted(os.listdir(os.path.join(SRC, "Sources"))):
                s = os.path.join(SRC, "Sources", f)
                if os.path.isdir(s):
                    shutil.copytree(s, os.path.join(tgt, f))
                elif f.endswith(".swift"):
                    shutil.copy2(s, os.path.join(tgt, f))
            manifest = """// swift-tools-version: 6.0
            import PackageDescription
            let package = Package(
                name: "Pomodorough",
                platforms: [.macOS(.v15)],
                dependencies: [
            %s
                ],
                targets: [
                    .executableTarget(
                        name: "Pomodorough",
                        dependencies: [
            %s
                        ]
                    ),
                ]
            )
            """ % (",\n".join(path_lines), "\n".join(prod_lines))
            open(os.path.join(SPM, "Package.swift"), "w").write(manifest)
            run("swift", "build", "--disable-sandbox", "--configuration", "release",
                "--package-path", SPM)
            exe = os.path.join(SPM, ".build", "release", "Pomodorough")
            assert os.path.isfile(exe), "executable missing"
            macos = os.path.join(APP, "Contents", "MacOS")
            res = os.path.join(APP, "Contents", "Resources")
            shutil.rmtree(APP, ignore_errors=True)
            os.makedirs(macos)
            os.makedirs(res)
            shutil.copy2(exe, macos)
            os.chmod(os.path.join(macos, "Pomodorough"), 0o755)
            for f in sorted(os.listdir(os.path.join(SPM, ".build", "release"))):
                if f.endswith(".bundle"):
                    s = os.path.join(SPM, ".build", "release", f)
                    d = os.path.join(res, f)
                    if os.path.isdir(d):
                        shutil.rmtree(d)
                    if os.path.isdir(s):
                        shutil.copytree(s, d, symlinks=True)
                    else:
                        shutil.copy2(s, d)
            partial = os.path.join(STAGED, "asset-partial.plist")
            run("xcrun", "actool",
                "--output-format", "human-readable-text", "--notices", "--warnings",
                "--output-partial-info-plist", partial,
                "--app-icon", "AppIcon",
                "--platform", "macosx", "--minimum-deployment-target", "15.0",
                "--target-device", "mac",
                "--compile", res,
                os.path.join(SRC, "Resources", "Assets.xcassets"))
            def esc(s):
                return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")
            cat = json.load(open(os.path.join(SRC, "Resources", "Localizable.xcstrings")))
            en = os.path.join(res, "en.lproj")
            os.makedirs(en, exist_ok=True)
            strings = []
            sdict = {}
            for key, val in cat["strings"].items():
                loc = (val.get("localizations") or {}).get("en", {})
                if "stringUnit" in loc:
                    strings.append('"%s" = "%s";' % (esc(key), esc(loc["stringUnit"]["value"])))
                elif "variations" in loc:
                    plural = loc["variations"].get("plural", {})
                    entry = {"NSStringLocalizedFormatKey": "%#@VARIABLE@@"}
                    for form, fv in plural.items():
                        v = fv.get("stringUnit", {}).get("value", key)
                        entry["VARIABLE"] = entry.get("VARIABLE", {})
                        entry["VARIABLE"].setdefault("NSStringFormatSpecTypeKey", "NSStringPluralRuleType")
                        entry["VARIABLE"].setdefault("NSStringFormatValueTypeKey", "d")
                        entry["VARIABLE"][form] = v
                    sdict[key] = entry
                    strings.append('"%s" = "%s";' % (esc(key), esc(key)))
            open(os.path.join(en, "Localizable.strings"), "w").write("\n".join(strings) + "\n")
            if sdict:
                with open(os.path.join(en, "Localizable.stringsdict"), "wb") as f:
                    plistlib.dump(sdict, f)
            for f in ["CompletionChime.wav", "IROH_THIRD_PARTY_LICENSES.md"]:
                shutil.copy2(os.path.join(SRC, "Resources", f), res)
            shutil.copy2(os.path.join(SRC, "Resources", "SharedCore", "pomodorough_core.wasm"), res)
            with open(os.path.join(SRC, "Supporting", "macOS-Info.plist"), "rb") as f:
                info = plistlib.load(f)
            subs = {
                "$(DEVELOPMENT_LANGUAGE)": "en",
                "$(EXECUTABLE_NAME)": "Pomodorough",
                "$(PRODUCT_BUNDLE_IDENTIFIER)": "me.egigoka.pomodorough.mac",
                "$(PRODUCT_NAME)": "Pomodorough",
                "$(MARKETING_VERSION)": MARKETING_VERSION,
                "$(CURRENT_PROJECT_VERSION)": PROJECT_VERSION,
                "$(GOOGLE_CLIENT_ID)": GOOGLE_CLIENT_ID,
                "$(GOOGLE_REVERSED_CLIENT_ID)": GOOGLE_REVERSED_CLIENT_ID,
                "$(SENTRY_DSN)": "",
            }
            def sub(v):
                if isinstance(v, str):
                    for k, val in subs.items():
                        v = v.replace(k, val)
                    return v
                if isinstance(v, list):
                    return [sub(x) for x in v]
                if isinstance(v, dict):
                    return {sub(k): sub(x) for k, x in v.items()}
                return v
            info = sub(info)
            if os.path.isfile(partial):
                with open(partial, "rb") as f:
                    info.update(plistlib.load(f))
            with open(os.path.join(APP, "Contents", "Info.plist"), "wb") as f:
                plistlib.dump(info, f)
            run("/usr/bin/codesign", "--force", "--sign", "-",
                "--entitlements", os.path.join(SRC, "Pomodorough-macOS.entitlements"),
                APP)
          EOS
          "{{staged_path}}",
        ]
    remove ["src", "spm"], recursive: true
  end

  caveats <<~EOS
    Pomodorough is built from source during installation and requires Xcode 26.6 or newer.
  EOS
end
