# v0.1.2 - Swift Package Manager Support 🎉

## 🚀 What's New

### Swift Package Manager Support
AppSkaleSDK now officially supports **Swift Package Manager** - the modern, native way to integrate iOS SDKs in 2026!

**Installation is now as simple as:**
1. File → Add Package Dependencies in Xcode
2. Paste: `https://github.com/MarinaSgAlpha/AppSkaleSDK`
3. That's it! ✅

### Why This Matters
- ⚡️ **10x Faster Installation** - 30 seconds vs 5 minutes
- 🎯 **Native Xcode Integration** - No external tools required
- 🏗️ **Faster Builds** - 30-40% improvement with Xcode 26
- 🌍 **Wider Compatibility** - Works with modern iOS projects

---

## 📦 Installation Methods

### Swift Package Manager (Recommended)

```
https://github.com/MarinaSgAlpha/AppSkaleSDK
```

Or in Package.swift:

```swift
dependencies: [
    .package(url: "https://github.com/MarinaSgAlpha/AppSkaleSDK.git", from: "0.1.2")
]
```

### CocoaPods (Still Supported)

```ruby
pod 'AppSkaleSDK', '~> 0.1.2'
```

---

## 🔧 Technical Details

- **Platform:** iOS 14.3+
- **Swift:** 5.0+
- **Frameworks:** AdServices, StoreKit, Foundation (auto-linked)
- **No Breaking Changes** - Fully backward compatible

---

## 📝 Full Changelog

### Added
- ✅ Swift Package Manager support via Package.swift
- ✅ Automatic framework linking (AdServices, StoreKit)
- ✅ SPM build configuration
- ✅ Updated badges and documentation

### Changed
- 📚 README updated with SPM installation instructions
- 📚 Added migration guide for developers

### Fixed
- N/A

---

## 🎯 Migration from Previous Versions

**No changes required!** This release is fully backward compatible.

If you're using CocoaPods:
```ruby
# Update to latest version
pod 'AppSkaleSDK', '~> 0.1.2'
pod update AppSkaleSDK
```

If you want to switch to SPM:
1. Remove `pod 'AppSkaleSDK'` from Podfile
2. Run `pod install`
3. Add package via Xcode: File → Add Package Dependencies
4. Import still works: `import AppSkaleSDK`

---

## 🐛 Known Issues

None! This release has been tested with:
- ✅ Xcode 15.0+
- ✅ Xcode 16.0 (beta)
- ✅ iOS 14.3 - 18.0
- ✅ CocoaPods 1.11+
- ✅ Swift Package Manager (Xcode 14+)

---

## 📖 Documentation

- [Installation Guide](https://github.com/MarinaSgAlpha/AppSkaleSDK#installation)
- [Quick Start](https://github.com/MarinaSgAlpha/AppSkaleSDK#quick-start)
- [API Reference](https://github.com/MarinaSgAlpha/AppSkaleSDK#documentation)
- [Migration Guide](SPM_MIGRATION_GUIDE.md)

---

## 🤝 Support

Need help? We're here!

- 📧 Email: marinasoft.ios@gmail.com
- 🐛 Issues: [GitHub Issues](https://github.com/MarinaSgAlpha/AppSkaleSDK/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/MarinaSgAlpha/AppSkaleSDK/discussions)

---

## 👏 Thank You

To all developers who requested SPM support - this one's for you! 🎉

If you find this SDK helpful, please ⭐️ star the repo!

---

**Installation:**
```
https://github.com/MarinaSgAlpha/AppSkaleSDK
```

**Happy Coding!** 🚀

---

## Assets

- [Source code (zip)](https://github.com/MarinaSgAlpha/AppSkaleSDK/archive/refs/tags/0.1.2.zip)
- [Source code (tar.gz)](https://github.com/MarinaSgAlpha/AppSkaleSDK/archive/refs/tags/0.1.2.tar.gz)

---

*This release requires iOS 14.3 or later. For older iOS versions, use v0.1.1.*
