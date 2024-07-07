# Flutter geofencing plugin

The Flutter geofencing plugin is built following the federated plugin architecture. A detailed explanation of the federated plugin concept can be found in the [Flutter documentation](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins). This means the geofencing plugin is separated into the following packages:

1. [`yak_geofencing`][1]: the app facing package. This is the package users depend on to use the plugin in their project. For details on how to use the [`yak_geofencing`][1] plugin you can refer to its [README.md][2] file.
2. [`yak_geofencing_android`][3]: this package contains the endorsed Android implementation of the geofencing_platform_interface and adds Android support to the [`yak_geofencing`][1] app facing package. More information can be found in its [README.md][4] file;
3. [`yak_geofencing_apple`][5]: this package contains the endorsed iOS and macOS implementations of the geofencing_platform_interface and adds iOS support to the [`yak_geofencing`][1] app facing package. More information can be found in its [README.md][6] file;
6. [`yak_geofencing_platform_interface`][7]: this package declares the interface which all platform packages must implement to support the app-facing package. Instructions on how to implement a platform package can be found in the [README.md][8] of the [`yak_geofencing_platform_interface`][11] package.

[1]: ./yak_geofencing
[2]: ./yak_geofencing/README.md
[3]: ./yak_geofencing_android
[4]: ./yak_geofencing_android/README.md
[5]: ./yak_geofencing_apple
[6]: ./yak_geofencing_apple/README.md
[7]: ./yak_geofencing_platform_interface
[8]: ./yak_geofencing_platform_interface/README.md
