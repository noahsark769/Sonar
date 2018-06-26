folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_HAVE_LIBGFLAGS=0 -DFOLLY_HAVE_LIBJEMALLOC=0 -DFOLLY_HAVE_PREADV=0 -DFOLLY_HAVE_PWRITEV=0 -DFOLLY_HAVE_TFO=0 -DFOLLY_USE_SYMBOLIZER=0'
yoga_version = '~> 1.8'
yogakit_version = '1.8.1'

Pod::Spec.new do |spec|
  spec.name = 'SonarKit'
  spec.version = '0.0.1'
  spec.license = { :type => 'MIT' }
  spec.homepage = 'https://github.com/facebook/Sonar'
  spec.summary = 'Sonar iOS podspec'
  spec.authors = 'Facebook'
  spec.static_framework = true
  spec.source = { :git => 'https://github.com/facebook/Sonar.git',
                  :branch=> "master" }
  spec.module_name = 'SonarKit'
  spec.dependency 'Folly'
  spec.dependency 'Sonar'
  spec.dependency 'CocoaAsyncSocket', '~> 7.6'
  spec.dependency 'PeerTalk'
  spec.dependency 'OpenSSL-Static', '1.0.2.c1'
  spec.source_files = 'FBDefines/*.{h,cpp,m,mm}', '**/*.{h,cpp,m,mm}', 'FBCxxUtils/*.{h, mm}',
  spec.public_header_files = '**/{SonarClient,SonarPlugin,SKMacros,FBMacros}.h'

  spec.compiler_flags = '-DFB_SONARKIT_ENABLED=1 -DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_HAVE_LIBGFLAGS=0 -DFOLLY_HAVE_LIBJEMALLOC=0 -DFOLLY_HAVE_PREADV=0 -DFOLLY_HAVE_PWRITEV=0 -DFOLLY_HAVE_TFO=0 -DFOLLY_USE_SYMBOLIZER=0'
  spec.pod_target_xcconfig = { "USE_HEADERMAP" => "NO",
                               "DEFINES_MODULE" => "YES",
                               "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/Headers/Public/SonarKit\" \"$(PODS_TARGET_SRCROOT)\"/** \"$(PODS_ROOT)/boost-for-react-native\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/PeerTalkSonar\" \"$(PODS_ROOT)/ComponentKit\"/**" }
  spec.platforms = { :ios => "8.0" }

  spec.subspec "SonarKitLayoutPlugin" do |ss|
    ss.dependency             "Yoga", yoga_version
    ss.dependency             'YogaKit', yogakit_version
    ss.compiler_flags       = folly_compiler_flags
    ss.public_header_files = 'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SonarKitLayoutPlugin.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKTouch.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKDescriptorMapper.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKNodeDescriptor.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKInvalidation.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKNamed.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKTapListener.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKObject.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/SKHighlightOverlay.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/UIColor+SKSonarValueCoder.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/utils/SKObjectHash.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/utils/SKSwizzle.h',
                              'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/utils/SKYogaKitHelper.h'
    ss.source_files         = 'Plugins/SonarKitLayoutPlugin/SonarKitLayoutPlugin/**/*.{h,cpp,m,mm}'
  end

  spec.subspec "SonarKitLayoutComponentKitSupport" do |ss|
    ss.dependency             "Yoga", yoga_version
    ss.dependency             "ComponentKit"
    ss.dependency             "SonarKit/SonarKitLayoutPlugin"
    ss.public_header_files = 'Plugins/SonarKitLayoutPlugin/SonarKitLayoutComponentKitSupport/SonarKitLayoutComponentKitSupport.h',
                             'Plugins/SonarKitLayoutPlugin/SonarKitLayoutComponentKitSupport/SKComponentLayoutWrapper.h'

    ss.source_files         = "iOS/Plugins/SonarKitLayoutPlugin/SonarKitLayoutComponentKitSupport/**/*.{h,cpp,m,mm}"
    ss.pod_target_xcconfig = { "USE_HEADERMAP" => "NO",
                                 "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)\"" }
  end

  spec.subspec "SonarKitNetworkPlugin" do |ss|
    ss.public_header_files = 'Plugins/SonarKitNetworkPlugin/SonarKitNetworkPlugin/SonarKitNetworkPlugin.h',
                             'Plugins/SonarKitNetworkPlugin/SonarKitNetworkPlugin/SKBufferingPlugin.h',
                             'Plugins/SonarKitNetworkPlugin/SonarKitNetworkPlugin/SKDispatchQueue.h',
                             'Plugins/SonarKitNetworkPlugin/SonarKitNetworkPlugin/SKNetworkReporter.h'
    ss.source_files         = "Plugins/SonarKitNetworkPlugin/SonarKitNetworkPlugin/*.{h,cpp,m,mm}"
    ss.pod_target_xcconfig = { "USE_HEADERMAP" => "NO",
                                 "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)\"" }
  end

  spec.subspec "SKIOSNetworkPlugin" do |ss|
    ss.dependency  'SonarKit/SonarKitNetworkPlugin'
    ss.public_header_files = 'Plugins/SonarKitNetworkPlugin/SKIOSNetworkPlugin/SKIOSNetworkAdapter.h'
    ss.source_files         = "Plugins/SonarKitNetworkPlugin/SKIOSNetworkPlugin/**/*.{h,cpp,m,mm}"
    ss.pod_target_xcconfig = { "USE_HEADERMAP" => "NO",
                                 "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)\"" }
  end
end
