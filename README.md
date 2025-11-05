# Emulador de Anomalías IoT

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

## 📋 Descripción

Emulador de Anomalías IoT es una aplicación Flutter diseñada para emular dispositivos industriales IoT y generar datos de sensores en tiempo real. La aplicación permite simular diferentes tipos de procesos industriales, visualizar datos de sensores mediante gráficos y publicar la información mediante el protocolo MQTT.

## ✨ Características Principales

- **Emulación de Dispositivos Industriales**: Simula múltiples dispositivos industriales (DeMag, Arc Solder, Hornos Industriales, etc.)
- **Múltiples Tipos de Procesos**: Soporta tres tipos de procesos diferentes:
  - **Vibraciones**: Genera datos de vibración, temperatura y presión
  - **Análisis de Aceite**: Simula calidad de aceite, nivel de contaminantes y acidez
  - **Horas Operadas**: Genera datos de horas de operación, historial de mantenimiento y carga
- **Visualización en Tiempo Real**: Gráficos interactivos que muestran la evolución de los parámetros de sensores
- **Integración MQTT**: Publica datos de sensores a un broker MQTT para integración con sistemas externos
- **Gestión de Estado**: Control del estado de los dispositivos (encendido/apagado)
- **Interfaz Multilingüe**: Soporte para español e inglés
- **Múltiples Entornos**: Configuración para desarrollo, staging y producción

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework multiplataforma
- **Riverpod**: Gestión de estado reactiva
- **GoRouter**: Navegación y enrutamiento
- **MQTT Client**: Cliente MQTT para publicación de datos
- **FL Chart**: Gráficos y visualización de datos
- **Flutter Localizations**: Internacionalización

## 📦 Instalación

### Requisitos Previos

- Flutter SDK (versión 3.8.0 o superior)
- Dart SDK
- Un editor de código (VS Code, Android Studio, etc.)

### Pasos de Instalación

1. Clona el repositorio:
```sh
git clone <url-del-repositorio>
cd iot_anomaly_emulator
```

2. Instala las dependencias:
```sh
flutter pub get
```

3. Ejecuta la aplicación:
```sh
# Desarrollo
flutter run -t lib/main_development.dart

# Staging
flutter run -t lib/main_staging.dart

# Producción
flutter run -t lib/main_production.dart
```

## 🚀 Uso de la Aplicación

### Navegación

La aplicación cuenta con las siguientes secciones:

- **Inicio**: Página principal de la aplicación
- **Dispositivos**: Lista de todos los dispositivos emulados disponibles
- **Detalle del Dispositivo**: Vista detallada de un dispositivo específico con:
  - Selección del tipo de proceso
  - Control del estado del dispositivo
  - Visualización de parámetros en tiempo real
  - Gráficos históricos de los sensores
- **Configuración**: Ajustes de la aplicación

### Tipos de Procesos

#### 1. Vibraciones
Genera datos simulados de:
- **Vibración**: Señal sinusoidal con ruido gaussiano
- **Temperatura**: Correlacionada con la vibración
- **Presión**: Relacionada con el cuadrado de la vibración

#### 2. Análisis de Aceite
Simula parámetros de calidad de aceite:
- **Calidad del Aceite**: Valores uniformes con degradación temporal
- **Nivel de Contaminantes**: Correlacionado con la calidad del aceite
- **Acidez**: Relacionada con la raíz cúbica de la calidad

#### 3. Horas Operadas
Genera datos de operación:
- **Horas Operadas**: Distribución exponencial con incremento temporal
- **Historial de Mantenimiento**: Distribución de Poisson
- **Carga**: Valores normales con tendencia temporal

### Configuración MQTT

La aplicación está configurada para publicar datos al broker MQTT público `broker.emqx.io` en el puerto 1883. Los datos se publican en el tópico:

```
flutter/sensors/{device_id}
```

El formato del mensaje JSON es:
```json
{
  "device": "Nombre del dispositivo",
  "timestamp": "2025-01-01T12:00:00.000Z",
  "parametro1": valor1,
  "parametro2": valor2,
  ...
}
```

Para cambiar la configuración del broker MQTT, edita el archivo `lib/home/repository/mqtt_core.dart`.

## 🧪 Ejecución de Pruebas

Para ejecutar todas las pruebas unitarias y de widgets:

```sh
very_good test --coverage --test-randomize-ordering-seed random
```

Para visualizar el reporte de cobertura generado, puedes usar [lcov](https://github.com/linux-test-project/lcov):

```sh
# Generar reporte de cobertura
genhtml coverage/lcov.info -o coverage/

# Abrir reporte de cobertura
open coverage/index.html
```

## 🌐 Trabajando con Traducciones

Este proyecto utiliza [flutter_localizations][flutter_localizations_link] y sigue la [guía oficial de internacionalización para Flutter][internationalization_link].

### Agregar Cadenas de Texto

1. Para agregar una nueva cadena localizable, abre el archivo `app_es.arb` en `lib/l10n/arb/app_es.arb`.

```arb
{
    "@@locale": "es",
    "nuevaCadena": "Nuevo Texto",
    "@nuevaCadena": {
        "description": "Descripción del nuevo texto"
    }
}
```

2. Agrega también la traducción en inglés en `app_en.arb`:

```arb
{
    "@@locale": "en",
    "nuevaCadena": "New Text",
    "@nuevaCadena": {
        "description": "Description of the new text"
    }
}
```

3. Usa la nueva cadena en el código:

```dart
import 'package:iot_anomaly_emulator/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.nuevaCadena);
}
```

### Agregar Idiomas Soportados

Actualiza el array `CFBundleLocalizations` en `Info.plist` en `ios/Runner/Info.plist` para incluir el nuevo idioma.

```xml
<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
    <string>es</string>
</array>
```

### Generar Traducciones

Para usar los últimos cambios de traducción, necesitarás generarlos:

1. Genera las localizaciones para el proyecto actual:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternativamente, ejecuta `flutter run` y la generación de código se realizará automáticamente.

## 📱 Dispositivos Emulados

La aplicación incluye los siguientes dispositivos predefinidos:

1. **DeMag400** - Tipo: IMM, Proceso: Horas Operadas
2. **Arc Solder** - Tipo: ARC, Proceso: Análisis de Aceite
3. **DeMag300** - Tipo: Otro, Proceso: Vibraciones
4. **DeMag400** - Tipo: IMM, Proceso: Horas Operadas
5. **Industrial Oven** - Tipo: IMM, Proceso: Análisis de Aceite
6. **Industrial fridge** - Tipo: Otro, Proceso: Vibraciones

Los dispositivos pueden ser configurados en `lib/devices/model/device.dart`.

## 📊 Generación de Datos

Los datos de sensores se generan usando distribuciones estadísticas:

- **Distribución Normal**: Para valores con ruido gaussiano (Box-Muller)
- **Distribución Exponencial**: Para valores con distribución exponencial
- **Distribución de Poisson**: Para conteos discretos
- **Distribución Uniforme**: Para valores aleatorios uniformes

Los datos se actualizan cada segundo y se publican automáticamente al broker MQTT cuando el dispositivo está encendido.

## 🔧 Configuración de Entornos

El proyecto incluye tres entornos de ejecución:

- **Development** (`main_development.dart`): Para desarrollo local
- **Staging** (`main_staging.dart`): Para pruebas en un entorno de staging
- **Production** (`main_production.dart`): Para producción

Cada entorno puede tener configuraciones específicas según sea necesario.

## 📝 Estructura del Proyecto

```
lib/
├── app/                    # Configuración de la aplicación
├── bootstrap.dart          # Inicialización de la aplicación
├── common/                 # Componentes comunes
│   ├── constants/          # Constantes
│   ├── providers/          # Proveedores comunes
│   ├── routes.dart         # Configuración de rutas
│   ├── view/               # Vistas comunes
│   └── widgets/            # Widgets reutilizables
├── devices/                # Módulo de dispositivos
│   ├── model/              # Modelos de datos
│   ├── providers/          # Proveedores de estado
│   └── view/               # Vistas de dispositivos
├── home/                   # Módulo principal
│   ├── providers/          # Proveedores MQTT
│   ├── repository/         # Repositorio MQTT
│   └── view/               # Vistas principales
├── l10n/                   # Internacionalización
│   ├── arb/                # Archivos de traducción
│   └── gen/                # Código generado
└── settings/               # Módulo de configuración
    └── view/               # Vista de configuración
```

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo LICENSE para más detalles.

---

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
