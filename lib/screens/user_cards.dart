import 'package:user_cards/export.dart';

class UserCards extends StatelessWidget {
  final UserController _userController = Get.put(UserController());

  UserCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Cards')),
      body: Obx(() {
        if (_userController.usersData.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return PageView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: _userController.usersData.length,
            itemBuilder: (context, index) {
              final userData = _userController.usersData[index];
              final hasInternet = _userController.hasInternet.value;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailCard(user: userData),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.fromLTRB(50, 200, 50, 200),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!hasInternet)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(userData['avatar']),
                        )
                      else
                        const Text("No internet connection"),
                      Text(
                        '${userData['first_name']} ${userData['last_name']}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData['email'],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
