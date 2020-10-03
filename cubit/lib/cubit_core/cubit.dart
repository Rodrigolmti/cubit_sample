import 'package:meta/meta.dart';

import 'cubit_observer.dart';
import 'cubit_stream.dart';
import 'transition.dart';

abstract class Cubit<State> extends CubitStream<State> {
  Cubit(State initialState) : super(initialState);

  static CubitObserver observer = CubitObserver();

  @mustCallSuper
  void onTransition(Transition<State> transition) {
    observer.onTransition(this, transition);
  }

  @override
  void emit(State state) {
    onTransition(Transition<State>(currentState: this.state, nextState: state));
    super.emit(state);
  }
}
