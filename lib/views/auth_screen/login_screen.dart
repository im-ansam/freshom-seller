import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/auth_controller.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/auth_screen/Admin_verification_screen.dart';
import 'package:fresh_om_seller/views/auth_screen/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/reusable_big_text.dart';
import '../home_screen/main_home.dart';
import 'package:google_fonts/google_fonts.dart';

bool isLoading = false;

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({Key? key}) : super(key: key);

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  bool isSignUpScreen = true;
  bool isRememberMe = true;
  bool isObscure = true;
  var controller = Get.put(AuthController());
  var profileController = Get.put(ProfileController());
  var signUpeEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();
  var signUpConfirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height:
            isSignUpScreen ? Dimensions.height167 : Dimensions.height100 * 2,
        child: Column(
          children: [
            Image.asset(freshLogo, height: Dimensions.height70),
            Dimensions.height10.heightBox,
            appNameText(
              letterSpacing1: 0.0,
              letterSpacing2: 0.0,
              fontWeight1: FontWeight.w500,
              fontWeight2: FontWeight.w700,
              size: Dimensions.fontSize23,
              color: nicePurple,
            ),
            BigText(
              letterSpace: 0.0,
              text: "Seller",
              fontWeight: FontWeight.w600,
              color: nicePurple,
              size: Dimensions.fontSize16,
            ),
          ],
        ),
      ),
      backgroundColor: lightBlue1,
      body: Stack(
        alignment: Alignment.center,
        children: [
          //top background color
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height100, left: Dimensions.width20),
                height: Dimensions.height300,
                color: mainAppColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: isSignUpScreen ? "Welcome to" : "Welcome",
                              style: GoogleFonts.poppins(
                                  fontSize: Dimensions.fontSize25,
                                  color: Colors.white,
                                  letterSpacing: 1),
                              children: [
                                TextSpan(
                                    text: isSignUpScreen
                                        ? " Fresh'Om,"
                                        : " Back,",
                                    style: GoogleFonts.poppins(
                                      fontSize: Dimensions.fontSize30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ))
                              ]),
                        ),
                      ],
                    ),
                    isSignUpScreen
                        ? BigText(
                            text: "Signup to Continue",
                            fontWeight: FontWeight.w600,
                            letterSpace: 1,
                            color: Colors.white54,
                            size: Dimensions.fontSize18,
                          )
                        : BigText(
                            text: "SignIn to Continue",
                            fontWeight: FontWeight.w600,
                            letterSpace: 1,
                            color: Colors.white54,
                            size: Dimensions.fontSize18,
                          )
                  ],
                ),
              )),
          buildBottomHalfContainer(true),
          //center main container
          AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              // curve: Curves.bounceInOut,
              top: isSignUpScreen
                  ? Dimensions.height90 * 2
                  : Dimensions.height230,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                // curve: Curves.bounceInOut,
                padding: EdgeInsets.all(Dimensions.height25),
                height: isSignUpScreen
                    ? Dimensions.height402
                    : Dimensions.height300 - Dimensions.height10,
                width: Dimensions.screenWidth - Dimensions.height40,
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: Dimensions.radius15,
                          spreadRadius: 5)
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignUpScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                BigText(
                                  text: "LOGIN",
                                  fontWeight: FontWeight.bold,
                                  color: isSignUpScreen
                                      ? inactiveTextColor
                                      : nicePurple,
                                  size: Dimensions.fontSize20,
                                ),
                                if (!isSignUpScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: Dimensions.height55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignUpScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                BigText(
                                  text: "SIGNUP",
                                  fontWeight: FontWeight.bold,
                                  color: isSignUpScreen
                                      ? nicePurple
                                      : inactiveTextColor,
                                  size: Dimensions.fontSize20,
                                ),
                                if (isSignUpScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: Dimensions.height55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSignUpScreen) buildSignupContainer(),
                      if (!isSignUpScreen) buildLoginContainer()
                    ],
                  ),
                ),
              )),

          //bottom proceed button

          buildBottomHalfContainer(false),
        ],
      ),
    );
  }

  Container buildLoginContainer() {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height20),
      child: Column(
        children: [
          buildTextField(Icons.email_outlined, "Email", false, true,
              controller.emailController),
          buildTextField(Icons.lock, "Password", true, false,
              controller.passwordController),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.to(() => const ResetPassword());
              },
              child: BigText(
                text: "Forgot Password?",
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                size: Dimensions.fontSize15,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildSignupContainer() {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height20),
      child: Column(
        children: [
          buildTextField(
              Icons.person, "User name", false, false, nameController),
          buildTextField(Icons.email_outlined, "Email", false, true,
              signUpeEmailController),
          TextFormField(
            controller: signUpPasswordController,
            obscureText: isObscure ? true : false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: Dimensions.width5),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: inactiveTextColor,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(Dimensions.radius35)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(Dimensions.radius35)),
                hintText: "Password",
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: isObscure ? inactiveTextColor : mainAppColor,
                ).onTap(() {
                  setState(() {
                    if (isObscure == false) {
                      isObscure = true;
                    } else {
                      isObscure = false;
                    }
                  });
                }),
                hintStyle: TextStyle(
                    fontSize: Dimensions.fontSize15, color: inactiveTextColor)),
          ),
          8.heightBox,
          buildTextField(Icons.password, "Confirm Password", true, false,
              signUpConfirmPasswordController),
          buildTextField(Icons.holiday_village_rounded, "Your address", false,
              false, addressController),
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        // curve: Curves.bounceInOut,
        top: isSignUpScreen
            ? Dimensions.height525
            : Dimensions.height450 + Dimensions.height10,
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.height80,
          width: Dimensions.height80,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: Dimensions.radius10,
                      spreadRadius: 1.5,
                      offset: const Offset(0, 1))
              ]),
          child: Container(
            height: Dimensions.height50,
            width: Dimensions.height50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffFAA214),
                      Color(0xffEF5350),
                    ]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1))
                ]),
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    Icons.arrow_forward_rounded,
                    size: Dimensions.icon30,
                    color: Colors.white,
                  ),
          ).onTap(() async {
            if (isSignUpScreen) {
              if (signUpeEmailController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  signUpPasswordController.text.isNotEmpty &&
                  signUpConfirmPasswordController.text ==
                      signUpPasswordController.text) {
                setState(() {
                  isLoading = true;
                });
                try {
                  await controller
                      .signUpMethod(
                          email: signUpeEmailController.text,
                          password: signUpPasswordController.text)
                      .then((value) {
                    return controller.storeUserData(
                        email: signUpeEmailController.text,
                        name: nameController.text,
                        password: signUpPasswordController.text,
                        address: addressController.text);
                  }).then((value) async {
                    var sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool('isLogged', true);
                    sharedPref.setBool('isVerified', false);
                    await profileController.profileDetails();
                    Get.offAll(() => const VerificationScreen());
                  });
                  setState(() {
                    isLoading = false;
                  });
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  FirebaseAuth.instance.signOut();
                  Get.snackbar("Error", "Logged out --$e");
                }
              } else {
                VxToast.show(context, msg: "Enter correct details");
              }
            } else {
              setState(() {
                isLoading = true;
              });
              await controller.signInMethod().then((value) async {
                if (value != null) {
                  await controller.checkUserInCollection(context);
                  await profileController.profileDetails();
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              });
              setState(() {
                isLoading = false;
              });
            }
          }),
        ));
  }

  Padding buildTextField(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.width8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: Dimensions.width5),
            prefixIcon: Icon(
              icon,
              color: inactiveTextColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(Dimensions.radius35)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(Dimensions.radius35)),
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: Dimensions.fontSize15, color: inactiveTextColor)),
      ),
    );
  }
}
