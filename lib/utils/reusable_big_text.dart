import 'package:fresh_om_seller/const/const.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  const BigText({
    Key? key,
    this.color = Colors.black,
    this.size = 0,
    required this.text,
    this.overFlow = TextOverflow.ellipsis,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: GoogleFonts.allerta(
        color: color,
        fontSize: size == 0 ? Dimensions.fontSize23 : size,
        fontWeight: fontWeight,
      ),
    );
  }
}
