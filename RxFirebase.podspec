#
# Be sure to run `pod lib lint RxFirebase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxFirebase'
  s.version          = '0.5.0'
  s.summary          = 'Extension Firebase for Rx.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/iKichiemon/RxFirebase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iKichiemon' => '1990.iku.t@gmail.com' }
  s.source           = { :git => 'https://github.com/iKichiemon/RxFirebase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RxFirebase/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RxFirebase' => ['RxFirebase/Assets/*.png']
  # }

  #s.public_header_files = 'RxFirebase/Classes/**/*.h'
  #s.frameworks = 'UIKit', 'MapKit', 'VectorKit'
  
  s.static_framework = true
  s.dependency 'RxSwift', '~> 4.4.0'
  s.dependency 'Firebase', '~> 5.15.0'
  #s.dependency 'Firebase/Auth'
  #s.dependency 'Firebase/AdMob'
  s.dependency 'Firebase/Database', '~> 5.15.0'
  #s.dependency 'Firebase/RemoteConfig', '~> 4.4.0'
  s.dependency 'Firebase/Storage', '~> 5.15.0'
  s.dependency 'Firebase/Firestore', '~> 5.15.0'

end
