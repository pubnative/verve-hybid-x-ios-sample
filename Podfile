source 'https://cdn.cocoapods.org/'

install! 'cocoapods', :deterministic_uuids => false
inhibit_all_warnings!

# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

use_frameworks!

def shared_pods
  pod 'HyBidX', '0.7.7'
end

target 'HyBidXSample' do
  shared_pods
end

target 'HyBidXSampleObjC' do
  shared_pods
end
