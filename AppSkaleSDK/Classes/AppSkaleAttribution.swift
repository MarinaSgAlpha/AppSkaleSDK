
import Foundation
import AdServices
import StoreKit

public class AppSkaleAttribution {
    
    public static let shared = AppSkaleAttribution()
    
    private let backendURL = "https://appskaleai-production.up.railway.app/api"
    private let attributionCacheKey = "appskale_attribution_cache"
    private let attributionFetchedKey = "appskale_attribution_fetched"
    
    private init() {}
    
    // MARK: - Configuration
    
    /// Call this in AppDelegate didFinishLaunching
    public func configure() {
        print("🚀 AppSkale Attribution initialized")
        
        // Fetch attribution on first launch or if not cached
        if !UserDefaults.standard.bool(forKey: attributionFetchedKey) {
            fetchAttribution()
        }
    }
    
    // MARK: - Attribution Collection
    
    /// Fetch attribution from Apple and send to backend for decoding
    public func fetchAttribution() {
        print("📱 Fetching attribution token...")
        
        guard let token = getAttributionToken() else {
            print("⚠️ No attribution token available")
            return
        }
        
        print("✅ Got attribution token, sending to backend...")
        
        // Send to backend for decoding
        sendAttributionTokenToBackend(token: token)
    }
    
    /// Get attribution token from Apple AdServices
    private func getAttributionToken() -> String? {
        do {
            let token = try AAAttribution.attributionToken()
            return token
        } catch {
            print("❌ Attribution token error:", error)
            return nil
        }
    }
    
    /// Send attribution token to backend for decoding
    private func sendAttributionTokenToBackend(token: String) {
        guard let url = URL(string: "\(backendURL)/attribution/decode") else {
            print("❌ Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = [
            "attribution_token": token,
            "timestamp": ISO8601DateFormatter().string(from: Date())
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Backend error:", error)
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
            }
            
            // Parse response
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print("✅ Attribution decoded:", json)
                
                // Cache attribution data
                self?.cacheAttribution(json)
                
                // Mark as fetched
                UserDefaults.standard.set(true, forKey: self?.attributionFetchedKey ?? "")
            }
        }.resume()
    }
    
    /// Cache attribution data locally
    private func cacheAttribution(_ data: [String: Any]) {
        if let jsonData = try? JSONSerialization.data(withJSONObject: data) {
            UserDefaults.standard.set(jsonData, forKey: attributionCacheKey)
            print("💾 Attribution cached")
        }
    }
    
    /// Get cached attribution data
    private func getCachedAttribution() -> [String: Any]? {
        guard let data = UserDefaults.standard.data(forKey: attributionCacheKey) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
    
    // MARK: - Purchase Tracking
    
    /// Track a purchase with attribution
    /// Call this when a purchase completes
    public func trackPurchase(
        transaction: SKPaymentTransaction,
        price: Double,
        currency: String
    ) {
        let transactionId = transaction.transactionIdentifier ?? "unknown"
        let productId = transaction.payment.productIdentifier
        
        trackPurchase(
            transactionId: transactionId,
            productId: productId,
            price: price,
            currency: currency
        )
    }
    
    /// Track a purchase with attribution (manual parameters)
    public func trackPurchase(
        transactionId: String,
        productId: String,
        price: Double,
        currency: String
    ) {
        print("💰 Tracking purchase: \(productId) - \(price) \(currency)")
        
        // Get cached attribution
        let attribution = getCachedAttribution()
        
        // Send to backend
        sendPurchaseToBackend(
            transactionId: transactionId,
            productId: productId,
            price: price,
            currency: currency,
            attribution: attribution
        )
    }
    
    /// Send purchase + attribution to backend
    private func sendPurchaseToBackend(
        transactionId: String,
        productId: String,
        price: Double,
        currency: String,
        attribution: [String: Any]?
    ) {
        guard let url = URL(string: "\(backendURL)/attribution/purchase") else {
            print("❌ Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var payload: [String: Any] = [
            "transaction_id": transactionId,
            "product_id": productId,
            "price": price,
            "currency": currency,
            "purchased_at": ISO8601DateFormatter().string(from: Date())
        ]
        
        // Add attribution data if available
        if let attribution = attribution {
            payload["attribution"] = attribution
        }
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Purchase tracking error:", error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("✅ Purchase tracked successfully")
                } else {
                    print("⚠️ Purchase tracking failed: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
}

// MARK: - Usage Examples

/*
 
 ==========================================
 INTEGRATION GUIDE
 ==========================================
 
 1. In AppDelegate.swift:
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize AppSkale Attribution
        AppSkaleAttribution.shared.configure()
        
        return true
    }
 
 2. In your purchase completion handler:
 
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // Get product price (you should have this from your product list)
                let price = 9.99 // Replace with actual price
                let currency = "USD" // Replace with actual currency
                
                // Track the purchase
                AppSkaleAttribution.shared.trackPurchase(
                    transaction: transaction,
                    price: price,
                    currency: currency
                )
                
                // Finish transaction
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .failed, .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                
            default:
                break
            }
        }
    }
 
 3. For RevenueCat users:
 
    Purchases.shared.purchase(package: package) { (transaction, purchaserInfo, error, userCancelled) in
        if error == nil {
            // Get price from package
            let price = package.storeProduct.price
            let currency = package.storeProduct.priceFormatter?.currencyCode ?? "USD"
            
            // Track with AppSkale
            if let transaction = transaction {
                AppSkaleAttribution.shared.trackPurchase(
                    transaction: transaction,
                    price: price as! Double,
                    currency: currency
                )
            }
        }
    }
 
 ==========================================
 THAT'S IT! 🎉
 ==========================================
 
 The attribution system will:
 1. Automatically fetch attribution when app launches
 2. Cache it locally
 3. Send attribution + purchase data to your backend when purchases happen
 4. Your backend decodes the attribution and calculates ROAS
 
*/

