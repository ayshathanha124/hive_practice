import 'package:flutter/material.dart';
import 'package:hiivee_emp/login.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('loginbox');

  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loginpage(),
      debugShowCheckedModeBanner: false,

    );
  }
}