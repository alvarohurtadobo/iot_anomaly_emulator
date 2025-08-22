# ESP32 Anomaly Detector

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]


---

## Install ESPRESSIF software in Mac



Instalar las dependencias
El esp-idf utiliza algunas dependencias como cmake y ninja para la compilación de proyectos, las dependencias varían dependiendo del sistema operativo, pero en Unix se recomiendan las siguientes: cmake ninja dfu-util

Por lo tanto, podemos instalarlas con el siguiente comando:
```sh
brew install git cmake ninja dfu-util python3@3.10
```

make sure you have Xcode installed otherwise install with:
```sh
xcode-select --install
```

En caso de que surja algún mensaje de error de compatibilidad o al instalar el software, puedes asegurarte primero actualizar tu sistema con: /usr/sbin/softwareupdate --install-rosetta --agree-to-license, y luego volver a intentar con la instalación.

Create a virtual environment, in my case I use Anaconda and python 3.10

```sh
conda install --name espcom python=3.10
```

Inside a directory of your preference clone the ESPRESSIF repo, in my case use 4.4.2:

```sh
git clone -b v4.4.2 --recursive https://github.com/espressif/esp-idf.git
```

Get inside that directory and run:

```sh
. ./install.sh
```

Whenever you want to use this elements you must run this on your terminal:
```sh
. ~/esp/esp-idf/export.sh 
```

If you want to run it automatically, you can add it to your .zshrc:
```sh
alias get_idf='. ~/esp/esp-idf/export.sh'
```

En caso de tener problemas con la version de cmake, uno puede instalar la version correspondiente a la version 4.4.2 y seleccionarla con los siguientes comandos, en mi caso la instalada era cmake version 4.0.3

```sh
brew install cmake@3.23
brew unlink cmake
brew link cmake@3.23
```



## Running Tests

To run all unit and widget tests use the following command:

```sh
$ very_good test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
