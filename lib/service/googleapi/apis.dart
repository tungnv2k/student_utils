import 'package:googleapis/calendar/v3.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

CalendarApi calendarApi;

void getApiAccess(var authHeaders) {
  var client = GoogleHttpClient(authHeaders);

  calendarApi = new CalendarApi(client);
}

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}
