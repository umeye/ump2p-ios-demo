#
# Be sure to run `pod lib lint UMViewUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UMViewUtils'
  s.version          = '0.0.1'
  s.summary          = 'UMViewUtils'

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
  s.source           = { :git => 'fred@umeye.com:view-utils-ios/#{s.name}.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = "#{s.name}/**/*.{h,m}"
  s.resource_bundles = {
    'UMViewUtils' => ["#{s.name}/**/*.{xib,storyboard,png,json,lproj,xcassets}"],
  }

  s.frameworks = 'UIKit'
  s.xcconfig = {    'OTHER_LDFLAGS' => '-ObjC'}
  # 自动布局
  s.dependency 'Masonry', '~> 1.1.0'
  # 富文本控件
  s.dependency 'SJAttributesFactory'
  # 
  s.dependency 'ReactiveObjC'
  # AOP面向切面
  s.dependency 'Aspects', '~> 1.4.1'
  s.dependency 'SVProgressHUD'
  
end
