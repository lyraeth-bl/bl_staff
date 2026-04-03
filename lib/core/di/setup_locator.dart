import 'package:bl_staff/core/api/api_client/api_client_di.dart';
import 'package:bl_staff/core/api/network/network_di.dart';
import 'package:bl_staff/core/api/token_provider/token_provider.dart';
import 'package:bl_staff/core/app_router/app_router_di.dart';
import 'package:bl_staff/core/storage/storage_di.dart';
import 'package:bl_staff/features/sessions/presentation/bloc/sessions_bloc/sessions_bloc.dart';
import 'package:bl_staff/utils/shared/constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> setupLocator() async {
  await dotenv.load(fileName: ".env");

  String _resolveBaseUrl() {
    final base =
        dotenv.env['BASE_URL'] ?? (throw Exception('BASE_URL not found'));
    return '${base.replaceAll(RegExp(r'/+$'), '')}/api/v1';
  }

  initAppRouterDI();
  await initStorageDI();
  initTokenDI();
  initNetworkDI(
    baseUrl: _resolveBaseUrl(),
    tokenProvider: () => getIt<TokenProvider>().getToken(),
    onUnauthorized: () async {
      getIt<TokenProvider>().clearToken();
      getIt<SessionsBloc>().add(const SessionsEvent.loggedOut());
    },
  );
  initApiClientDI();
}
