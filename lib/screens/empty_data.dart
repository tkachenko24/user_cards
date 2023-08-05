import 'package:user_cards/export.dart';

class EmptyDataScreen extends StatelessWidget {
  const EmptyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Data'),
      ),
      body: const Center(
        child: Text('No data available.'),
      ),
    );
  }
}
