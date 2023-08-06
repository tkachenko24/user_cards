import 'package:user_cards/export.dart';

class UserCards extends StatelessWidget {
  final UserController _userController = Get.put(UserController());

  UserCards({super.key});

  @override
  Widget build(BuildContext context) {
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
                body: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _userController.usersData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCard(
                                user: _userController.usersData[index]),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(50, 200, 50, 200),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  _userController.usersData[index]['avatar']),
                            ),
                            Text(
                              '${_userController.usersData[index]['first_name']} ${_userController.usersData[index]['last_name']}',
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _userController.usersData[index]['email'],
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ));
          } else {
            return NoConnectionScreen(
              onRetry: () async {
                _userController.fetchUsersDataFromLocal();
              },
            );
          }
        } else {
          return NoConnectionScreen(
            onRetry: () async {
              await _userController.checkInternetConnection();
              _userController.hasInternet.value
                  ? null
                  : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Turn on internet and try again")));
            },
          );
        }
      }
    });
  }
}
