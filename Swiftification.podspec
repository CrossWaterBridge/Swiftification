Pod::Spec.new do |s|
  s.name         = "Swiftification"
  s.version      = "6.0.2"
  s.summary      = "Swift extensions to make life more pleasant."
  s.authors      = 'Hilton Campbell', 'Stephan Heilner', 'Branden Russell', 'Nick Shelley'
  s.homepage     = "https://github.com/CrossWaterBridge/Swiftification"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.source       = { :git => "https://github.com/CrossWaterBridge/Swiftification.git", :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'Swiftification/*.swift'
  s.requires_arc = true
end
