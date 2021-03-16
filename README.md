![Swift Version](https://img.shields.io/badge/Swift-5.0-blue)
![Cocoapods platforms](https://img.shields.io/badge/platform-iOS-red)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

# TextAttributes
<br />
<p align="left">
    A library for constructing and modifying NSAttributedStrings
</p>

## Requirements

- iOS 12.1+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `TextAttributes` by adding it to your `Podfile`:

```ruby
platform :ios, '12.1'
use_frameworks!
pod 'TextAttributes', :git => 'git@github.com:joeypatino/textattributes.git'
```

## Usage example

#### Example One

``` swift
import TextAttributes

let label = UILabel()
let string = "hello world"
let attributedString = string.attributed().mutable
attributedString.addAttribute(.foregroundColor(.red))
attributedString.addAttribute(.font(.boldSystemFont(ofSize: 32.0)))
attributedString.addAttribute(.kern(2.0))
label.attributedText = attributedString
```
<br />
<p align="center">
  <img height="60" src="repository_assets/example_one.png" />
</p>

#### Example Two

``` swift
import TextAttributes

let label = UILabel()
let string = "hello world"
let attrs = [TextAttribute.foregroundColor(.red), .font(.boldSystemFont(ofSize: 32.0)), .kern(2.0)] 
attributedString.addAttributes(attrs, toOccurencesOfString: "hello")
label.attributedText = attributedString
```
<br />
<p align="center">
  <img height="60" src="repository_assets/example_two.png" />
</p>

#### Example Three

``` swift
import TextAttributes

let label = UILabel()
let string = "hello world"
let attributedString = string.attributed().mutable
attributedString.addAttribute(.foregroundColor(.red))
attributedString.addAttribute(.font(.boldSystemFont(ofSize: 32.0)))
attributedString.removeAttribute(.foregroundColor, fromOccurencesOfString: "o wor")
label.attributedText = attributedString
```
<br />
<p align="center">
  <img height="60" src="repository_assets/example_three.png" />
</p>

<br />
<br />

See `TextAttribute.swift`, `NSAttributedString.swift`, `NSMutableAttributedString.swift` for documentation details. 
You can also find a demo app TextAttributesDemo included in the repo.

### Meta

Joey Patino – [@nsinvalidarg](https://twitter.com/nsinvalidarg) – joey.patino@protonmail.com

Distributed under the MIT license
