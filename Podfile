#xcoadeproj './Common.xcodeproj'
# Podfileのバージョン指定
version = '9.0'
platform :ios, version
swift_version = '4.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

def install_pods

pod 'Kingfisher', '4.6.1', :inhibit_warnings => true
pod 'SnapKit', '~>4.0.0'
pod 'Alamofire', '~> 4.7.0'
pod 'XCGLogger', '~> 6.0.2' 
pod 'ObjectMapper', '~> 3.1.0'
pod 'Google/Analytics'
pod 'Result'
 
end

target 'Common' do
  install_pods
end


post_install do |installer|
  installer.pods_project.build_configurations.each do |project_config|
    next if project_config.name == 'Release'
    project_config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
    project_config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
    project_config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
    project_config.build_settings['ENABLE_TESTABILITY'] = 'YES'
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = version
      config.build_settings['SDKROOT'] = 'iphoneos'
    end
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['SWIFT_VERSION'] = "4.0"
    end
  end

end
