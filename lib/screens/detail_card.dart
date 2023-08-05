import 'package:user_cards/export.dart';

class DetailCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const DetailCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ID: ${user['id']}'),
              const SizedBox(height: 8),
              Text('Name: ${user['first_name']} ${user['last_name']}'),
              const SizedBox(height: 8),
              Text('Email: ${user['email']}'),
              const SizedBox(height: 8),
              CircleAvatar(
                backgroundImage: NetworkImage(user['avatar']),
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
