source 'https://cdn.cocoapods.org/'

install! 'cocoapods', :deterministic_uuids => false
inhibit_all_warnings!

# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

use_frameworks!

def shared_pods
  pod 'KwizzadRTA', '0.6.0'
end

target 'KwizzadRTASample' do
  shared_pods
end

target 'KwizzadRTASampleObjC' do
  shared_pods
end
