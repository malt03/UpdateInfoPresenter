Pod::Spec.new do |s|
  s.name             = 'UpdateInfoPresenter'
  s.version          = '0.0.2'
  s.summary          = 'presenting update info'

  s.description      = <<-DESC
UpdateInfoPresenter is a library that allows you to properly present the specified UIViewController to users who have updated the version of your app.
                       DESC

  s.homepage         = 'https://github.com/malt03/UpdateInfoPresenter'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Koji Murata' => 'malt.koji@gmail.com' }
  s.source           = { git: 'https://github.com/malt03/UpdateInfoPresenter.git', tag: "v#{s.version}" }

  s.source_files = "Sources/**/*.swift"

  s.swift_version = "5.3"
  s.ios.deployment_target = "9.0"
end
