#
#  Be sure to run `pod spec lint GridTimerView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.platform = :ios
s.ios.deployment_target = '11.4'
s.name = "GridTimerView"
s.summary = "GridTimerView shows a schedule with timer controller. Each cell can manage multiple events. Used for listing TV programs shows in a table."
s.requires_arc = true
s.version = "0.1.7"

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
