import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/auth/auth_di.dart';
import '../../features/features.dart';
import '../../features/sessions/sessions_di.dart';
import '../../features/user/user_di.dart';
import '../../utils/utils_export.dart';
import '../api/api_client/api_client_di.dart';
import '../api/network/network_di.dart';
import '../api/token_provider/token_provider.dart';
import '../app/app_bloc_observer.dart';
import '../app_router/app_router_di.dart';
import '../storage/storage_di.dart';

String _resolveBaseUrl() {
  final base =
      dotenv.env['BASE_URL_SERVER'] ??
      (throw Exception('BASE_URL_SERVER not found'));
  return '${base.replaceAll(RegExp(r'/+$'), '')}/api/v1';
}

Future<void> setupLocator() async {
  await dotenv.load(fileName: ".env");

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
  initAuthDI();
  initSessionsDI();
  initUserDI();

  Bloc.observer = const AppBlocObserver();
}
