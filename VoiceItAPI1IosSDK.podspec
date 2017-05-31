# Be sure to run `pod lib lint VoiceItApi2IosSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'VoiceItAPI1IosSDK'
s.version          = '0.2'
s.summary          = 'A pod that lets you add authentication to your iOS apps, brought to you by VoiceIt'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'A pod that lets you add authentication to your iOS apps, brought to you by VoiceIt. Please visit https://voiceit.tech to learn more and sign up for an account.'
s.homepage         = 'https://github.com/voiceittech/VoiceItAPI1IosSDK'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'armaanbindra' => 'armaan.bindra@voiceit-tech.com' }
s.source           = { :git => 'https://github.com/voiceittech/VoiceItAPI1IosSDK.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'VoiceItAPI1IosSDK/Classes/**/*'

# s.resource_bundles = {
#   'VoiceItApi2IosSDK' => ['VoiceItAPI1IosSDK/Assets/*.png']
# }

#s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit', 'AVFoundation'
# s.dependency 'AFNetworking', '~> 2.3'
end
