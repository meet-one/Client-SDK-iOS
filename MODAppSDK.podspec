Pod::Spec.new do |s|
  s.name             = "MODAppSDK"
  s.version          = "1.2.1"
  s.summary          = 'MEET.ONE iOS client SDK for DApps.'
  s.homepage         = 'https://meet.one'
  s.license          = 'MIT'
  s.author           = { 'fubin0083' => 'fubin0083@gmail.com' }
  s.source           = { :git => "https://github.com/meet-one/Client-SDK-iOS.git", :tag => s.version.to_s }

  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  #s.source_files = 'WZMarqueeView/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.vendored_frameworks = 'MODAppSDK.framework'
  s.frameworks = 'Foundation', 'CoreFoundation', 'UIKit'

  s.dependency 'YYModel'
  s.dependency 'CocoaSecurity'

end
