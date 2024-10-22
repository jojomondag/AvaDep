Step 1:
dotnet publish -r osx-arm64 -c Release

Step 2:
chmod +x CUB.sh
./CUB.sh AvaDep

Step 3: Create the .app Bundle

mkdir -p MyApp.app/Contents/MacOS
mkdir -p MyApp.app/Contents/Resources

cp /Users/josef.nobach/Desktop/AvaDep/bin/Release/Universal/AvaDep MyApp.app/Contents/MacOS/
cp /Users/josef.nobach/Desktop/AvaDep/bin/Release/Universal/*.dll MyApp.app/Contents/MacOS/
cp /Users/josef.nobach/Desktop/AvaDep/bin/Release/Universal/*.dylib MyApp.app/Contents/MacOS/

Create an Info.plist file in the Contents directory.

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>AvaDep</string>
    <key>CFBundleExecutable</key>
    <string>AvaDep</string>
    <key>CFBundleIdentifier</key>
    <string>com.josefnobach.AvaDep</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string> <!-- Optional, only if you have an icon -->
    <key>LSMinimumSystemVersion</key>
    <string>10.13</string> <!-- Update if needed -->
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>

Step 4:
xcrun notarytool store-credentials "JosefNobach" --apple-id "josef.nobach@outlook.com" --password "kkjn-zzqi-bivy-ctqm" --team-id "PSXX49546D"

codesign --deep --force --verify --sign "Developer ID Application: Josef Nobach (PSXX49546D)" MyApp.app

entitlements.plist

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.cs.allow-jit</key>
    <true/>
    <key>com.apple.security.cs.allow-unsigned-executable-memory</key>
    <true/>
    <key>com.apple.security.cs.disable-library-validation</key>
    <true/>
</dict>
</plist>


codesign --deep --force --options runtime --entitlements MyApp.app/Contents/entitlements.plist --sign "Developer ID Application: Josef Nobach (PSXX49546D)" MyApp.app

Step 5:

ditto -c -k --keepParent MyApp.app MyApp.zip

Step 6:

xcrun notarytool submit MyApp.zip --wait --apple-id "josef.nobach@outlook.com" --password "kkjn-zzqi-bivy-ctqm" --team-id "PSXX49546D"


Step 7: Staple
xcrun stapler staple MyApp.app


chmod +x MyApp.app/Contents/MacOS/AvaDepa