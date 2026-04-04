import 'package:bl_staff/bl_staff.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  initAuthDI();
  initSessionsDI();

  Bloc.observer = const AppBlocObserver();
}
