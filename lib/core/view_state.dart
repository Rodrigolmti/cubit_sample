enum ViewState { IDLE, LOADING, LOADED, ERROR }

extension ViewStateX on ViewState {
  bool isLoading() => this == ViewState.LOADING;
  bool isIdle() => this == ViewState.IDLE;
  bool hasError() => this == ViewState.ERROR;
  bool hasData() => this == ViewState.LOADED;
}