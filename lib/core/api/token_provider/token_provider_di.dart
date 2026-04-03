part of 'token_provider.dart';

Future<void> initTokenDI() async {
  getIt.registerLazySingleton<TokenProvider>(
    () => TokenProviderImpl(getIt<SessionsLocalDataSource>()),
  );
}
