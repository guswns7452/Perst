import 'package:http/http.dart' as http;

@Deprecated("현재 사용하지 않음. 추후에도 사용하지 않으면 삭제 요망")
class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
