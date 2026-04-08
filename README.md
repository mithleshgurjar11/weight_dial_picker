# Weight Dial Picker

<p align="center">
  <img src="https://raw.githubusercontent.com/mithleshgurjar11/weight_dial_picker/main/assets/preview.gif" width="320"/>
</p>

<p align="center">
  <a href="https://pub.dev/packages/weight_dial_picker">
    <img src="https://img.shields.io/pub/v/weight_dial_picker?color=blue&label=pub.dev" alt="Pub Version"/>
  </a>
  <a href="https://github.com/mithleshgurjar11/weight_dial_picker/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/mithleshgurjar11/weight_dial_picker" alt="License"/>
  </a>
  <a href="https://github.com/mithleshgurjar11/weight_dial_picker/stargazers">
    <img src="https://img.shields.io/github/stars/mithleshgurjar11/weight_dial_picker?style=social" alt="Stars"/>
  </a>
</p>

<p align="center">
  A beautiful and customizable weight picker widget for Flutter with smooth dial interaction and kg/lb support.
</p>

---

## ✨ Features

- 🎯 Smooth animated dial interaction
- 🔄 kg / lb unit toggle
- 🎨 Fully customizable UI
- 📱 Easy to integrate
- ⚡ Lightweight with no extra dependencies

---

## 🖼 Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/mithleshgurjar11/weight_dial_picker/main/assets/screenshot1.png" width="220"/>
  &nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/mithleshgurjar11/weight_dial_picker/main/assets/screenshot2.png" width="220"/>
</p>

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  weight_dial_picker: ^0.0.4
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Usage

Import the package:

```dart
import 'package:weight_dial_picker/weight_dial_picker.dart';
```

Use the widget:

```dart
WeightDialPicker(
  initialWeight: 70,
  unit: 'kg',
  onChanged: (value, unit) {
    print("Selected: $value $unit");
  },
)
```

---

## ⚙️ Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `initialWeight` | `double` | `70` | Starting weight value |
| `unit` | `String` | `'kg'` | Unit type — `'kg'` or `'lb'` |
| `onChanged` | `Function(double, String)` | required | Callback on value change |

---

## 🌐 Repository

👉 [github.com/mithleshgurjar11/weight_dial_picker](https://github.com/mithleshgurjar11/weight_dial_picker)

---

## 🤝 Contributing

Contributions are welcome!
Feel free to open an [issue](https://github.com/mithleshgurjar11/weight_dial_picker/issues) or submit a pull request.

---

## 🧑‍💻 Author

**Mithlesh Gurjar**
Flutter Developer · [GitHub](https://github.com/mithleshgurjar11)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).