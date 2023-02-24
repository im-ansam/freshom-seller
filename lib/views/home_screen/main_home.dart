import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/home_controller.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/views/home_screen/home_page.dart';
import 'package:fresh_om_seller/views/order_screen/orders_list.dart';
import 'package:fresh_om_seller/views/products_screen/add_products/add_products_category.dart';
import 'package:fresh_om_seller/views/products_screen/products_screen.dart';
import 'package:fresh_om_seller/views/profile_screen/profile_sceen.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    print(Dimensions.screenHeight);
    var screens = [
      const HomePage(),
      const ProductsScreen(),
      const AddProducts(),
      const OrdersList(),
      const ProfileScreen()
    ];
    var bottomNavBar = [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: Dimensions.icon25,
          ),
          label: dashboard),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.category_outlined,
            size: Dimensions.icon25,
          ),
          label: products),
      BottomNavigationBarItem(
        icon: Image.asset(
          addIcon,
          width: Dimensions.height50,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt_outlined,
            size: Dimensions.icon25,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            size: Dimensions.icon25,
          ),
          label: profile)
    ];
    return Scaffold(
      backgroundColor: mainBackGround,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
            currentIndex: controller.navIndex.value,
            onTap: (index) {
              controller.navIndex.value = index;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: mainBackGround,
            elevation: 0,
            selectedItemColor: mainAppColor,
            unselectedItemColor: Colors.grey.shade600,
            items: bottomNavBar,
          )),
      body: Column(
        children: [
          Obx(() =>
              Expanded(child: screens.elementAt(controller.navIndex.value)))
        ],
      ),
    );
  }
}
