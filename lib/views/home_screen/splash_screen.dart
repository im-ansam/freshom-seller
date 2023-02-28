import 'package:fresh_om_seller/controllers/profile_controller.dart';
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
  var controller = Get.put(ProfileController());
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
  initState() {
    super.initState();
    changeScreen();
    controller.profileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackGround,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.heightBox,
            Image.asset(
              'images/freshLogo.png',
              height: Dimensions.height120,
            ),
            Dimensions.height20.heightBox,
            appNameText(
                color: nicePurple,
                size: Dimensions.fontSize25,
                fontWeight1: FontWeight.w500,
                fontWeight2: FontWeight.w700),

            BigText(
              text: 'Seller',
              fontWeight: FontWeight.w700,
              color: nicePurple,
              size: Dimensions.fontSize18,
            ),
            Dimensions.height10.heightBox,
            // BoldText(
            //   fontWeight: FontWeight.bold,
            //   text: "Fresh'Om",
            //   color: AppColors.mainAppColor,
            //   size: Dimensions.fontSize30,
            // ),

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
