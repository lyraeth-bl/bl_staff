import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Dispatches an event to a [Bloc] and waits for a specific state condition to be met.
///
/// This utility is typically used with a [RefreshIndicator] to convert the asynchronous
/// event-driven nature of a [Bloc] into a [Future]. It reads the [Bloc] of type [B]
/// from the [context], adds the [event], and completes the returned [Future] when
/// [isDone] returns true for a new state.
///
/// Returns a [Future] that completes when the refresh operation is finished.
Future<void> blocRefresh<B extends Bloc<E, S>, E, S>({
  required BuildContext context,
  required E event,
  required bool Function(S state) isDone,
}) async {
  final completer = Completer<void>();
  final bloc = context.read<B>();

  bloc.add(event);

  late StreamSubscription<S> sub;
  sub = bloc.stream.listen((state) {
    if (isDone(state)) {
      completer.complete();
      sub.cancel();
    }
  });

  return completer.future;
}

/// Same as [blocRefresh] but for cubit.
Future<void> cubitRefresh<C extends Cubit<S>, S>({
  required BuildContext context,
  required void Function(C cubit) trigger,
  required bool Function(S state) isDone,
}) async {
  final completer = Completer<void>();
  final cubit = context.read<C>();

  trigger(cubit);

  late StreamSubscription<S> sub;
  sub = cubit.stream.listen((state) {
    if (isDone(state)) {
      completer.complete();
      sub.cancel();
    }
  });

  return completer.future;
}
