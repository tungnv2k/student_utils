import 'package:googleapis/calendar/v3.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:student_utils_app/screens/login_success_screen.dart';
import 'package:student_utils_app/service/login/sign_in.dart';

Future<Map<String, String>> getApiAccess() async {
  var authHeaders = await googleSignIn.currentUser.authHeaders;
  var client = AutoRefreshClient(authHeaders);

  calendarApi = new CalendarApi(client);
  return authHeaders;
}

Future<Map<String, String>> refreshClient() async {
  await googleSignIn.currentUser.clearAuthCache();
  expiry = DateTime.now().add(Duration(minutes: 55)).toUtc();
  return await getApiAccess();
}

class AutoRefreshClient extends IOClient {
  Map<String, String> _headers;

  AutoRefreshClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) {
    var tokenExpired = DateTime.now().toUtc().isAfter(expiry.toUtc());
    if (tokenExpired) {
      refreshClient().then((headers) {
        return super.send(request..headers.addAll(headers));
      });
    } else {
      return super.send(request..headers.addAll(_headers));
    }
  }
}
