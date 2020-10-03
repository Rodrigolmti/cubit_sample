import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'cubit_provider.dart';

class MultiCubitProvider extends MultiProvider {
  MultiCubitProvider({
    @required List<CubitProviderSingleChildWidget> providers,
    @required Widget child,
    Key key,
  })  : assert(providers != null),
        assert(child != null),
        super(key: key, providers: providers, child: child);
}
