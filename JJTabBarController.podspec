Pod::Spec.new do |s|
  s.name         = "JJTabBarController"
  s.version      = "1.0"
  s.summary      = "Create a TabBarController as it should be."
  s.homepage     = "https://github.com/joaofrjesusbe/JJTabBarController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "João Jesus" => "joaofrjesusbe@gmail.com" }
  s.platform     = :ios, '6.0'
  s.source       = {:git => 'https://github.com/krafttuc/TYMProgressBarView.git', :tag => "v#{s.version}"}
  s.source_files  = 'JJTabBarController/Source/**'
  s.requires_arc  = true
end
