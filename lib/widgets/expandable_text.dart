import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/widgets/reusable_small_text.dart';

class ExpadableText extends StatefulWidget {
  final String text;

  const ExpadableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpadableText> createState() => _ExpadableTextState();
}

class _ExpadableTextState extends State<ExpadableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? Text(
                firstHalf,
              )
            : Column(
                children: [
                  SmallText(
                    text: hiddenText
                        ? (firstHalf + "...")
                        : (firstHalf + secondHalf),
                    overFlow: TextOverflow.visible,
                    height: 1.6,
                    color: nicePurple,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show more",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: Colors.blueAccent,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
