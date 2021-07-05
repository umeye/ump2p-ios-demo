#
# Be sure to run `pod lib lint UMHLSVisual.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
#import <UMViewUtils/UMViewUtils.h>
#import <ReactiveObjC/ReactiveObjC.h>

Pod::Spec.new do |s|
  s.name             = 'UMHLSVisual'
  s.version          = '0.0.1'
  s.summary          = 'UMHLSVisual'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://wwww.umeye.com'
  s.license = {
  :type => 'Copyright',
  :text => <<-LICENSE
            UMEye-Inc copyright
  LICENSE
  }
  s.author           = { '王伏' => 'fred@umeye.com' }
  s.source           = { :git => 'fred@umeye.com:umhls-visual-ios/#{s.name}.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = "#{s.name}/**/*.{h,m}"
  s.resource_bundles = {
    'UMHLSVisual' => ["#{s.name}/**/*.{xib,storyboard,png,json,lproj,xcassets}"],
  }

  s.frameworks = 'UIKit'
  s.xcconfig = {    'OTHER_LDFLAGS' => '-ObjC'}
  s.dependency 'Masonry'
  s.dependency 'ReactiveObjC'
  s.dependency 'UMHLS', '~> 1.2.9'
  s.dependency 'UMLog'
  
  s.prefix_header_contents = <<-EOS
  #import "UMHLSVisualUtils.h"
  EOS
end
