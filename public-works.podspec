#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "public-works"
  s.version          = "0.1.0"
  s.summary          = "A short description of public-works."
  s.description      = <<-DESC
                       An optional longer description of public-works

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/mteece/public-works"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Matthew Teece" => "mteece@gmail.com" }
  s.source           = { :git => "git@github.com:mteece/public-works.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/doctorteece'

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/Exclude/osx'
  s.osx.exclude_files = 'Classes/Exclude/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
  s.dependency 'NSObject-ObjectMap'
  s.dependency 'AFNetworking'
  s.dependency 'RaptureXML'
  s.dependency 'AFRaptureXMLRequestOperation'
end
