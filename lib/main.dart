import 'package:firebase_core/firebase_core.dart';
import 'package:fresh_om_seller/views/auth_screen/login_screen.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/views/home_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const SplashScreen(), //
    );
  }
}
