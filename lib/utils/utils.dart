import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

export 'shared/constant.dart';
export 'shared/entities/sessions_token_entity/sessions_token_entity.dart';
export 'shared/extension/extension.dart';
export 'shared/mappers/mappers.dart';
export 'shared/models/sessions_token_model/sessions_token_model.dart';
export 'shared/types/types.dart';

class Utils {
  static Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceName = "Unknown";

    if (kIsWeb) {
      // Handle web platform
      final webInfo = await deviceInfo.webBrowserInfo;
      deviceName = webInfo.appName ?? "Web Browser";
    } else if (Platform.isAndroid) {
      // Handle Android platform
      final androidInfo = await deviceInfo.androidInfo;
      // Combine manufacturer and model for a more descriptive name
      deviceName = "${androidInfo.manufacturer} ${androidInfo.model}";
    } else if (Platform.isIOS) {
      // Handle iOS platform
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    } else if (Platform.isLinux) {
      // Handle Linux platform
      final linuxInfo = await deviceInfo.linuxInfo;
      deviceName = linuxInfo.name;
    } else if (Platform.isMacOS) {
      // Handle macOS platform
      final macOsInfo = await deviceInfo.macOsInfo;
      deviceName = macOsInfo.computerName;
    } else if (Platform.isWindows) {
      // Handle Windows platform
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceName = windowsInfo.computerName;
    }

    return deviceName;
  }
}
