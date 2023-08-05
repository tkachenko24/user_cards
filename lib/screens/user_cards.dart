import 'package:user_cards/export.dart';

class UserCards extends StatelessWidget {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    print(_userController.checkInternetConnection());
    print(_userController.hasInternet.value);
    print(_userController.isLoading.value);
    // print(_userController.hasInternet.value);
    return Obx(() {
      if (_userController.isLoading.value) {
        return Scaffold(
          appBar: AppBar(title: const Text('User Cards')),
          body: const Center(child: CircularProgressIndicator()),
        );
      } else {
        if (_userController.hasInternet.value) {
          if (_userController.hasData.value) {
            return Scaffold(
              appBar: AppBar(title: const Text('User Cards')),
              body: ListView.builder(
                itemCount: _userController.usersData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCard(
                            user: _userController.usersData[index],
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          _userController.usersData[index]['avatar']),
                    ),
                    title: Text(
                        '${_userController.usersData[index]['first_name']} ${_userController.usersData[index]['last_name']}'),
                    subtitle: Text(_userController.usersData[index]['email']),
                  );
                },
              ),
            );
          } else {
            return EmptyDataScreen();
          }
        } else {
          return NoConnectionScreen(
            onRetry: () async {
              await _userController.checkInternetConnection();
              print(_userController.hasInternet);
            },
          );
        }
      }
    });
  }
}
