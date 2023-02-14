import 'package:fresh_om_seller/const/const.dart';

Widget orderPlaceDetails({data, title1, title2, d1, d2}) {
  return Padding(
    padding: EdgeInsets.only(bottom: Dimensions.width8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1"
                .text
                .size(Dimensions.fontSize18)
                .semiBold
                .color(nicePurple)
                .make(),
            "$d1"
                .text
                .size(Dimensions.fontSize16)
                .semiBold
                .color(priceColor)
                .make(),
          ],
        ),
        SizedBox(
          width: Dimensions.height60 * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2"
                  .text
                  .size(Dimensions.fontSize16)
                  .semiBold
                  .color(nicePurple)
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
      "$leading".text.semiBold.color(Colors.grey.shade800).make(),
      10.widthBox,
      SizedBox(
        width: Dimensions.height110,
        child: "$data".text.semiBold.color(Colors.grey.shade800).make(),
      )
    ],
  );
}