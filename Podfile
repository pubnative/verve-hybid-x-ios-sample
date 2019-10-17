source 'https://github.com/CocoaPods/Specs.git'

install! 'cocoapods', :deterministic_uuids => false
inhibit_all_warnings!

# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

use_frameworks!

def shared_pods

  pod 'KwizzadRTA', :subspecs => ["Core"], :git => 'git@bitbucket.org:tvsmiles/rtakit-spec.git'

end

target 'KwizzadRTASample' do
  shared_pods
end
