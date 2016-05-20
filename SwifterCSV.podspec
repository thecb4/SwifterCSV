Pod::Spec.new do |s|
  s.name         = "SwifterCSV"
  s.version      = "0.4.0"
  s.summary      = "Simple CSV parsing for OSX and iOS"
  s.homepage     = "https://github.com/thecb4/SwifterCSV"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Cavelle Benjamin" => "cavelle@thecb4.io" }
  s.source       = { :git => "https://github.com/thecb4/SwifterCSV.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source_files = "SwifterCSV/**/*.swift"
  s.requires_arc = true
end
