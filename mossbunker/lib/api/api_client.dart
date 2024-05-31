import '../model/result.dart';

abstract class ApiClient {
  Future<List<Result>> search(String title);
}
