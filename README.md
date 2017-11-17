**Build status**

master: 
[![Build Status](https://travis-ci.org/grangej/TimeZonePicker.svg?branch=master)](https://travis-ci.org/grangej/TimeZonePicker)
dev:
[![Build Status](https://travis-ci.org/grangej/TimeZonePicker.svg?branch=dev)](https://travis-ci.org/grangej/TimeZonePicker)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/RxViewModel.svg?style=flat)](https://github.com/grangej/TimeZonePicker)
[![Platform](https://img.shields.io/cocoapods/p/RxViewModel.svg?style=flat)](https://github.com/grangej/TimeZonePicker)
# TimeZonePicker
Localized iOS TimeZone datasource and picker control

Fully localized timezone datasource and picker control, ready to integrate into iOS project.

### Requires
- swif4
- iOS 11
- XCode 9

## Usage

To run the example project, clone the repo.

## Install

### Carthage

Just add the following to your [`Cartfile`](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile)

```swift
github "grangej/TimeZonePicker"
```

And run:

```console
carthage update
```
### CocoaPods

> CocoaPods 1.1.0+ is required to build TimeZonePicker 

To add TimeZonePicker to your project using CocoaPods, specify it your 
[`Podfile`](https://guides.cocoapods.org/using/the-podfile.html)

```ruby

platform :ios, '11.0'

target 'TargetName' do
	pod 'TimeZonePicker', '~> 1.1.0'
end
```

And run:

```console
pod install
```

## Features

Currently `TimeZonePicker` has the following features:

- [x] `DataSource for use in custom ViewController`
- [x] `ViewController for use directly in your app`
- [x] `Fully localized in Japanese`
- [x] `Localization in other languages`
- [ ] `Fully unit tested`

## Author

__John Grange__ 

- [`John Grange`](https://johngrange.sd-networks.net) 
- :email: john@sd-networks.net

## License

TimeZonePicker is available under the MIT license. See the LICENSE file for more info.

