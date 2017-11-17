Pod::Spec.new do |spec|
	spec.name		= 'TimeZonePicker-JAApps'
	spec.version	= '1.1.0'
	spec.license	= 'MIT'
	spec.homepage	= 'https://github.com/grangej/TimeZonePicker'
	spec.authors	= { 'John Grange' => 'john@sd-networks.net' }
	spec.summary	= 'Fully localized TimeZonePicker control'
	spec.source		= { :git => 'https://github.com/grangej/TimeZonePicker.git', :tag => 'v1.1.0' }
	spec.xcconfig = { 'SWIFT_VERSION' => '4.0' }
	spec.module_name	= 'TimeZonePicker'

	spec.ios.deployment_target	= '11.0'
	
	spec.source_files	= 'TimeZonePicker/**/*.swift'
	spec.resources = 'TimeZonePicker/**/*.strings', 'TimeZonePicker/**/*.xib', 'TimeZonePicker/Resources/*.plist'
	
	spec.frameworks = 'UIKit'
end