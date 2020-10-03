import 'package:meta/meta.dart';

import 'cubit.dart';
import 'transition.dart';

class CubitObserver {
  @mustCallSuper
  void onTransition(Cubit cubit, Transition transition) {}
}
