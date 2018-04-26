source 'https://gitlab.smedialink.com/iOS/SmlPodsRepo.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'Find Place' do
  use_frameworks!
  
  # Dependency management
  pod 'Dip'
  pod 'Dip-UI'
  
  # UI
  pod 'Cosmos', '~> 11.0'
  pod 'TableKit'
  pod 'DTTableViewManager', '~> 5.2'
  
  # Maps
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'GoogleMaps'
  
  # Social networks
  pod 'GoogleSignIn'
  
  # Firebase
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Database'
  
  # Mapping
  pod 'Marshal'
  
  # Navigation
  pod 'ViperKit'
  
  # Others
  pod 'PromiseKit', '~> 4.0'
  pod 'PromiseKit/CoreLocation'
  
  # Utils
  pod 'SwiftLint'
  
  target 'Find PlaceTests' do
      inherit! :search_paths
  end
  
end

post_install do |installer|
    Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
        flag_name = File.basename(script, ".sh") + "-Installation-Flag"
        folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
        file = File.join(folder, flag_name)
        content = File.read(script)
        content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
        File.write(script, content)
    end
end
