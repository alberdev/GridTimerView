
Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.platform = :ios
s.ios.deployment_target = '10'
s.name = "GridTimerView"
s.summary = "GridTimerView shows a schedule with timer controller. Each cell can manage multiple events. Used for listing TV programs shows in a table."
s.requires_arc = true
s.version = "0.1.10"

# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.license = { :type => "MIT", :file => "LICENSE" }

# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.author = { "Alberto Aznar" => "info@alberdev.com" }
s.homepage = "https://github.com/alberdev/GridTimerView"

# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source = { :git => "https://github.com/alberdev/GridTimerView.git",
:tag => "#{s.version}" }

# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.framework = "UIKit"
# s.dependency 'Alamofire', '~> 4.7'
# s.dependency 'MBProgressHUD', '~> 1.1.0'

# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source_files = "GridTimerView/**/*.{swift}"

# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.resources = "GridTimerView/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# ――― Swift Version ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.swift_version = "4.2"

end
