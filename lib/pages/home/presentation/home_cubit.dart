import 'package:arch_sample/core/view_state.dart';
import 'package:arch_sample/di/injection.dart';
import 'package:arch_sample/pages/home/data/use_case/get_sample_data.dart';
import 'package:arch_sample/pages/home/presentation/home_view_state.dart';
import 'package:cubit/cubit.dart';

class HomeCubit extends Cubit<HomeViewState> {
  final GetSampleDataUseCase _getSampleDataUseCase = getIt();
  final HomeViewState viewState;

  HomeCubit({this.viewState = const HomeViewState()}) : super(viewState);

  Future<void> getSampleData() async {
    emit(viewState.copyWith(state: ViewState.LOADING));
    final result = await _getSampleDataUseCase();
    result.onResult(
      (value) => {
        emit(
          viewState.copyWith(
            state: ViewState.LOADED,
            sampleData: value,
          ),
        )
      },
      (failure) => {
        emit(
          viewState.copyWith(
            state: ViewState.ERROR,
          ),
        )
      },
    );
  }
}
