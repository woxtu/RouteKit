Pod::Spec.new do |spec|
  spec.name          = 'RouteKit'
  spec.version       = '0.3.0'
  spec.license       = { :type => 'MIT', :file => 'LICENSE-MIT' }
  spec.homepage      = 'https://github.com/woxtu/RouteKit'
  spec.author        = { 'woxtu' => 'woxtup@gmail.com' }
  spec.summary       = 'Type-safe URL routing for Swift.'
  spec.source        = { :git => 'https://github.com/woxtu/RouteKit.git', :tag => spec.version }
  spec.swift_version = '5.0'

  spec.ios.deployment_target  = '9.0'
  spec.osx.deployment_target  = '10.12'

  spec.source_files       = 'Sources/**/*.swift'

  spec.ios.framework  = 'UIKit'
end
