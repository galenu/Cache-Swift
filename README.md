# Cache-Swift

[![CI Status](https://img.shields.io/travis/galenu/Cache-Swift.svg?style=flat)](https://travis-ci.org/galenu/Cache-Swift)
[![Version](https://img.shields.io/cocoapods/v/Cache-Swift.svg?style=flat)](https://cocoapods.org/pods/Cache-Swift)
[![License](https://img.shields.io/cocoapods/l/Cache-Swift.svg?style=flat)](https://cocoapods.org/pods/Cache-Swift)
[![Platform](https://img.shields.io/cocoapods/p/Cache-Swift.svg?style=flat)](https://cocoapods.org/pods/Cache-Swift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Cache-Swift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Cache-Swift'
```

```
        HMCache.appCache.setObject(true, forKey: .NightListening.isShowdNightListeningGuide)
        
        let isShowdNightListeningGuide = HMCache.appCache.object(forKey: .NightListening.isShowdNightListeningGuide, type: Bool.self)
        
        print("isShowdNightListeningGuide: \(isShowdNightListeningGuide)")
```

## Author

galenu, 250167616@qq.com

## License

Cache-Swift is available under the MIT license. See the LICENSE file for more info.
