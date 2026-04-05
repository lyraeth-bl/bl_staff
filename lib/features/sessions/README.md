# Sessions

> Manages the user's authentication session lifecycle across the app.

This feature is responsible for persisting, restoring, and clearing the access token
that authorizes API requests. It acts as the single source of truth for whether the
user is currently authenticated, and is consumed at the root of the widget tree to
drive the app's top-level navigation.

---

## Structure

### Data Layer

| File                                               | Role                                                         |
|----------------------------------------------------|--------------------------------------------------------------|
| `data/datasources/sessions_local_data_source.dart` | Reads and writes the access token via `FlutterSecureStorage` |
| `data/repositories/sessions_repository_impl.dart`  | Concrete repository — delegates to the local data source     |
| `data/sessions_data.dart`                          | Barrel export for the data layer                             |

### Domain Layer

| File                                              | Role                                          |
|---------------------------------------------------|-----------------------------------------------|
| `domain/repositories/sessions_repository.dart`    | Abstract contract for session data operations |
| `domain/usecases/get_access_token_use_case.dart`  | Reads the stored token                        |
| `domain/usecases/save_access_token_use_case.dart` | Persists a token after login                  |
| `domain/usecases/clear_session_use_case.dart`     | Removes the token on logout                   |
| `domain/sessions_domain.dart`                     | Barrel export for the domain layer            |

### Presentation Layer

| File                                                  | Role                                                             |
|-------------------------------------------------------|------------------------------------------------------------------|
| `presentation/bloc/sessions_bloc/sessions_bloc.dart`  | BLoC — orchestrates session events and emits states              |
| `presentation/bloc/sessions_bloc/sessions_event.dart` | Sealed events: `started`, `loggedIn`, `loggedOut`                |
| `presentation/bloc/sessions_bloc/sessions_state.dart` | States: `initial`, `loading`, `authenticated`, `unauthenticated` |
| `presentation/sessions_presentation.dart`             | Barrel export for the presentation layer                         |

### Root Files

| File               | Role                                                       |
|--------------------|------------------------------------------------------------|
| `sessions.dart`    | Root barrel — re-exports all three layers                  |
| `sessions_di.dart` | Registers all dependencies as lazy singletons via `get_it` |

---

## Architecture

```
                    App Startup / User Action
                               ↓
                        [SessionsEvent]
                 (started / loggedIn / loggedOut)
                               ↓
                        [SessionsBloc]
                  ↓                          ↓
             [Use Cases]               [TokenProvider]
         (get / save / clear)    (in-memory token for HTTP client)
                               ↓                  
                      [SessionsRepository]
                               ↓
                    [SessionsLocalDataSource]
                               ↓
                       FlutterSecureStorage
```

State management: **BLoC** (`flutter_bloc`) + **fpdart** for `Unit` return types

---

## Key Classes

### `SessionsBloc`

The central state machine for session management. Registered as a lazy singleton
and provided at the app root so all features can observe authentication state.

```dart
// Provide at app root
BlocProvider
(
create: (_) => getIt<SessionsBloc>()..add(const SessionsEvent.started()),
child: MyApp()
);

// Listen for navigation decisions
BlocListener<SessionsBloc, SessionsState>(
listener: (context, state) {
state.when(
initial: () {},
loading: () {},
authenticated: (token) => context.go('RouteNames.dashboard'),
unauthenticated: () => context.go('RouteNames.authLogin'),
);
},
child
:
child
,
);
```

### `SessionsLocalDataSource` / `SessionsLocalDataSourceImpl`

The only layer that touches `FlutterSecureStorage`. The access token is stored
under the key defined by `kAccessTokenKey` in `secure_storage_names.dart`.

### Use Cases

Three focused use cases, each with a single `call()` method:

```dart
// After successful login
await saveAccessTokenUseCase(token);

// On app startup — null means no session
final token = await

getAccessTokenUseCase();

// On logout
await clearSessionUseCase();
```

---

## Dependencies

| Package                  | Purpose                                               |
|--------------------------|-------------------------------------------------------|
| `flutter_bloc`           | BLoC state management                                 |
| `flutter_secure_storage` | Encrypted token storage (Keychain / Keystore)         |
| `shared_preferences`     | Injected for potential non-sensitive session metadata |
| `fpdart`                 | Functional `Unit` type for void-equivalent returns    |
| `freezed`                | Immutable event and state classes                     |
| `get_it`                 | Dependency injection / service locator                |

---

## Usage

Initialize the feature's dependencies at app startup:

```dart
// In your DI setup
await initSessionsDI();
```

Dispatch `started` once at the root to trigger session restoration:

```dart
getIt<SessionsBloc>
().add
(
const
SessionsEvent
.
started
(
)
);
```

After a successful login response, dispatch `loggedIn` with the token:

```dart
context.read<SessionsBloc>
().add
(
SessionsEvent.loggedIn(token: response.accessToken));
```

On logout:

```dart
context.read<SessionsBloc>
().add
(
constSessionsEvent
.
loggedOut
(
)
);
```

---

## Notes

- `clearSession` only removes the local token — server-side session invalidation
  (if required) must be handled by the auth feature before dispatching `loggedOut`.
- `saveAccessToken` silently swallows storage errors and logs via `debugPrint`.
  Consider adding error propagation if token persistence failures need to surface to the UI.
- `SessionsBloc` is a singleton — avoid creating multiple instances, as only one
  `TokenProvider` is updated on login/logout.
