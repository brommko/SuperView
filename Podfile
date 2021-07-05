platform :ios, '12.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false
source 'https://github.com/CocoaPods/Specs.git'

target 'Example' do
  use_frameworks!

  pod "SuperView/Core", :git => 'https://github.com/brommko/SuperView.git', :tag => '1.2.8'
  pod "SuperView/OneSignal", :git => 'https://github.com/brommko/SuperView.git', :tag => '1.2.8'
  pod "SuperView/AdMob", :git => 'https://github.com/brommko/SuperView.git', :tag => '1.2.8'
  pod "SuperView/Firebase", :git => 'https://github.com/brommko/SuperView.git', :tag => '1.2.8'
  pod "SuperView/QR", :git => 'https://github.com/brommko/SuperView.git', :tag => '1.2.8'
  pod "SuperView/Location", :git => 'https://github.com/brommko/SuperView.git', :tag => '1.2.8'
end

#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#    end
#  end
#end
