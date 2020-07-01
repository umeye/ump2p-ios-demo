#
# Be sure to run `pod lib lint UMCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UMCategory'
  s.version          = '1.0.2'
  s.summary          = 'A short description of UMCategory'

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
  s.source           = { :git => 'fred@umeye.com:umcategory-ios/#{s.name}.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = "#{s.name}/**/*.{h,m}"
  
  s.frameworks = 'UIKit'
  
  s.dependency 'SVProgressHUD'
  s.dependency 'MBProgressHUD'
  s.dependency 'ReactiveObjC'

end
