import 'package:http/http.dart' as http;
import 'package:user_cards/export.dart';

class UserController extends GetxController {
  var hasInternet = false.obs;
  var hasData = false.obs;

  var usersData = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    hasInternet.value = connectivityResult != ConnectivityResult.none;

    if (hasInternet.value) {
      await fetchUsersDataFromApi();
      if (usersData.isNotEmpty) {
        hasData.value = true;
      } else {
        hasData.value = false;
      }
    } else {
      final String usersDataString = prefs.getString('usersData') ?? '';
      hasData.value = usersDataString.isNotEmpty;
      if (hasData.value) {
        await fetchUsersDataFromLocal();
      }
    }
    isLoading.value = false;
  }

  Future<void> fetchUsersDataFromApi() async {
    try {
      final response =
          await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        usersData.value = List<Map<String, dynamic>>.from(data['data']);

        saveUsersDataToLocal(usersData);
        hasData.value = true;
      } else {
        hasData.value = false;
      }
    } catch (e) {
      hasData.value = false;
    }
  }

  Future<void> fetchUsersDataFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String usersDataString = prefs.getString('usersData') ?? '';
    if (usersDataString.isNotEmpty) {
      List<dynamic> data = jsonDecode(usersDataString);
      usersData.value = List<Map<String, dynamic>>.from(data);
      hasData.value = true;
    } else {
      hasData.value = false;
    }
  }

  void saveUsersDataToLocal(RxList<Map<String, dynamic>> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('usersData');
    prefs.setString('usersData', jsonEncode(data.toList()));
  }
}
