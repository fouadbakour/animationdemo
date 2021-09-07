platform :ios, '13.0'
inhibit_all_warnings!

# Define the main used Pods
def main_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya'
end

# Define the components used Pods
def imageLazyLoading_pods
  pod 'SDWebImage'
end

target 'AnimationDemo' do
  # Pods for AnimationDemo
  use_frameworks!
  project './AnimationDemo.xcodeproj'
  workspace './AnimationDemo.xcworkspace'
  inherit! :search_paths
  main_pods
  imageLazyLoading_pods
end


target 'UIComponents' do
  # Pods for UIComponents
  use_frameworks!
  project 'SubModules/UIComponents/UIComponents.xcodeproj'
  inherit! :search_paths
  imageLazyLoading_pods
end

