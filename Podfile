platform:ios, '8.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/umeye/umeye-specs.git'

#use_frameworks!

target "UMP2PDemo" do
    # App 依赖
    # UM P2P SDK
    pod 'UMP2P'
    pod 'FFmpeg', '2.8.15'

    # UM功能模块配置
    pod 'UMLaunchKit', :path => 'LocalPods/UMLaunchKit.podspec'

    # # UM工具类
    pod 'UMViewUtils', :path => 'LocalPods/UMViewUtils.podspec'

    # UM SDK 配置
    pod 'UMP2PApiClientLaunch', :path => 'LocalPods/UMP2PApiClientLaunch.podspec'
    # UM P2P 推送模块接口
    pod 'UMP2PPushLaunch', :path => 'LocalPods/UMP2PPushLaunch.podspec'
    
    # UM P2P 用户系统接口
    pod 'UMP2PAccount', :path => 'LocalPods/UMP2PAccount.podspec'
    # UM P2P 视频播放系统接口
    pod 'UMP2PVisual', :path => 'LocalPods/UMP2PVisual.podspec'
end

post_install do |installer|
    installer.aggregate_targets.each do |target|
        copy_pods_resources_path = "Pods/Target Support Files/#{target.name}/#{target.name}-resources.sh"
        string_to_replace = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"'
        assets_compile_with_app_icon_arguments = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${BUILD_DIR}/assetcatalog_generated_info.plist"'
        text = File.read(copy_pods_resources_path)
        new_contents = text.gsub(string_to_replace, assets_compile_with_app_icon_arguments)
        File.open(copy_pods_resources_path, "w") {|file| file.puts new_contents }
    end
    
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['HEADER_SEARCH_PATHS'] = '${PODS_ROOT}/**'
#        end
#    end
end
