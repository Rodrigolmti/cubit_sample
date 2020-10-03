// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../pages/home/data/use_case/get_sample_data.dart';
import '../pages/home/data/data_source/home_remote_data_source.dart';
import '../pages/home/data/repository/home_repository.dart';

/// Environment names
const _mock = 'mock';
const _prod = 'prod';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<HomeRemoteDataSource>(() => HomeRemoteFakeDataSource(),
      registerFor: {_mock});
  gh.factory<HomeRemoteDataSource>(() => HomeRemoteDefaultDataSource(),
      registerFor: {_prod});
  gh.lazySingleton<HomeRepository>(
      () => HomeDefaultRepository(get<HomeRemoteDataSource>()));
  gh.factory<GetSampleDataUseCase>(() => GetSampleData(get<HomeRepository>()));
  return get;
}
