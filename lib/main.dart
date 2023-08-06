import 'package:user_cards/export.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final UserController userController = UserController();
  runApp(UsersApp(userController: userController));
}

class UsersApp extends StatelessWidget {
  final UserController userController;

  const UsersApp({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User cards',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => UserCards()),
        GetPage(
          name: '/detail',
          page: () => const DetailCard(user: {}),
        ),
        GetPage(
          name: '/no_connection',
          page: () => NoConnectionScreen(
            onRetry: () {},
          ),
        ),
        GetPage(name: '/empty_data', page: () => const EmptyDataScreen()),
      ],
    );
  }
}
