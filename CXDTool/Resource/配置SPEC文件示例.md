##配置SPEC文件示例
  ```
Pod::Spec.new do |s|
  s.name             = 'HMSocket'
  s.version          = '0.1.9'
  s.summary          = '火猫Socket聊天室底层通讯模块'
  s.description      = '火猫Socket聊天室底层通讯模块'
  s.homepage         = 'ios@git.marstv.com:/git/iOSModule/HMSocket'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhonghphuan@hotmail.com' => 'zhonghphuan@hotmail.com' }
  s.source           = { :git => 'ios@git.marstv.com:/git/iOSModule/HMSocket/HMSocket.git', :tag => s.version.to_s }
  
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  
  s.subspec 'HMSocketManager' do |manager|
      manager.source_files = 'HMSocket/Classes/HMSocketManager/**/*.{c,h,hh,m,mm}'
      manager.dependency 'SocketRocket','0.5.1'
  end
 
  s.subspec 'HMSocketModel' do |model|
      model.source_files = 'HMSocket/Classes/HMSocketModel/**/*.{c,h,hh,m,mm}'
      model.dependency 'YYModel','1.0.4'
  end


  # s.resource_bundles = {
  #   'HMSocket' => ['HMSocket/Assets/*.png']
  # }
  # s.frameworks = 'UIKit', 'MapKit'
  

end
  ```