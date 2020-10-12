# UpdateInfoPresenter [![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg)](https://github.com/apple/swift-package-manager) [![CocoaPods](https://img.shields.io/cocoapods/v/UpdateInfoPresenter.svg?style=flat)](http://cocoapods.org/pods/UpdateInfoPresenter) ![License](https://img.shields.io/github/license/malt03/UpdateInfoPresenter.svg)

UpdateInfoPresenter is a library that allows you to properly present the specified UIViewController to users who have updated the version of your app.

## Usage
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UpdateInfoPresenter.configure(
        targetVersion: 3,
        presentingOption: [.newUser, .skippedUser],
        viewController: UIStoryboard(name: "UpdateInfo", bundle: .main).instantiateInitialViewController()!
    )
    return true
}
```

## Conditional Branching with presentingOption
target version = 3

### .empty
|previous|current|present|
|:--|:--|:--|
|nil|2||
|nil|3||
|nil|4||
|1|2||
|1|3|✔|
|1|4||
|3|3||
|3|4||

### .newUser
|previous|current|present|
|:--|:--|:--|
|nil|2||
|nil|3|✔|
|nil|4||
|1|2||
|1|3|✔|
|1|4||
|3|3||
|3|4||

### .skippedUser
|previous|current|present|
|:--|:--|:--|
|nil|2||
|nil|3||
|nil|4||
|1|2||
|1|3|✔|
|1|4|✔|
|3|3||
|3|4||

### [.newUser, .skippedUser]
|previous|current|present|
|:--|:--|:--|
|nil|2||
|nil|3|✔|
|nil|4|✔|
|1|2||
|1|3|✔|
|1|4|✔|
|3|3||
|3|4||
