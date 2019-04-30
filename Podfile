# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'HotSpot' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HotSpot
  def common_pods
      pod 'Firebase/Core'
      pod 'Firebase/Auth'
      pod 'Firebase/Firestore'
  end
common_pods

  target 'HotSpotTests' do
      inherit! :search_paths
      common_pods
  end

end
