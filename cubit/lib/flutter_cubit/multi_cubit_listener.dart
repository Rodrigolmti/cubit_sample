import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'cubit_listener.dart';

class MultiCubitListener extends MultiProvider {
  MultiCubitListener({
    @required List<CubitListenerSingleChildWidget> listeners,
    @required Widget child,
    Key key,
  })  : assert(listeners != null),
        assert(child != null),
        super(key: key, providers: listeners, child: child);
}
