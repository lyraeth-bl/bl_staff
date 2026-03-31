import 'package:bl_staff/core/app_router/app_router_di.dart';
import 'package:bl_staff/core/storage/storage_di.dart';

Future<void> setupLocator() async {
  initAppRouterDI();
  await initStorageDI();
}
