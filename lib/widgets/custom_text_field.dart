import 'package:fresh_om_seller/const/const.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    {label, hint, isPassword, isDesc, TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    style: TextStyle(color: fontGrey),
    obscureText: isPassword,
    // obscureText: obscureText,
    decoration: InputDecoration(
        isDense: true,
        label: Text(
          label,
          style: GoogleFonts.poppins(color: nicePurple),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: fontGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: mainAppColor),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: fontGrey)),
  );
}
