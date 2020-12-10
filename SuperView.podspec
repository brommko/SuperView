Pod::Spec.new do |s|

  s.name         = 'SuperView'
  s.version      = '1.1.0'
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
  s.platform     = :ios, '12.0'
  s.source       = { :git => 'https://github.com/brommko/SuperView.git', :branch => 'master', :tag => s.version.to_s }
  s.weak_framework = 'UIKit'
  s.default_subspec = 'Core'
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.subspec 'Core' do |core|
    core.ios.deployment_target = '12.0'
    core.ios.vendored_frameworks = 'Frameworks/SuperViewCore.xcframework'
  end

  s.subspec 'OneSignal' do |onesignal|
    onesignal.ios.vendored_frameworks = 'Frameworks/SuperViewOneSignal.xcframework'
    onesignal.dependency 'SuperView/Core'
  end

end
