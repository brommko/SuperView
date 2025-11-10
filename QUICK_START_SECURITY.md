# SuperView Security Quick Start Guide

**Quick checklist for developers using SuperView SDK**

---

## 🚀 30-Minute Security Setup

### Step 1: Protect Your Credentials (5 minutes)

#### Create Configuration File Template
```bash
# In your project root
cp Sources/Config.plist Sources/Config.plist.example

# Add actual config to .gitignore
echo "Sources/Config.plist" >> .gitignore
echo "Sources/GoogleService-Info.plist" >> .gitignore
echo "*.xcconfig" >> .gitignore
```

#### Update Config.plist with Production Values
```xml
<!-- Sources/Config.plist -->
<key>oneSignal</key>
<dict>
    <key>appId</key>
    <string>YOUR_ONESIGNAL_APP_ID</string>
    <key>restApiKey</key>
    <string>YOUR_ONESIGNAL_REST_API_KEY</string>
</dict>

<key>adMob</key>
<dict>
    <key>appId</key>
    <string>ca-app-pub-XXXXXXXXXXXXX~YYYYYYYYYY</string>
    <key>bannerUnitID</key>
    <string>ca-app-pub-XXXXXXXXXXXXX/YYYYYYYYYY</string>
</dict>
```

---

### Step 2: Configure App Transport Security (10 minutes)

#### Option A: Enable ATS with Exceptions (Recommended)

**If you know your web domain supports HTTPS:**
```xml
<!-- Sources/Info.plist -->
<!-- Remove or comment out the current NSAppTransportSecurity section -->

<!-- Add this ONLY if you need specific HTTP exceptions -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>your-domain.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSIncludesSubdomains</key>
            <true/>
        </dict>
    </dict>
</dict>
```

#### Option B: Remove ATS Exceptions Entirely

**If your website uses HTTPS:**
```xml
<!-- Sources/Info.plist -->
<!-- Delete the entire NSAppTransportSecurity section -->
```

---

### Step 3: Update Privacy Descriptions (10 minutes)

```xml
<!-- Sources/Info.plist -->
<!-- Update each permission with YOUR app's actual use case -->

<key>NSCameraUsageDescription</key>
<string>[Your App Name] uses your camera to [specific feature]</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>[Your App Name] uses your location to [specific feature]</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>[Your App Name] needs access to your photos to [specific feature]</string>

<!-- DELETE permissions you don't use -->
```

**Delete unused permissions:**
- If you don't use camera, delete `NSCameraUsageDescription`
- If you don't use location, delete all location keys
- If you don't use microphone, delete `NSMicrophoneUsageDescription`

---

### Step 4: Update Bundle Identifier (3 minutes)

```yaml
# project.yml
PRODUCT_BUNDLE_IDENTIFIER: com.yourcompany.yourapp
```

**Also update in:**
- `NotificationService/NotificationService.entitlements`
- Apple Developer Portal
- Firebase Console
- OneSignal Dashboard

---

### Step 5: Remove Development Team ID from Git (2 minutes)

```yaml
# project.yml - Remove this line:
DEVELOPMENT_TEAM: 56XX2LQCB2
```

**Create local configuration:**
```bash
# Create Config.xcconfig (add to .gitignore)
cat > Config.xcconfig << 'EOF'
DEVELOPMENT_TEAM = YOUR_TEAM_ID_HERE
CODE_SIGN_IDENTITY = iPhone Developer
EOF

# Add to .gitignore
echo "Config.xcconfig" >> .gitignore
```

---

## 📋 Pre-Production Checklist

### Security Must-Haves
- [ ] ATS is configured (not completely disabled)
- [ ] All API keys are in protected config files (not in git)
- [ ] Bundle identifier is changed from default
- [ ] Privacy descriptions match your actual app features
- [ ] Test AdMob ID replaced with production ID
- [ ] Development team ID removed from project.yml
- [ ] GoogleService-Info.plist has production values

### Configuration Verification
```bash
# Check your git status - these should NOT appear:
git status | grep -E "(Config.plist|GoogleService-Info.plist|Config.xcconfig)"

# If they appear, add to .gitignore:
git rm --cached Sources/Config.plist
git rm --cached Sources/GoogleService-Info.plist
```

### Testing
```bash
# Build and test
xcodegen
bundle exec pod install
xcodebuild -workspace App.xcworkspace -scheme App build

# Check for common security issues
grep -r "ca-app-pub-3940256099942544" Sources/
# Should return nothing (test ID should be replaced)

grep -r "NSAllowsArbitraryLoads" Sources/Info.plist
# Should either not exist or be set to false
```

---

## 🔐 Production Deployment Checklist

### Before Submitting to App Store

#### 1. API Keys & Credentials
- [ ] All test API keys replaced with production
- [ ] OneSignal App ID is for production project
- [ ] AdMob uses production app ID and ad unit IDs
- [ ] Firebase GoogleService-Info.plist is for production
- [ ] In-app purchase product IDs are registered in App Store Connect

#### 2. Security Settings
- [ ] ATS exceptions documented and justified
- [ ] HTTPS is used for all network requests
- [ ] Certificate pinning configured (if required)
- [ ] Keychain used for sensitive data (not UserDefaults)

#### 3. Privacy & Compliance
- [ ] Privacy Policy URL added to App Store Connect
- [ ] Privacy Nutrition Labels completed accurately
- [ ] All tracking disclosures made
- [ ] GDPR compliance verified (if applicable)
- [ ] Age rating set appropriately

#### 4. Build Configuration
```bash
# Verify release configuration
xcodebuild -showBuildSettings -workspace App.xcworkspace -scheme App -configuration Release | grep -E "(ENABLE_BITCODE|CODE_SIGN_IDENTITY|DEVELOPMENT_TEAM)"

# Should show:
# ENABLE_BITCODE = YES (or NO if intentional)
# CODE_SIGN_IDENTITY = iPhone Distribution
# DEVELOPMENT_TEAM = YOUR_TEAM_ID
```

#### 5. Archive Preparation
```bash
# Clean build folder
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Create fresh build
xcodegen
bundle exec pod install

# Archive for distribution
xcodebuild -workspace App.xcworkspace \
  -scheme App \
  -configuration Release \
  -archivePath ./build/App.xcarchive \
  archive
```

---

## 🛠️ Common Configuration Issues

### Issue: "NSAllowsArbitraryLoads must be disabled"

**Solution:**
```xml
<!-- Sources/Info.plist -->
<!-- Change from: -->
<key>NSAllowsArbitraryLoads</key>
<true/>

<!-- To: -->
<key>NSAllowsArbitraryLoads</key>
<false/>
```

---

### Issue: "Missing or invalid GoogleService-Info.plist"

**Solution:**
1. Download from Firebase Console
2. Replace `Sources/GoogleService-Info.plist`
3. Ensure bundle ID matches project

```bash
# Verify bundle ID in Firebase config
grep -A1 "BUNDLE_ID" Sources/GoogleService-Info.plist
```

---

### Issue: "Ads not showing in production"

**Solution:**
Replace test AdMob IDs:

```xml
<!-- Sources/Info.plist -->
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXX~YYYYYYYYYY</string>
<!-- NOT: ca-app-pub-3940256099942544~1458002511 -->
```

```xml
<!-- Sources/Config.plist -->
<key>adMob</key>
<dict>
    <key>bannerUnitID</key>
    <string>ca-app-pub-XXXXXXXXXXXXX/YYYYYYYYYY</string>
    <!-- NOT: ca-app-pub-3940256099942544/XXXXXXXX -->
</dict>
```

---

### Issue: "Push notifications not working"

**Checklist:**
1. OneSignal App ID correct in `Config.plist`
2. Bundle ID matches in Apple Developer Portal
3. Push notification certificate configured in OneSignal
4. Capabilities enabled in Xcode:
   - Push Notifications
   - Background Modes → Remote notifications

```bash
# Verify in project
grep -A3 "UIBackgroundModes" Sources/Info.plist
# Should include: remote-notification
```

---

## 🧪 Security Testing

### Quick Security Test (5 minutes)

```bash
# 1. Check for hardcoded secrets
grep -r "sk_live" . --exclude-dir={Pods,build,Frameworks}
grep -r "api_key" . --exclude-dir={Pods,build,Frameworks}

# 2. Verify HTTPS enforcement
grep -r "http://" Sources/ --exclude-dir={Pods,build}
# Review each HTTP URL - should be HTTPS when possible

# 3. Check Info.plist security
plutil -lint Sources/Info.plist
```

### Network Security Test

```bash
# Install Charles Proxy or use built-in tools
# Run app and verify:
# 1. All network calls use HTTPS
# 2. No sensitive data in URLs/headers
# 3. Certificate validation works
```

---

## 📚 Quick Reference

### Essential Files to Configure

| File | Purpose | Needs Update |
|------|---------|--------------|
| `Sources/Config.plist` | App configuration, API keys | ✅ Yes |
| `Sources/Info.plist` | App metadata, permissions | ✅ Yes |
| `Sources/GoogleService-Info.plist` | Firebase config | ✅ Yes |
| `project.yml` | Build settings | ✅ Yes |
| `.gitignore` | Protect sensitive files | ✅ Yes |

### Environment Variables Reference

```bash
# Set these before building
export DEVELOPMENT_TEAM="YOUR_TEAM_ID"
export PRODUCT_BUNDLE_IDENTIFIER="com.yourcompany.yourapp"
export ONESIGNAL_APP_ID="your-onesignal-id"
export ADMOB_APP_ID="ca-app-pub-xxxxx~yyyyy"
```

---

## 🆘 Support

### If You Need Help

1. **Review Full Documentation:**
   - `CODE_REVIEW.md` - Comprehensive code review
   - `SECURITY_FINDINGS.md` - Detailed security analysis

2. **Common Issues:**
   - Check GitHub Issues
   - Review Apple Developer Forums
   - Check third-party SDK documentation

3. **Security Concerns:**
   - Don't commit sensitive data
   - Report vulnerabilities privately
   - Follow responsible disclosure

---

## ✅ Final Verification

Before release, run this script:

```bash
#!/bin/bash
echo "🔍 SuperView Security Pre-flight Check"

# Check 1: ATS
if grep -q "NSAllowsArbitraryLoads.*true" Sources/Info.plist; then
    echo "⚠️  ATS is disabled - review required"
else
    echo "✅ ATS configuration OK"
fi

# Check 2: Test IDs
if grep -q "ca-app-pub-3940256099942544" Sources/; then
    echo "❌ Test AdMob ID detected - replace with production"
else
    echo "✅ No test AdMob IDs found"
fi

# Check 3: Bundle ID
if grep -q "com.bommko.UniversalWebView" project.yml; then
    echo "❌ Default bundle ID detected - change required"
else
    echo "✅ Bundle ID customized"
fi

# Check 4: Sensitive files in git
if git ls-files | grep -E "(Config.plist|GoogleService-Info.plist)"; then
    echo "⚠️  Sensitive config files in git - should be ignored"
else
    echo "✅ Sensitive files protected"
fi

echo "
🎉 Pre-flight check complete
"
```

Save as `security-check.sh` and run before each release.

---

**Remember:** Security is not a one-time setup. Review and update regularly!

**Last Updated:** 2025-11-10
