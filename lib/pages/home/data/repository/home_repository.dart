import 'package:arch_sample/core/app_result.dart';
import 'package:arch_sample/pages/home/data/data_source/home_remote_data_source.dart';
import 'package:arch_sample/pages/home/data/model/sample_data.dart';
import 'package:injectable/injectable.dart';

abstract class HomeRepository {
  Future<Result<SampleData>> getSampleData();
}

@LazySingleton(as: HomeRepository)
class HomeDefaultRepository implements HomeRepository {
  final HomeRemoteDataSource _dataSource;

  const HomeDefaultRepository(this._dataSource);

  @override
  Future<Result<SampleData>> getSampleData() => _dataSource.getSampleData();
}
