// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sessions_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionsEvent implements DiagnosticableTreeMixin {


  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SessionsEvent'))
    ;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SessionsEvent);
  }


  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'SessionsEvent()';
  }


}

/// @nodoc
class $SessionsEventCopyWith<$Res> {
  $SessionsEventCopyWith(SessionsEvent _, $Res Function(SessionsEvent) __);
}


/// Adds pattern-matching-related methods to [SessionsEvent].
extension SessionsEventPatterns on SessionsEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  {

  TResult

  Function

  (

  _Started

  value

  )

  ?

  started

  ,

  TResult

  Function

  (

  _LoggedIn

  value

  )

  ?

  loggedIn

  ,

  TResult

  Function

  (

  _LoggedOut

  value

  )

  ?

  loggedOut

  ,

  required

  TResult

  orElse

  (

  )

  ,
}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoggedIn() when loggedIn != null:
return loggedIn(_that);case _LoggedOut() when loggedOut != null:
return loggedOut(_that);case _:
return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs
TResult map<TResult extends Object?>(
    {required TResult Function( _Started value) started, required TResult Function( _LoggedIn value) loggedIn, required TResult Function( _LoggedOut value) loggedOut,}) {
  final _that = this;
  switch (_that) {
    case _Started():
      return started(_that);
    case _LoggedIn():
      return loggedIn(_that);
    case _LoggedOut():
      return loggedOut(_that);
    case _:
      throw StateError('Unexpected subclass');
  }
}

/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs
TResult? mapOrNull<TResult extends Object?>(
    {TResult? Function( _Started value)? started, TResult? Function( _LoggedIn value)? loggedIn, TResult? Function( _LoggedOut value)? loggedOut,}) {
  final _that = this;
  switch (_that) {
    case _Started() when started != null:
      return started(_that);
    case _LoggedIn() when loggedIn != null:
      return loggedIn(_that);
    case _LoggedOut() when loggedOut != null:
      return loggedOut(_that);
    case _:
      return null;
  }
}

/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen
<
TResult extends Object?>(
{
TResult
Function
(
)
?
started
,
TResult
Function
(
String
token
)
?
loggedIn
,
TResult
Function
(
)
?
loggedOut
,
required
TResult
orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoggedIn() when loggedIn != null:
return loggedIn(_that.token);case _LoggedOut() when loggedOut != null:
return loggedOut();case _:
return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function() started,required TResult Function( String token) loggedIn,required TResult Function() loggedOut,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoggedIn():
return loggedIn(_that.token);case _LoggedOut():
return loggedOut();case _:
throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()? started,TResult? Function( String token)? loggedIn,TResult? Function()? loggedOut,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoggedIn() when loggedIn != null:
return loggedIn(_that.token);case _LoggedOut() when loggedOut != null:
return loggedOut();case _:
return null;

}
}

}

/// @nodoc


class _Started with DiagnosticableTreeMixin implements SessionsEvent {
const _Started();


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsEvent.started'))
;
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsEvent.started()';
}


}


/// @nodoc


class _LoggedIn with DiagnosticableTreeMixin implements SessionsEvent {
const _LoggedIn({required this.token});


final String token;

/// Create a copy of SessionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoggedInCopyWith<_LoggedIn> get copyWith => __$LoggedInCopyWithImpl<_LoggedIn>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsEvent.loggedIn'))
..add(DiagnosticsProperty('token', token));
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedIn&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsEvent.loggedIn(token: $token)';
}


}

/// @nodoc
abstract mixin class _$LoggedInCopyWith<$Res> implements $SessionsEventCopyWith<$Res> {
factory _$LoggedInCopyWith(_LoggedIn value, $Res Function(_LoggedIn) _then) = __$LoggedInCopyWithImpl;
@useResult
$Res call({
String token
});


}
/// @nodoc
class __$LoggedInCopyWithImpl<$Res>
implements _$LoggedInCopyWith<$Res> {
__$LoggedInCopyWithImpl(this._self, this._then);

final _LoggedIn _self;
final $Res Function(_LoggedIn) _then;

/// Create a copy of SessionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
return _then(_LoggedIn(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
));
}


}

/// @nodoc


class _LoggedOut with DiagnosticableTreeMixin implements SessionsEvent {
const _LoggedOut();


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsEvent.loggedOut'))
;
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsEvent.loggedOut()';
}


}


/// @nodoc
mixin _$SessionsState implements DiagnosticableTreeMixin {


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsState'))
;
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsState()';
}


}

/// @nodoc
class $SessionsStateCopyWith<$Res> {
$SessionsStateCopyWith(SessionsState _, $Res Function(SessionsState) __);
}


/// Adds pattern-matching-related methods to [SessionsState].
extension SessionsStatePatterns on SessionsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)? initial,TResult Function( _Loading value)? loading,TResult Function( _FirstTime value)? firstTime,TResult Function( _Authenticated value)? authenticated,TResult Function( _Unauthenticated value)? unauthenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _FirstTime() when firstTime != null:
return firstTime(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _:
return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value) initial,required TResult Function( _Loading value) loading,required TResult Function( _FirstTime value) firstTime,required TResult Function( _Authenticated value) authenticated,required TResult Function( _Unauthenticated value) unauthenticated,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _FirstTime():
return firstTime(_that);case _Authenticated():
return authenticated(_that);case _Unauthenticated():
return unauthenticated(_that);case _:
throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)? initial,TResult? Function( _Loading value)? loading,TResult? Function( _FirstTime value)? firstTime,TResult? Function( _Authenticated value)? authenticated,TResult? Function( _Unauthenticated value)? unauthenticated,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _FirstTime() when firstTime != null:
return firstTime(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _:
return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()? initial,TResult Function()? loading,TResult Function()? firstTime,TResult Function( String accessToken, bool isRefreshing)? authenticated,TResult Function()? unauthenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _FirstTime() when firstTime != null:
return firstTime();case _Authenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.isRefreshing);case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _:
return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function() initial,required TResult Function() loading,required TResult Function() firstTime,required TResult Function( String accessToken, bool isRefreshing) authenticated,required TResult Function() unauthenticated,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _FirstTime():
return firstTime();case _Authenticated():
return authenticated(_that.accessToken,_that.isRefreshing);case _Unauthenticated():
return unauthenticated();case _:
throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()? initial,TResult? Function()? loading,TResult? Function()? firstTime,TResult? Function( String accessToken, bool isRefreshing)? authenticated,TResult? Function()? unauthenticated,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _FirstTime() when firstTime != null:
return firstTime();case _Authenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.isRefreshing);case _Unauthenticated() when unauthenticated != null:
return unauthenticated();case _:
return null;

}
}

}

/// @nodoc


class _Initial with DiagnosticableTreeMixin implements SessionsState {
const _Initial();


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsState.initial'))
;
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsState.initial()';
}


}


/// @nodoc


class _Loading with DiagnosticableTreeMixin implements SessionsState {
const _Loading();


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsState.loading'))
;
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsState.loading()';
}


}


/// @nodoc


class _FirstTime with DiagnosticableTreeMixin implements SessionsState {
const _FirstTime();


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsState.firstTime'))
;
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirstTime);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsState.firstTime()';
}


}


/// @nodoc


class _Authenticated with DiagnosticableTreeMixin implements SessionsState {
const _Authenticated({required this.accessToken, this.isRefreshing = false});


final String accessToken;
@JsonKey() final bool isRefreshing;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsState.authenticated'))
..add(DiagnosticsProperty('accessToken', accessToken))..add(DiagnosticsProperty('isRefreshing', isRefreshing));
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,isRefreshing);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsState.authenticated(accessToken: $accessToken, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $SessionsStateCopyWith<$Res> {
factory _$AuthenticatedCopyWith(_Authenticated value, $Res Function(_Authenticated) _then) = __$AuthenticatedCopyWithImpl;
@useResult
$Res call({
String accessToken, bool isRefreshing
});


}
/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
implements _$AuthenticatedCopyWith<$Res> {
__$AuthenticatedCopyWithImpl(this._self, this._then);

final _Authenticated _self;
final $Res Function(_Authenticated) _then;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? isRefreshing = null,}) {
return _then(_Authenticated(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
));
}


}

/// @nodoc


class _Unauthenticated with DiagnosticableTreeMixin implements SessionsState {
const _Unauthenticated();


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
properties
..add(DiagnosticsProperty('type', 'SessionsState.unauthenticated'))
;
}

@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
return 'SessionsState.unauthenticated()';
}


}


// dart format on
