import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/single_child_widget.dart';

import '../cubit_core/cubit_stream.dart';
import 'cubit_provider.dart';

mixin CubitListenerSingleChildWidget on SingleChildWidget {}

typedef CubitWidgetListener<S> = void Function(BuildContext context, S state);

typedef CubitListenerCondition<S> = bool Function(S previous, S current);

class CubitListener<C extends CubitStream<S>, S> extends CubitListenerBase<C, S>
    with CubitListenerSingleChildWidget {

  const CubitListener({
    @required CubitWidgetListener<S> listener,
    Key key,
    C cubit,
    CubitListenerCondition<S> listenWhen,
    this.child,
  })  : assert(listener != null),
        super(
          key: key,
          child: child,
          listener: listener,
          cubit: cubit,
          listenWhen: listenWhen,
        );

  @override
  // ignore: overridden_fields
  final Widget child;
}

abstract class CubitListenerBase<C extends CubitStream<S>, S>
    extends SingleChildStatefulWidget {
  const CubitListenerBase({
    Key key,
    this.listener,
    this.cubit,
    this.child,
    this.listenWhen,
  }) : super(key: key, child: child);

  final Widget child;

  final C cubit;

  final CubitWidgetListener<S> listener;

  final CubitListenerCondition<S> listenWhen;

  @override
  SingleChildState<CubitListenerBase<C, S>> createState() =>
      _CubitListenerBaseState<C, S>();
}

class _CubitListenerBaseState<C extends CubitStream<S>, S>
    extends SingleChildState<CubitListenerBase<C, S>> {
  StreamSubscription<S> _subscription;
  S _previousState;
  C _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = widget.cubit ?? context.cubit<C>();
    _previousState = _cubit?.state;
    _subscribe();
  }

  @override
  void didUpdateWidget(CubitListenerBase<C, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldCubit = oldWidget.cubit ?? context.cubit<C>();
    final currentCubit = widget.cubit ?? oldCubit;
    if (oldCubit != currentCubit) {
      if (_subscription != null) {
        _unsubscribe();
        _cubit = widget.cubit ?? context.cubit<C>();
        _previousState = _cubit?.state;
      }
      _subscribe();
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget child) => child;

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (_cubit != null) {
      _subscription = _cubit.skip(1).listen((state) {
        if (widget.listenWhen?.call(_previousState, state) ?? true) {
          widget.listener(context, state);
        }
        _previousState = state;
      });
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }
}
