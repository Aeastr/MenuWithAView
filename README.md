<div align="center">
  <img width="128" height="128" src="/assets/icon.png" alt="MenuWithAView Icon">
  <h1><b>MenuWithAView</b></h1>
  <p>
    Add accessory views to context menu interactions using UIKit's private _UIContextMenuAccessoryView.
  </p>
</div>

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-6.0+-F05138?logo=swift&logoColor=white" alt="Swift 6.0+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/iOS-16+-000000?logo=apple" alt="iOS 16+"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT"></a>
  <img src="https://img.shields.io/badge/Status-Experimental-orange.svg" alt="Experimental">
</p>

> [!WARNING]
> This package uses a private API (`_UIContextMenuAccessoryView`) which may be unstable and could change or break in future iOS releases. Use with caution. App Store submissions are at your own risk.

<div align="center">
  <img src="/assets/example1.gif" alt="MenuWithAView demo" width="300">
</div>


## Overview

- Attach custom accessory views to any `.contextMenu`
- Control placement, location, alignment, and tracking axis
- Programmatic dismissal via `ContextMenuProxy`
- DocC documentation included


## Installation

```swift
dependencies: [
    .package(url: "https://github.com/Aeastr/MenuWithAView.git", from: "1.0.0")
]
```

```swift
import MenuWithAView
```

Or in Xcode: **File > Add Packages…** and enter `https://github.com/Aeastr/MenuWithAView`


## Usage

### Basic Usage

```swift
Text("Turtle Rock")
    .padding()
    .contextMenu {
        Button(action: {}) {
            Label("Button", systemImage: "circle")
        }
    }
    .contextMenuAccessory(
        placement: .center,
        location: .preview,
        alignment: .leading,
        trackingAxis: .yAxis
    ) {
        Text("Accessory View")
            .font(.title2)
            .padding(8)
            .background(Color.blue.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(16)
    }
```

### With Programmatic Dismissal

```swift
Text("Turtle Rock")
    .padding()
    .contextMenu {
        Button(action: {}) {
            Label("Button", systemImage: "circle")
        }
    }
    .contextMenuAccessory(placement: .center) { proxy in
        VStack {
            Text("Accessory View")
                .font(.title2)

            Button("Dismiss") {
                proxy.dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color.blue.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
```


## Customization

### Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `placement` | Where the accessory attaches relative to the context menu | `.center` |
| `location` | Where the accessory appears | `.preview` |
| `alignment` | How the accessory aligns within its container | `.leading` |
| `trackingAxis` | Axis along which the accessory tracks user interaction | `[.xAxis, .yAxis]` |

The `accessory` view builder has two variants:
- Simple: `@ViewBuilder accessory: () -> AccessoryView`
- With proxy: `@ViewBuilder accessory: (ContextMenuProxy) -> AccessoryView`


## How It Works

MenuWithAView wraps UIKit's private `_UIContextMenuAccessoryView` API, discovered and documented by [@sebjvidal](https://sebvidal.com/blog/accessorise-your-context-menu-interactions/).

Since this relies on private APIs, behavior may change between iOS versions. The package is provided for experimentation and learning purposes.


## Contributing

Contributions welcome. See the [Contributing Guide](CONTRIBUTING.md) for details.


## License

MIT. See [LICENSE](LICENSE.md) for details.
