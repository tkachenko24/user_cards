import 'package:http/http.dart' as http;
import 'package:user_cards/export.dart';

class UserController extends GetxController {
  var usersData = <Map<String, dynamic>>[].obs;
  var hasInternet = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    checkInternetConnection();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        usersData.value = List<Map<String, dynamic>>.from(data['data']);
        saveUsersDataToLocal(usersData);
      } else {
        fetchUsersDataFromLocal();
      }
    } catch (e) {
      fetchUsersDataFromLocal();
    }
  }

  Future<void> fetchUsersDataFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String usersDataString = prefs.getString('usersData') ?? '';
    if (usersDataString.isNotEmpty) {
      List<dynamic> data = jsonDecode(usersDataString);
      usersData.value = List<Map<String, dynamic>>.from(data);
    }
  }

  void saveUsersDataToLocal(RxList<Map<String, dynamic>> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('usersData');
    prefs.setString('usersData', jsonEncode(data.toList()));
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    hasInternet.value = connectivityResult != ConnectivityResult.none;
  }
}
