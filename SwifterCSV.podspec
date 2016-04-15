Pod::Spec.new do |s|
  s.name         = "SwifterCSV"
  s.version      = "0.3.1"
  s.summary      = "Simple CSV parsing for OSX and iOS"
  s.homepage     = "https://github.com/JavaNut13/SwifterCSV"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Will Richardson" => "william.hamish@gmail.com" }
  s.source       = { :git => "https://github.com/JavaNut13/SwifterCSV.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source_files = "SwifterCSV/**/*.swift"
  s.requires_arc = true
end
