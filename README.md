# AppSkaleSDK

[![Version](https://img.shields.io/cocoapods/v/AppSkaleSDK.svg?style=flat)](https://cocoapods.org/pods/AppSkaleSDK)
[![License](https://img.shields.io/cocoapods/l/AppSkaleSDK.svg?style=flat)](https://cocoapods.org/pods/AppSkaleSDK)
[![Platform](https://img.shields.io/cocoapods/p/AppSkaleSDK.svg?style=flat)](https://cocoapods.org/pods/AppSkaleSDK)

**Keyword-level ROAS tracking for iOS apps running Apple Search Ads.**

AppSkaleSDK is the iOS client library for [AppSkale](https://appskale.ai) — a platform that connects your Apple Search Ads spend with RevenueCat revenue data so you can see exactly which keywords are profitable and which ones are burning money.

---

## The Problem

Apple Search Ads shows you impressions, taps, and installs. That's it.

For subscription apps, installs are the wrong metric. A keyword can drive hundreds of installs and zero paying subscribers. Another keyword might drive fewer installs but convert at 3x the rate. Without revenue attribution at the keyword level, you're optimizing blind.

Traditional Mobile Measurement Partners (MMPs) solve this, but they cost $5,000–$20,000/month — out of reach for indie developers and small app studios.

**AppSkale fills this gap.** It automatically joins your Apple Search Ads attribution data with RevenueCat subscription events to give you keyword-level ROAS, LTV, and revenue metrics — without spreadsheets, without manual reconciliation, and without enterprise pricing.

---

## How It Works

1. **AppSkaleSDK** captures Apple Search Ads attribution data at app launch using Apple's AdServices framework
2. The SDK sends the attribution token (keyword, campaign, ad group, match type) to the AppSkale backend for decoding
3. Attribution is cached locally so it's available when purchases happen
4. **AppSkale** listens to your RevenueCat webhooks for subscription events (trials, conversions, renewals, cancellations)
5. AppSkale joins the attribution data with revenue events to calculate keyword-level ROAS in real time
6. You see a dashboard showing which keywords are profitable and which ones to pause

No manual data exports. No spreadsheets. No reconciliation.

---

## Requirements

- iOS 13.0+
- Swift 5.0+
- An [AppSkale](https://appskale.ai) account
- RevenueCat SDK integrated in your app

---

## Installation

### Swift Package Manager

In Xcode: **File → Add Package Dependencies** and enter:
```
https://github.com/MarinaSgAlpha/AppSkaleSDK
```

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MarinaSgAlpha/AppSkaleSDK.git", from: "1.0.0")
]
```

### CocoaPods

Add to your `Podfile`:

```ruby
pod 'AppSkaleSDK'
```

Then run:

```bash
pod install
```

---

## Quick Start

### 1. Initialize the SDK

Call `configure(apiKey:)` in your `AppDelegate` or SwiftUI app entry point. This fetches and caches Apple Search Ads attribution on first launch, and sets your API key as a RevenueCat subscriber attribute so AppSkale can join attribution to revenue server-side.

```swift
import AppSkaleSDK

// AppDelegate
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    AppSkaleAttribution.shared.configure(apiKey: "YOUR_APPSKALE_API_KEY")
    return true
}

// SwiftUI
@main
struct MyApp: App {
    init() {
        AppSkaleAttribution.shared.configure(apiKey: "YOUR_APPSKALE_API_KEY")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

That's all you need for RevenueCat users — attribution is captured automatically and AppSkale joins it to revenue via webhooks server-side.

---

### 2. (Optional) Track Purchases Manually

If you're using StoreKit directly instead of RevenueCat, track purchases manually:

```swift
// With SKPaymentTransaction
AppSkaleAttribution.shared.trackPurchase(
    transaction: transaction,
    price: 9.99,
    currency: "USD"
)

// With manual parameters
AppSkaleAttribution.shared.trackPurchase(
    transactionId: "your_transaction_id",
    productId: "com.yourapp.monthly",
    price: 9.99,
    currency: "USD"
)
```

Full StoreKit example:

```swift
func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
        switch transaction.transactionState {
        case .purchased:
            AppSkaleAttribution.shared.trackPurchase(
                transaction: transaction,
                price: 9.99,   // use your actual product price
                currency: "USD"
            )
            SKPaymentQueue.default().finishTransaction(transaction)
        case .failed, .restored:
            SKPaymentQueue.default().finishTransaction(transaction)
        default:
            break
        }
    }
}
```

---

## What You Get in AppSkale

Once integrated, your AppSkale dashboard shows keyword-level data like this:

| Keyword | Spend | Revenue | ROAS | Installs | Conversions |
|---------|-------|---------|------|----------|-------------|
| speech to text | $142 | $426 | 3.0x | 89 | 12 |
| voice recorder | $198 | $218 | 1.1x | 124 | 8 |
| dictation app | $203 | $0 | 0.0x | 67 | 0 |

In this example, "dictation app" has driven 67 installs and $203 in spend — but zero revenue. Without AppSkale, you'd never know to pause it.

---

## Who This Is For

- **Indie iOS developers** running Apple Search Ads who want to know which keywords actually drive revenue, not just installs
- **Mobile marketing agencies** managing Apple Search Ads for multiple clients
- **App studios** spending $500–$50,000/month on Apple Search Ads who need attribution without MMP pricing

---

## Getting Your API Key

1. Sign up at [appskale.ai](https://appskale.ai)
2. Connect your Apple Search Ads account
3. Connect your RevenueCat account and configure webhooks
4. Copy your API key from the dashboard settings

Setup takes about 10 minutes.

---

## Example Project

Clone the repo and run `pod install` from the `Example` directory:

```bash
git clone https://github.com/MarinaSgAlpha/AppSkaleSDK.git
cd AppSkaleSDK/Example
pod install
open AppSkaleSDK.xcworkspace
```

---

## Support

- **Website:** [appskale.ai](https://appskale.ai)
- **Email:** support@appskale.ai

---

## License

AppSkaleSDK is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
