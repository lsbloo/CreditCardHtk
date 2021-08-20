
import 'package:credit_card/core/utils/validators/masked_text.dart';
import 'package:credit_card/ui/widgets.dart';
import 'package:credit_card/core/base/credit_card_htk.dart';
import 'package:credit_card/core/enums/enums_credit_card.dart';
import 'package:credit_card/core/utils/ui-common/ui-common.dart';
import 'package:credit_card/core/utils/validators/validator_number_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CreditCardHtk extends StatefulWidget {
  final String labelTextNumberCard;
  final String labelTextNameCard;
  final String labelDateCard;
  final String labelCvv;
  final String labelCPF;
  final bool enableCpf;
  final Widget dialogInvalidNumberCard;
  final String textContentDefaultSnackBarFailure;
  final String textActionDefaultSnackBarFailure;
  final Color colorGradientOne;
  final Color colorGradentTwo;
  final Function(String numberCard, String nameCard, String dateCard,
      String cvv, String cpf) onPressedButton;

  CreditCardHtk(
      {@required this.labelTextNumberCard,
      @required this.labelTextNameCard,
      @required this.labelDateCard,
      @required this.labelCvv,
      @required this.colorGradentTwo,
      @required this.colorGradientOne,
      @required this.onPressedButton,
      @required this.enableCpf,
      this.dialogInvalidNumberCard,
      this.labelCPF,
      this.textContentDefaultSnackBarFailure,
      this.textActionDefaultSnackBarFailure});

  @override
  _CreditCardHtkState createState() => _CreditCardHtkState();
}

class _CreditCardHtkState extends State<CreditCardHtk>
    implements CreditCardHtkAction {
  TextEditingController _controllerNumberCard;
  TextEditingController _controllerNameCard;
  TextEditingController _controllerDateExpire;
  TextEditingController _controllerCVV;
  CreditCardHtkActionInputValidator validatorInput;
  String _textNumberCard = "";
  String _textInitalValueNumberCard = CreditCardText.TEXT_DEFAULT_NUMBER_CARD;
  Widget _imageCard;
  String _textCardHolder = CreditCardText.TEXT_DEFAULT_CARD_HOLDER;
  String _textDateCard = CreditCardText.TEXT_DATE_CARD;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      top: true,
      bottom: true,
      child: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  height: 230,
                  width: 400,
                  child: Card(
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
                                    left:
                                        MediaQuery.of(context).size.width - 80,
                                    top: 20),
                                child: _imageCard == null
                                    ? Container(
                                        height: 40,
                                      )
                                    : _imageCard),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _textNumberCard.isEmpty ||
                                              _controllerNumberCard == null
                                          ? _textInitalValueNumberCard
                                          : _textNumberCard,
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
                                    Text(_textDateCard,
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
                                    AutoSizeText(_textCardHolder,
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
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _controllerNumberCard,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: widget.labelTextNumberCard,
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                                right: Radius.circular(8)))),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: _controllerNameCard,
                    decoration: InputDecoration(
                        labelText: widget.labelTextNameCard,
                        errorText: onChangeCardHolder(),
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                                right: Radius.circular(8)))),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 200,
                        child: new MaskedTextField(
                          maskedTextFieldController: _controllerDateExpire,
                          mask: "xx/xx",
                          maxLength: 5,
                          inputDecoration: InputDecoration(
                              labelText: widget.labelDateCard,
                              suffixIcon: _controllerDateExpire.text.isEmpty ? null : IconButton(
                                onPressed: _controllerDateExpire.clear,
                                icon: Icon(Icons.clear),
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(8),
                                      right: Radius.circular(8)))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Container(
                          width: 130,
                          child: TextField(
                            controller: _controllerCVV,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: widget.labelCvv,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(8),
                                        right: Radius.circular(8)))),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Visibility(
                    visible: widget.enableCpf,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: widget.labelCPF,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(8),
                                  right: Radius.circular(8)))),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CreditCardButton(
                    width: 450,
                    height: 50,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        textStyle: const TextStyle(fontSize: 20)),
                    textContent: Text("Salvar"),
                    onPressed: () {
                      pressedButton();
                    },
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    validatorInput = ValidatorInput();
    onSetupControllersInput();

    _controllerNumberCard.addListener(() {
      onChangeNumberCard();
    });

    _controllerNameCard.addListener(() {
      onChangeCardHolder();
    });

    _controllerDateExpire.addListener(() {
      onChangeDateExpire();
    });
  }

  @override
  void dispose() {
    super.dispose();
    onDestroyControllersInput();
  }

  @override
  String onChangeCardHolder() {
    setState(() {
      _textCardHolder = _controllerNameCard.text.toString().length != 0
          ? _controllerNameCard.text
          : CreditCardText.TEXT_DEFAULT_CARD_HOLDER;
    });
    return null;
  }

  @override
  void onChangeDateExpire() {
    setState(() {
      _textDateCard = _controllerDateExpire.text.toString().length != 0
          ? _controllerDateExpire.text
          : CreditCardText.TEXT_DATE_CARD;
    });
  }

  @override
  void onChangeNumberCard() {
    setState(() {
      _textNumberCard = validatorInput
          .validateInputNumberCard(_controllerNumberCard.text)
          .keys
          .first;
      if (validatorInput
          .validateInputNumberCard(_controllerNumberCard.text)
          .values
          .first) {
        var re = validatorInput.getCardTypeFormNumber(_textNumberCard);
        onChangeImageCard(re);
      } else {
        _imageCard = null;
      }
    });
  }

  @override
  void onSetupControllersInput() {
    _controllerNumberCard = new TextEditingController();
    _controllerNameCard = new TextEditingController();
    _controllerDateExpire = new TextEditingController();
    _controllerCVV = new TextEditingController();
  }

  @override
  void onDestroyControllersInput() {
    _controllerNumberCard.dispose();
    _controllerNameCard.dispose();
    _controllerDateExpire.dispose();
    _controllerCVV.dispose();
  }

  Widget _getMasterCardImage() {
    return Image(
      image: AssetImage('assets/images/mastercard.png'),
      width: 50,
    );
  }

  Widget _getVisaImage() {
    return Image(
      image: AssetImage('assets/images/visa.png'),
      width: 40,
    );
  }

  @override
  void onChangeImageCard(CardType type) {
    switch (type) {
      case CardType.MasterCard:
        setState(() {
          _imageCard = _getMasterCardImage();
        });
        break;
      case CardType.Visa:
        setState(() {
          _imageCard = _getVisaImage();
        });
        break;
      case CardType.Master:
        break;
      case CardType.Verve:
        break;
      case CardType.Others:
        break;
      case CardType.Invalid:
        Widget result = _showSnackBarInvalidNumberCard();
        if (result is FailureSnackBar) {
          ScaffoldMessenger.of(context).showSnackBar(result);
        }
        break;
    }
  }

  Widget _showSnackBarInvalidNumberCard() {
    FailureSnackBar snackBar = FailureSnackBar(
        Text(widget.textContentDefaultSnackBarFailure != null
            ? widget.textContentDefaultSnackBarFailure
            : CreditCardText.TEXT_CONTENT_SNACK_BAR_FAILURE), () {
      onClearNumberCard();
    },
        widget.textActionDefaultSnackBarFailure != null
            ? widget.textActionDefaultSnackBarFailure
            : CreditCardText.TEXT_ACTION_SNACK_BAR_FAILURE);
    return widget.dialogInvalidNumberCard != null
        ? widget.dialogInvalidNumberCard
        : snackBar;
  }

  @override
  void onClearNumberCard() {
    setState(() {
      _textNumberCard = "";
      _controllerNumberCard.clear();
    });
  }

  @override
  void pressedButton() {
    // TODO: implement pressedButton sender all informations textfield to widget.pressedButton
  }
}
