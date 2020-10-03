import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../cubit_core/cubit_stream.dart';

typedef CreateCubit<T extends CubitStream<dynamic>> = T Function(
  BuildContext context,
);

mixin CubitProviderSingleChildWidget on SingleChildWidget {}

class CubitProvider<T extends CubitStream<Object>>
    extends SingleChildStatelessWidget with CubitProviderSingleChildWidget {
  CubitProvider({
    @required CreateCubit<T> create,
    Key key,
    Widget child,
    bool lazy,
  }) : this._(
          key: key,
          create: create,
          dispose: (_, cubit) => cubit?.close(),
          child: child,
          lazy: lazy,
        );

  CubitProvider.value({
    @required T value,
    Key key,
    Widget child,
  }) : this._(
          key: key,
          create: (_) => value,
          child: child,
        );
  CubitProvider._({
    @required Create<T> create,
    Key key,
    Dispose<T> dispose,
    this.child,
    this.lazy,
  })  : _create = create,
        _dispose = dispose,
        super(key: key, child: child);

  final Widget child;
  final bool lazy;

  final Dispose<T> _dispose;

  final Create<T> _create;

  static T of<T extends CubitStream<Object>>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } on ProviderNotFoundException catch (e) {
      if (e.valueType != T) {
        rethrow;
      }
      throw FlutterError(
        '''
        CubitProvider.of() called with a context that does not contain a Cubit of type $T.
        No ancestor could be found starting from the context that was passed to CubitProvider.of<$T>().

        This can happen if the context you used comes from a widget above the CubitProvider.

        The context used was: $context
        ''',
      );
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget child) =>
      InheritedProvider<T>(
        create: _create,
        dispose: _dispose,
        child: child,
        lazy: lazy,
      );
}

extension CubitProviderExtension on BuildContext {
  C cubit<C extends CubitStream<Object>>() => CubitProvider.of<C>(this);
}
