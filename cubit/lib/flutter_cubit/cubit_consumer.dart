import 'package:flutter/widgets.dart';

import '../cubit_core/cubit_stream.dart';
import 'cubit_builder.dart';
import 'cubit_listener.dart';
import 'cubit_provider.dart';

class CubitConsumer<C extends CubitStream<S>, S> extends StatelessWidget {
  const CubitConsumer({
    @required this.builder,
    @required this.listener,
    Key key,
    this.cubit,
    this.buildWhen,
    this.listenWhen,
  })  : assert(builder != null),
        assert(listener != null),
        super(key: key);

  final C cubit;

  final CubitWidgetBuilder<S> builder;

  final CubitWidgetListener<S> listener;

  final CubitBuilderCondition<S> buildWhen;

  final CubitListenerCondition<S> listenWhen;

  @override
  Widget build(BuildContext context) {
    final cubit = this.cubit ?? context.cubit<C>();
    return CubitListener<C, S>(
      cubit: cubit,
      listener: listener,
      listenWhen: listenWhen,
      child: CubitBuilder<C, S>(
        cubit: cubit,
        builder: builder,
        buildWhen: buildWhen,
      ),
    );
  }
}
