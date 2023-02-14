import 'package:fresh_om_seller/const/const.dart';

Widget customTextField(
    {label, hint, isPassword, isDesc, TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    style: TextStyle(color: white),
    obscureText: isPassword,
    // obscureText: obscureText,
    decoration: InputDecoration(
        isDense: true,
        label: Text(
          label,
          style: const TextStyle(color: white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: white),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54)),
  );
}
