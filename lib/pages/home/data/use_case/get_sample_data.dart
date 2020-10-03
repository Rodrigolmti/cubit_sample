import 'package:arch_sample/core/app_result.dart';
import 'package:arch_sample/pages/home/data/repository/home_repository.dart';
import 'package:arch_sample/pages/home/data/model/sample_data.dart';
import 'package:injectable/injectable.dart';

abstract class GetSampleDataUseCase {
  Future<Result<SampleData>> call();
}

@Injectable(as: GetSampleDataUseCase)
class GetSampleData implements GetSampleDataUseCase {
  final HomeRepository _repository;

  const GetSampleData(this._repository);

  @override
  Future<Result<SampleData>> call() => _repository.getSampleData();
}
