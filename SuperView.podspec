Pod::Spec.new do |s|

  s.name         = 'SuperView'
  s.version      = '1.3.3'
  s.summary      = 'SuperView allows you to wrap your website in a super simple iOS app.'
  s.description  = 'SuperView iOS SDK provides a library that makes it easy for an iOS developer to wrap his website in a super simple iOS app.'
  s.homepage     = 'https://github.com/brommko/SuperView'
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the 'License');
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an 'AS IS' BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }
  s.author       = { 'Brommko LLC' => 'brommko@yahoo.com' }
  s.platform     = :ios, '13.0'
  s.source       = { 
    :git => 'https://github.com/brommko/SuperView.git',
    :tag => s.version.to_s,
    :submodules => true 
  }
  s.weak_framework = 'UIKit'
  s.default_subspec = 'Core'
  s.swift_versions = '5.5.1'
  s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
  s.subspec 'Core' do |core|
    core.user_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
    core.ios.deployment_target = '13.0'
    core.ios.vendored_frameworks = 'Frameworks/SuperViewCore.xcframework'
  end

  s.subspec 'OneSignal' do |onesignal|
    onesignal.ios.vendored_frameworks = 'Frameworks/SuperViewOneSignal.xcframework', 'Frameworks/OneSignal.xcframework'
    onesignal.dependency 'SuperView/Core'
  end

  s.subspec 'AdMob' do |admob|
    admob.ios.vendored_frameworks = 'Frameworks/SuperViewAdMob.xcframework'
    admob.dependency 'SuperView/Core'
    admob.dependency 'Google-Mobile-Ads-SDK', '8.13.0'
    admob.dependency 'Firebase', '8.10.0'
  end

  s.subspec 'Firebase' do |firebase|
    firebase.ios.vendored_frameworks = 'Frameworks/SuperViewFirebase.xcframework'
    firebase.dependency 'SuperView/Core'
    firebase.dependency 'Firebase', '8.10.0'
    firebase.dependency 'Firebase/Messaging', '8.10.0'
  end

  s.subspec 'Facebook' do |facebook|
    facebook.ios.vendored_frameworks = 'Frameworks/SuperViewFacebook.xcframework'
    facebook.dependency 'SuperView/Core'
    facebook.dependency 'FBSDKCoreKit', '12.2.0'
    facebook.dependency 'FBSDKLoginKit', '12.2.0'
    facebook.dependency 'FBSDKShareKit', '12.2.0'
    facebook.dependency 'FBAudienceNetwork', '6.9.0'
  end

  s.subspec 'Location' do |location|
    location.ios.vendored_frameworks = 'Frameworks/SuperViewLocation.xcframework'
    location.dependency 'SuperView/Core'
  end

  s.subspec 'QR' do |qr|
    qr.ios.vendored_frameworks = 'Frameworks/SuperViewQR.xcframework'
    qr.dependency 'SuperView/Core'
  end

end
