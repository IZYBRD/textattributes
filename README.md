![Swift Version](https://img.shields.io/badge/Swift-5.0-blue)
![Cocoapods platforms](https://img.shields.io/badge/platform-iOS-red)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)


## TextAttributes

TextAttributes is a Swift library that simplifies the creation and modification of NSAttributedStrings. Its intuitive, strongly typed API enables easy creation of rich text with attributes such as bold, italic, underlined, colored text and more.

### Features

- Simple, intuitive, and strongly typed API for building complex text attributes
- Easy application of text attributes such as font, color, kerning, and more
- Customizable paragraph styles, including indentation, line spacing, and alignment

### Requirements

- iOS 12.0+
- Swift 5.0+

## Installation

#### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `TextAttributes` by adding it to your `Podfile`:

```ruby
platform :ios, '12.0'
use_frameworks!
pod 'TextAttributes', :git => 'git@github.com:joeypatino/textattributes.git'
```

Then, run the `pod install` command to install the library.

## Usage

Here's are some examples of how to use TextAttributes:

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


## Contributing

Contributions to TextAttributes are welcome! If you find a bug or would like to make an improvement, please report it on the project's GitHub page at https://github.com/joeypatino/textattributes.

### Meta

Joey Patino – [@nsinvalidarg](https://twitter.com/nsinvalidarg) – joey.patino@pm.me

### License

TextAttributes is released under the MIT License. See the LICENSE file for details.
