import 'dart:async';

import 'package:meta/meta.dart';

abstract class CubitStream<State> extends Stream<State> {
  CubitStream(this._state);

  State get state => _state;

  final _controller = StreamController<State>.broadcast();

  State _state;

  @protected
  void emit(State state) {
    if (state == _state || _controller.isClosed) {
      return;
    }
    _state = state;
    _controller.add(_state);
  }

  @override
  StreamSubscription<State> listen(
    void Function(State) onData, {
    Function onError,
    void Function() onDone,
    bool cancelOnError,
  }) => _stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );

  @override
  bool get isBroadcast => _controller.stream.isBroadcast;

  @mustCallSuper
  Future<void> close() async {
    await _controller.close();
    await _controller.stream.drain<State>();
  }

  Stream<State> get _stream async* {
    yield state;
    yield* _controller.stream;
  }
}
