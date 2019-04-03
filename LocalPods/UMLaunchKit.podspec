#
# Be sure to run `pod lib lint UMLaunchKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UMLaunchKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of UMLaunchKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://p2p.umeye.com'
  s.license = {
      :type => 'Copyright',
      :text => <<-LICENSE
      UMEye-Inc copyright
      LICENSE
  }
  s.author           = { 'Fred' => 'fred@umeye.com' }
  s.source           = { :git => 'https://github.com/umeye/UMLaunchKit.git', :tag => s.version.to_s }
  s.resource_bundles = {
    'UMLaunchKit' => ['UMLaunchKit/UMLaunchKit.json']
  }
  s.ios.deployment_target = '8.0'

  s.source_files = 'UMLaunchKit/*.{h,m}'

  s.public_header_files = ['UMLaunchKit/*.{h}']
end
