import 'package:dio/dio.dart';

import '../model/result.dart';
import 'api_client.dart';

class ImdbApiClient implements ApiClient {
  /// A client for the IMDB api based on Dio
  /// Works as a facade for the app to handle all requests
  final dio = Dio();

  @override
  Future<List<Result>> search(String title) async {
    title = "*$title*";
    try {
      Response<Map> response = await dio
          .get('http://www.omdbapi.com/?i=tt3896198&apikey=186be766&s=$title');

      return _parseResults(response.data as Map);
    } on Exception catch (_) {
      return [];
    }
  }

  List<Result> _parseResults(Map responseMap) {
    final results = responseMap['Search'];
    if (results == null) return [];

    return results
        .map<Result>((json) => Result(
              title: "${json['Title']} (${json['Year']})",
              id: json['imdbID'],
            ))
        .toList();
  }
}
