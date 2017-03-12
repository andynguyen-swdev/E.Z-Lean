# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

use_frameworks!

target 'E.Z Lean' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks


  # Pods for E.Z Lean
	pod ’SwiftyJSON’

pod 'RxSwift'
pod 'RxCocoa'
pod 'RxDataSources'
pod 'RxSwiftExt'
pod 'RxRealm'
pod 'RxGesture'
pod 'IBAnimatable'

pod 'SDWebImage'
pod 'SDWebImage/GIF'

pod 'Alamofire'
pod 'MaterialControls'
pod 'Popover'
pod 'RealmSwift'
pod 'ReachabilitySwift'
pod 'SlideMenuControllerSwift'
pod 'LTMorphingLabel'

pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Auth'

pod 'Kanna', '~> 2.1.0'
pod 'FLAnimatedImage'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end


