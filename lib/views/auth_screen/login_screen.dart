import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/auth_controller.dart';
import 'package:fresh_om_seller/views/auth_screen/Admin_verification_screen.dart';
import 'package:fresh_om_seller/views/auth_screen/forgot_password.dart';

import '../home_screen/main_home.dart';

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
  var signUpeEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();
  var signUpConfirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height:
            isSignUpScreen ? Dimensions.height167 : Dimensions.height100 * 2,
        child: Column(
          children: [
            Image.asset("images/logoMain2.png"),
            Dimensions.height10.heightBox,
            "Fresh'Om"
                .text
                .bold
                .color(nicePurple)
                .size(Dimensions.fontSize25)
                .make(),
            "Seller"
                .text
                .semiBold
                .color(nicePurple)
                .size(Dimensions.fontSize16)
                .make(),
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
                color: nicePurple,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: isSignUpScreen ? "Welcome to" : "Welcome",
                              style: TextStyle(
                                  fontSize: Dimensions.fontSize25,
                                  color: Colors.yellow[200],
                                  letterSpacing: 2),
                              children: [
                                TextSpan(
                                    text: isSignUpScreen
                                        ? " Fresh'Om,"
                                        : " Back,",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSize30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow[200],
                                    ))
                              ]),
                        ),
                      ],
                    ),
                    5.heightBox,
                    isSignUpScreen
                        ? "Signup to Continue"
                            .text
                            .size(Dimensions.fontSize18)
                            .letterSpacing(2)
                            .color(Colors.white54)
                            .semiBold
                            .make()
                        : "Signin to Continue"
                            .text
                            .size(Dimensions.fontSize18)
                            .letterSpacing(2)
                            .color(Colors.white54)
                            .semiBold
                            .make()
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
                    : Dimensions.height270,
                width: Dimensions.screenWidth - 40,
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
                                "LOGIN"
                                    .text
                                    .size(Dimensions.fontSize18)
                                    .extraBold
                                    .color(isSignUpScreen
                                        ? inactiveTextColor
                                        : nicePurple)
                                    .make(),
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
                                "SIGNUP"
                                    .text
                                    .size(Dimensions.fontSize18)
                                    .extraBold
                                    .color(isSignUpScreen
                                        ? nicePurple
                                        : inactiveTextColor)
                                    .make(),
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
      margin: const EdgeInsets.only(top: 20),
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
                child: "Forgot Password?"
                    .text
                    .semiBold
                    .size(Dimensions.fontSize16)
                    .color(nicePurple)
                    .make()),
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
                  color: isObscure ? inactiveTextColor : nicePurple,
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
        top: isSignUpScreen ? Dimensions.height525 : Dimensions.height440,
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.height90,
          width: Dimensions.height90,
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
            height: Dimensions.height60,
            width: Dimensions.height60,
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
                ? Center(
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
                  }).then((value) {
                    Get.offAll(() => const VerificationScreen());
                  });
                  setState(() {
                    isLoading = false;
                  });
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  auth.signOut();
                  Get.snackbar("Error", "Logged out --$e");
                }
              } else {
                VxToast.show(context, msg: "Enter correct details");
              }
            } else {
              setState(() {
                isLoading = true;
              });
              await controller.signInMethod().then((value) => {
                    if (value != null)
                      {
                        VxToast.show(context, msg: loggedIn),
                        Get.offAll(() => const MainHome())
                      }
                    else
                      {
                        setState(() {
                          isLoading = false;
                        })
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
