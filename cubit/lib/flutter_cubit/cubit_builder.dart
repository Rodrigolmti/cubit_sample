import 'dart:async';
import 'package:flutter/widgets.dart';

import '../cubit_core/cubit_stream.dart';
import 'cubit_provider.dart';

typedef CubitWidgetBuilder<S> = Widget Function(BuildContext context, S state);

typedef CubitBuilderCondition<S> = bool Function(S previous, S current);

class CubitBuilder<C extends CubitStream<S>, S> extends CubitBuilderBase<C, S> {
  const CubitBuilder({
    @required this.builder,
    Key key,
    C cubit,
    CubitBuilderCondition<S> buildWhen,
  })  : assert(builder != null),
        super(key: key, cubit: cubit, buildWhen: buildWhen);

  final CubitWidgetBuilder<S> builder;

  @override
  Widget build(BuildContext context, S state) => builder(context, state);
}

abstract class CubitBuilderBase<C extends CubitStream<S>, S>
    extends StatefulWidget {
  const CubitBuilderBase({Key key, this.cubit, this.buildWhen})
      : super(key: key);

  final C cubit;

  final CubitBuilderCondition<S> buildWhen;

  Widget build(BuildContext context, S state);

  @override
  State<CubitBuilderBase<C, S>> createState() => _CubitBuilderBaseState<C, S>();
}

class _CubitBuilderBaseState<C extends CubitStream<S>, S>
    extends State<CubitBuilderBase<C, S>> {
  StreamSubscription<S> _subscription;
  S _previousState;
  S _state;
  C _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = widget.cubit ?? context.cubit<C>();
    _previousState = _cubit?.state;
    _state = _cubit?.state;
    _subscribe();
  }

  @override
  void didUpdateWidget(CubitBuilderBase<C, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldCubit = oldWidget.cubit ?? context.cubit<C>();
    final currentCubit = widget.cubit ?? oldCubit;
    if (oldCubit != currentCubit) {
      if (_subscription != null) {
        _unsubscribe();
        _cubit = widget.cubit ?? context.cubit<C>();
        _previousState = _cubit?.state;
        _state = _cubit?.state;
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _state);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (_cubit != null) {
      _subscription = _cubit.skip(1).listen((state) {
        if (widget.buildWhen?.call(_previousState, state) ?? true) {
          setState(() {
            _state = state;
          });
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
