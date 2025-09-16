<div align="center">
  <img width="270" height="270" src="/assets/icon.png" alt="MenuWithAView Logo">
  <h1><b>MenuWithAView</b></h1>
  <p>
    MenuWithAView is a SwiftUI package that lets you add accessory views to your context menu interactions, with UIKit's private _UIContextMenuAccessoryView.
    <br>
    <i>Compatible with iOS 16 and later</i>
  </p>
</div>

<div align="center">
  <a href="https://swift.org">
<!--     <img src="https://img.shields.io/badge/Swift-6.0%20%7C%206-orange.svg" alt="Swift Version"> -->
    <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift Version">
  </a>
  <a href="https://www.apple.com/ios/">
     <img src="https://img.shields.io/badge/iOS-16%2B-blue.svg" alt="iOS">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT">
  </a>
</div>

## **Demo**

![Example](/assets/example1.gif)

---

## contextMenuAccessory

`contextMenuAccessory` is a SwiftUI modifier that lets you attach an accessory view to a `.contextMenu`. You can control the accessory's placement, location, alignment, and tracking axis. There are two variants: one for simple accessory views and another that provides a `ContextMenuProxy` for programmatic dismissal.

**DocC documentation is available for this modifier.**

### Parameters

- `placement`: Where the accessory is attached relative to the context menu.
  *(Default: `.center`)*
- `location`: The location where the accessory appears.
  *(Default: `.preview`)*
- `alignment`: How the accessory aligns within its container.
  *(Default: `.leading`)*
- `trackingAxis`: The axis along which the accessory tracks user interaction.
  *(Default: `[.xAxis, .yAxis]`)*
- `accessory`: A view builder that receives a `ContextMenuProxy` and returns the accessory view.

### Examples

#### Basic Usage

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

#### With Programmatic Dismissal

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

---

## **Acknowledgments**

Special thanks to [@sebjvidal](https://github.com/sebjvidal) for [writing about  _UIContextMenuAccessoryView](https://sebvidal.com/blog/accessorise-your-context-menu-interactions/), and helping with the development of this package!

## License

This project is released under the MIT License. See [LICENSE](LICENSE.md) for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. Before you begin, take a moment to review the [Contributing Guide](CONTRIBUTING.md) for details on issue reporting, coding standards, and the PR process.

## Support

If you like this project, please consider giving it a ⭐️

---

## Where to find us

|         | Aether | Seb |
|---------|----------------|------------------|
| Twitter | [@AetherAurelia](https://x.com/AetherAurelia) |  [@SebJVidal](https://x.com/SebJVidal) |
| Threads | [@aetheraurelia](https://www.threads.net/@aetheraurelia) | - |
| Bluesky | [aethers.world](https://bsky.app/profile/aethers.world) | - |
| LinkedIn| [aether](https://www.linkedin.com/in/willjones24) | - |
| GitHub  | here, obviously | here!! |
| Website | - | [sebvidal.com](https://sebvidal.com/) |


---

<p align="center">Built with 🍏🕵️🤝👜 by Aether and Seb</p>
