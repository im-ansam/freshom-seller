import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/utils/reusable_big_text.dart';
import 'package:google_fonts/google_fonts.dart';

Widget orderPlaceDetails({data, title1, title2, d1, d2}) {
  return Padding(
    padding: EdgeInsets.only(bottom: Dimensions.width8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: "$title1",
              fontWeight: FontWeight.w700,
              size: Dimensions.fontSize15,
              color: nicePurple,
            ),
            BigText(
              text: "$d1",
              fontWeight: FontWeight.w500,
              size: Dimensions.fontSize16,
              color: orangeRed,
              overFlow: TextOverflow.ellipsis,
            ).box.width(Dimensions.height120).make()
          ],
        ),
        SizedBox(
          width: Dimensions.height60 * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2"
                  .text
                  .textStyle(GoogleFonts.poppins(
                      color: nicePurple,
                      fontSize: Dimensions.fontSize15,
                      fontWeight: FontWeight.w700))
                  .make(),
              "$d2"
                  .text
                  .size(Dimensions.fontSize15)
                  .semiBold
                  .color(Colors.grey.shade800)
                  .make(),
            ],
          ),
        )
      ],
    ),
  );
}

Widget addressDetails({data, leading}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      "$leading"
          .text
          .semiBold
          .textStyle(const TextStyle(fontWeight: FontWeight.w600))
          .color(nicePurple)
          .make(),
      Dimensions.height10.widthBox,
      SizedBox(
        width: Dimensions.height110,
        child: "$data".text.semiBold.color(Colors.grey.shade800).make(),
      )
    ],
  );
}
