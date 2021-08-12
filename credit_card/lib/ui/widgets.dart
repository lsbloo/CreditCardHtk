import 'package:flutter/material.dart';

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

  const CreditCardButton(
      {Key key,
      @required this.onPressed,
      @required this.textContent,
      @required this.style})
      : super(key: key);

  @override
  _CreditCardButtonState createState() => _CreditCardButtonState();
}

class _CreditCardButtonState extends State<CreditCardButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.textContent,
      style: widget.style,
      autofocus: true,
    );
  }
}
