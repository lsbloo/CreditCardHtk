import 'package:auto_size_text/auto_size_text.dart';
import 'package:credit_card/core/utils/ui-common/ui-common.dart';
import 'package:flutter/material.dart';


class SecondCard extends StatefulWidget {
  final Color colorGradientOne;
  final Color colorGradentTwo;
  final Widget imageCard;
  final String textCvv;
  final String textCardNumber;
  final String textDate;
  final String textDateBackCard;
  final String textDateSecurityCodeBackCard;
  const SecondCard({Key key,
    @required this.colorGradentTwo,
    @required this.colorGradientOne,
    @required this.imageCard,
    @required this.textCvv,
    @required this.textCardNumber,
    @required this.textDate,
    @required this.textDateSecurityCodeBackCard,
    @required this.textDateBackCard
    }) : super(key: key);

  @override
  _SecondCardState createState() => _SecondCardState();
}

class _SecondCardState extends State<SecondCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: widget.colorGradientOne != null
          ? widget.colorGradientOne
          : CreditCardColor.greySemiBold,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: widget.colorGradentTwo != null
                  ? widget.colorGradentTwo
                  : CreditCardColor.qreyBold,
              width: 1),
          borderRadius: BorderRadius.circular(14.0)),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(14.0),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    widget.colorGradientOne != null
                        ? widget.colorGradientOne
                        : CreditCardColor.greySemiBold,
                    widget.colorGradentTwo != null
                        ? widget.colorGradentTwo
                        : CreditCardColor.qreyBold
                  ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 60,),
              Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  widget.textCardNumber,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      letterSpacing: 2,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.textDateBackCard,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          letterSpacing: 0.0125,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w500)),
                    SizedBox(width: 8,),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                          widget.textDate,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              letterSpacing: 0.0125,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w600)),
                    ),
                SizedBox(width: 16,),
                Text(
                    widget.textDateSecurityCodeBackCard,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        letterSpacing: 0.0125,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w500)),
                SizedBox(width: 8,),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                      widget.textCvv,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          letterSpacing: 0.0125,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w600))),


                    SizedBox(width: MediaQuery.of(context).size.width / 3,),
                    widget.imageCard
                  ],
                ),
              )

            ],

          ),
        ),
      ),
    );
  }
}

class FirstCard extends StatefulWidget {
  final Color colorGradientOne;
  final Color colorGradentTwo;
  final Widget imageCard;
  final String textDateCard;
  final String textNumberCard;
  final String textCardHolder;

  const FirstCard({
    Key key,
    @required this.colorGradentTwo,
    @required this.colorGradientOne,
    @required this.imageCard,
    @required this.textDateCard,
    @required this.textNumberCard,
    @required this.textCardHolder,
  }) : super(key: key);

  @override
  _FirstCardState createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: widget.colorGradientOne != null
          ? widget.colorGradientOne
          : CreditCardColor.greySemiBold,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: widget.colorGradentTwo != null
                  ? widget.colorGradentTwo
                  : CreditCardColor.qreyBold,
              width: 1),
          borderRadius: BorderRadius.circular(14.0)),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(14.0),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    widget.colorGradientOne != null
                        ? widget.colorGradientOne
                        : CreditCardColor.greySemiBold,
                    widget.colorGradentTwo != null
                        ? widget.colorGradentTwo
                        : CreditCardColor.qreyBold
                  ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width - 80, top: 20),
                  child: widget.imageCard == null
                      ? Container(
                          height: 40,
                        )
                      : widget.imageCard),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.textNumberCard,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            letterSpacing: 2,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(widget.textDateCard,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              letterSpacing: 2,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 24,
                      ),
                      AutoSizeText(widget.textCardHolder,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              letterSpacing: 2,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w500))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FailureSnackBar extends SnackBar {
  Text content;
  Function onPressed;
  String labelAction;

  FailureSnackBar(this.content, this.onPressed, this.labelAction)
      : super(
            content: content,
            duration: Duration(milliseconds: 4000),
            action: SnackBarAction(label: labelAction, onPressed: onPressed));
}

class CreditCardButton extends StatefulWidget {
  final Function onPressed;
  final Text textContent;
  final ButtonStyle style;
  final double width;
  final double height;

  const CreditCardButton(
      {Key key,
      @required this.onPressed,
      @required this.textContent,
      @required this.style,
      @required this.width,
      @required this.height})
      : super(key: key);

  @override
  _CreditCardButtonState createState() => _CreditCardButtonState();
}

class _CreditCardButtonState extends State<CreditCardButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: widget.textContent,
        style: widget.style,
        autofocus: true,
      ),
    );
  }
}
