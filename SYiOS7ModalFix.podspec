Pod::Spec.new do |s|
  s.name     = 'SYiOS7ModalFix'
  s.version  = '1.0.2'
  s.license  = 'Custom'
  s.summary  = 'Fix for iOS7 modal views and status bar height changes'
  s.homepage = 'https://github.com/dvkch/SYiOS7ModalFix'
  s.author   = { 'Stan Chevallier' => 'contact@stanislaschevallier.fr' }
  s.source   = { :git => 'https://github.com/dvkch/SYiOS7ModalFix.git', :tag => s.version.to_s }
  s.source_files = 'SYiOS7ModalFix/*.{h,m}'
  s.requires_arc = true
  s.deprecated = true

  s.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES' }
  s.ios.deployment_target = '7.0'
end
