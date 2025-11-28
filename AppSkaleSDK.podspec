Pod::Spec.new do |s|
  s.name             = 'AppSkaleSDK'
  s.version          = '0.1.1'
  s.summary          = 'AppSkale Analytics SDK for iOS - Track Apple Search Ads attribution and ROAS'
  
  s.description      = <<-DESC
AppSkale Analytics SDK helps iOS developers track Apple Search Ads attribution 
and link it with purchase revenue to calculate keyword-level ROAS. 
Simply integrate the SDK and start tracking attribution automatically.
                       DESC
  
  s.homepage         = 'https://github.com/MarinaSgAlpha/AppSkaleSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MarinaSgAlpha' => 'marinasoft.ios@gmail.com' }
  s.source           = { :git => 'https://github.com/MarinaSgAlpha/AppSkaleSDK.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '14.3'
  s.swift_version = '5.0'
  
  s.source_files = 'AppSkaleSDK/Classes/**/*'
  s.frameworks = 'AdServices', 'StoreKit', 'Foundation'
end