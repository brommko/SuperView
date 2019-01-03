Pod::Spec.new do |s|

  s.name         = "SuperView"
  s.version      = "1.0.0"
  s.summary      = "SuperView allows you to wrap your website in a super simple iOS app."
  s.description  = 'SuperView iOS SDK provides a library that makes it easy for an iOS developer to wrap his website in a super simple iOS app.'
  s.homepage     = "https://github.com/brommko/SuperView"
  s.license      = "MIT"
  s.author       = { "Brommko LLC" => "brommko@yahoo.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/brommko/SuperView.git", :branch => "master", :tag => "#{s.version}" }
  s.weak_framework = 'UIKit'
  s.static_framework = true
  s.requires_arc = true
  s.source_files = 'Frameworks/**/*.{h}'
  s.ios.public_header_files = 'Frameworks/**/*.{h}'
  s.ios.vendored_frameworks = 'Frameworks/*.{framework}'
  s.dependency 'GCDWebServer', "~> 3.0"

end
