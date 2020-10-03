import 'package:arch_sample/core/app_failures.dart';
import 'package:arch_sample/core/app_result.dart';
import 'package:arch_sample/environments/main_mock.dart';
import 'package:arch_sample/environments/main_prod.dart';
import 'package:arch_sample/pages/home/data/model/sample_data.dart';
import 'package:injectable/injectable.dart';

abstract class HomeRemoteDataSource {
  Future<Result<SampleData>> getSampleData();
}

@mockEnv
@Injectable(as: HomeRemoteDataSource)
class HomeRemoteFakeDataSource implements HomeRemoteDataSource {
  @override
  Future<Result<SampleData>> getSampleData() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      return const Result(
          data: SampleData(
        name: 'Rodrigo',
        lastName: 'Martins',
        document: '235345433',
      ));
    } catch (error) {
      return Result(failure: MockFailure());
    }
  }
}

@prodEnv
@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDefaultDataSource implements HomeRemoteDataSource {
  @override
  Future<Result<SampleData>> getSampleData() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 3));
      return const Result(
          data: SampleData(
        name: 'Rodrigo',
        lastName: 'Martins',
        document: '235345433',
      ));
    } catch (error) {
      return Result(failure: NetworkFailure());
    }
  }
}
