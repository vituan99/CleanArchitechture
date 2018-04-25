# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def pods
    pod 'Reusable', '~> 4.0'
    pod 'Then', '~> 2.3'
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
    pod 'RxSwiftExt', '~> 3.0'
    pod 'NSObject+Rx', '~> 4.2'
end

def test_pods
    pod 'RxTest', '~> 4.0'
    pod 'RxBlocking', '~> 4.0'
    pod 'Nimble', '~> 7.0'
end

target 'CleanArchitechture' do
    use_frameworks!
    pods
    
    target 'CleanArchitechtureTests' do
        inherit! :search_paths
        test_pods
    end
    
end
