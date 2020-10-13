# UpdateInfoPresenter [![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg)](https://github.com/apple/swift-package-manager) [![CocoaPods](https://img.shields.io/cocoapods/v/UpdateInfoPresenter.svg?style=flat)](http://cocoapods.org/pods/UpdateInfoPresenter) ![License](https://img.shields.io/github/license/malt03/UpdateInfoPresenter.svg)

UpdateInfoPresenter is a library that allows you to properly present the specified UIViewController to users who have updated the version of your app.

## Usage

### Present
If you implement the following code, the specified viewController will be displayed when the app is launched, if necessary.  
If you pass nil to the viewController argument, UpdateInfoPresenter will not present anything, but it will check and save the version.  
The saved version will be used the next time you pass a value other than nil to the viewController.

```swift
func sceneDidBecomeActive(_ scene: UIScene) {
    UpdateInfoPresenter.presentIfNeeded(
        viewController: UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "UpdateInfo"),
        targetVersion: 1,
        presentingOption: [.newUser, .skippedUser]
    )
}
```

### Dismiss
UpdateInfoPresenter creates a special window and displays a viewController on it.  
To dismiss it, call the following method.
```swift
UpdateInfoPresenter.dismiss()
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
