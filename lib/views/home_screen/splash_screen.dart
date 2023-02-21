import 'package:fresh_om_seller/views/auth_screen/Admin_verification_screen.dart';
import 'package:fresh_om_seller/views/auth_screen/login_screen.dart';
import 'package:fresh_om_seller/views/home_screen/main_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fresh_om_seller/const/const.dart';
import '../../utils/reusable_big_text.dart';
import '../../utils/reusable_text.dart';
import '../../widgets/reusable_small_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool('isLogged');
    var isVerified = sharedPref.getBool('isVerified');
    if (isLoggedIn != null || isVerified != null) {
      if (isLoggedIn == true && isVerified == true) {
        Future.delayed(const Duration(seconds: 3),
            () => Get.offAll(() => const MainHome()));
      } else if (isVerified == false) {
        Future.delayed(const Duration(seconds: 3),
            () => Get.offAll(() => const VerificationScreen()));
      } else {
        Future.delayed(const Duration(seconds: 3),
            () => Get.offAll(() => const MainLoginPage()));
      }
    } else {
      Future.delayed(const Duration(seconds: 3),
          () => Get.offAll(() => const MainLoginPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height300,
            ),
            // Container(
            //   height: Dimensions.height120,
            //   width: Dimensions.width50 * 2,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(Dimensions.radius30),
            //           topRight: Radius.circular(Dimensions.radius30)),
            //       color: Colors.white70,
            //       image: DecorationImage(
            //           image: AssetImage('images/logoMain1.png'))),
            // ),

            Image.asset(
              'images/logoMain1.png',
              height: 140,
            ),
            SizedBox(
              height: Dimensions.height10,
            ),

            appNameText(
                text: 'Fresh\'Om',
                color: mainAppColor,
                size: 30.0,
                fontWeight: FontWeight.w500),
            appNameText(
                text: 'Seller',
                color: mainAppColor,
                size: 25.0,
                fontWeight: FontWeight.w500),
            // BoldText(
            //   fontWeight: FontWeight.bold,
            //   text: "Fresh'Om",
            //   color: AppColors.mainAppColor,
            //   size: Dimensions.fontSize30,
            // ),
            SizedBox(
              height: Dimensions.height10,
            ),
            SmallText(
              text: "version 1.0.0",
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
