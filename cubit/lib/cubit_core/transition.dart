import 'package:meta/meta.dart';

@immutable
class Transition<State> {
  const Transition({@required this.currentState, @required this.nextState});

  final State currentState;

  final State nextState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transition<State> &&
          runtimeType == other.runtimeType &&
          currentState == other.currentState &&
          nextState == other.nextState;

  @override
  int get hashCode => currentState.hashCode ^ nextState.hashCode;

  @override
  String toString() =>
      'Transition { currentState: $currentState, nextState: $nextState }';
}
