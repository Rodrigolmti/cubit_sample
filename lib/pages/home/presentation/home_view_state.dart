import 'package:arch_sample/core/view_state.dart';
import 'package:arch_sample/pages/home/data/model/sample_data.dart';

class HomeViewState {
  final SampleData sampleData;
  final ViewState state;

  bool get hasData => state.hasData();

  const HomeViewState({
    this.sampleData,
    this.state = ViewState.IDLE,
  });

  HomeViewState copyWith({
    SampleData sampleData,
    ViewState state,
  }) =>
      HomeViewState(
        sampleData: sampleData ?? this.sampleData,
        state: state ?? this.state,
      );
}
