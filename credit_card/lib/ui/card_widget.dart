import 'package:credit_card/core/utils/validators/masked_text.dart';
import 'package:credit_card/ui/widgets.dart';
import 'package:credit_card/core/base/credit_card_htk.dart';
import 'package:credit_card/core/enums/enums_credit_card.dart';
import 'package:credit_card/core/utils/ui-common/ui-common.dart';
import 'package:credit_card/core/utils/validators/validator_number_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final Text labelPressedButton;
  final Color colorPressedButton;
  final Text textValidatorFields;
  final String textButtonValidatorFields;
  final Widget customFailureSnackBar;
  final String textDateBackCard;
  final String textDateSecurityCodeBackCard;
  final Function(String numberCard, String nameCard, String dateCard,
      String cvv, String cpf) onPressedButton;

  CreditCardHtk(
      {@required this.labelTextNumberCard,
      @required this.labelTextNameCard,
      @required this.textDateBackCard,
      @required this.textDateSecurityCodeBackCard,
      @required this.labelDateCard,
      @required this.labelCvv,
      @required this.colorGradentTwo,
      @required this.colorGradientOne,
      @required this.onPressedButton,
      @required this.enableCpf,
      @required this.labelPressedButton,
      @required this.colorPressedButton,
      @required this.textValidatorFields,
      @required this.textButtonValidatorFields,
      this.customFailureSnackBar,
      this.dialogInvalidNumberCard,
      this.labelCPF,
      this.textContentDefaultSnackBarFailure,
      this.textActionDefaultSnackBarFailure});

  @override
  _CreditCardHtkState createState() => _CreditCardHtkState();
}

class _CreditCardHtkState extends State<CreditCardHtk>
    with TickerProviderStateMixin
    implements CreditCardHtkAction {
  TextEditingController _controllerNumberCard;
  TextEditingController _controllerNameCard;
  TextEditingController _controllerDateExpire;
  TextEditingController _controllerCVV;
  TextEditingController _controllerCpf;
  CreditCardHtkActionInputValidator validatorInput;
  String _textNumberCard = "";
  String _textInitalValueNumberCard = CreditCardText.TEXT_DEFAULT_NUMBER_CARD;
  Widget _imageCard;
  String _textCardHolder = CreditCardText.TEXT_DEFAULT_CARD_HOLDER;
  String _textDateCard = CreditCardText.TEXT_DATE_CARD;
  String _textCvv = CreditCardText.TEXT_DEFAULT_CVV;
  int indexAnimated = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      top: true,
      bottom: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  child: indexAnimated % 2 == 0
                      ? _makePage(context, 0)
                      : _makePage(context, 1)),
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
                    onTap: () {
                      _animateFirstCard();
                    },
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
                    onTap: () {
                      _animateFirstCard();
                    },
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
                          onTap: () {
                            _animateFirstCard();
                          },
                          inputDecoration: InputDecoration(
                              labelText: widget.labelDateCard,
                              suffixIcon: _controllerDateExpire.text.isEmpty
                                  ? null
                                  : IconButton(
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
                        padding: EdgeInsets.only(left: 40, bottom: 20),
                        child: Container(
                          width: 130,
                          child: TextField(
                            controller: _controllerCVV,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3)
                            ],
                            onTap: () {
                              if (_textNumberCard.length >= 16) {
                                _animateSecondCard();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(FailureSnackBar(
                                    Text(widget.textContentDefaultSnackBarFailure !=
                                            null
                                        ? widget
                                            .textContentDefaultSnackBarFailure
                                        : CreditCardText
                                            .TEXT_CONTENT_SNACK_BAR_FAILURE),
                                    () {
                                  onClearNumberCard();
                                },
                                    widget.textActionDefaultSnackBarFailure !=
                                            null
                                        ? widget
                                            .textActionDefaultSnackBarFailure
                                        : CreditCardText
                                            .TEXT_ACTION_SNACK_BAR_FAILURE));
                              }
                            },
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
                    child: MaskedTextField(
                      maskedTextFieldController: _controllerCpf,
                      mask: "xxx.xxx.xxx-xx",
                      maxLength: 14,
                      keyboardType: TextInputType.number,
                      inputDecoration: InputDecoration(
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
                        primary: widget.colorPressedButton,
                        textStyle: const TextStyle(fontSize: 20)),
                    textContent: widget.labelPressedButton,
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

    _controllerCVV.addListener(() {
      onChangeCVV();
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
    _controllerCpf = widget.enableCpf ? new TextEditingController() : null;
  }

  @override
  void onDestroyControllersInput() {
    _controllerNumberCard.dispose();
    _controllerNameCard.dispose();
    _controllerDateExpire.dispose();
    _controllerCVV.dispose();
    _controllerCpf != null ? dispose() : null;
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
    try {
      bool resultValidator = widget.enableCpf
          ? ValidatorInput.validatorPressedButtonInput(
              _controllerNumberCard.text,
              _controllerNameCard.text,
              _controllerDateExpire.text,
              _controllerCVV.text,
              cpf: _controllerCpf.text)
          : ValidatorInput.validatorPressedButtonInput(
              _controllerNumberCard.text,
              _controllerNameCard.text,
              _controllerDateExpire.text,
              _controllerCVV.text);

      if (resultValidator) {
        widget.onPressedButton(
            _controllerNumberCard.text,
            _controllerNameCard.text,
            _controllerDateExpire.text,
            _controllerCVV.text,
            _controllerCpf != null ? _controllerCpf.text : "");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(_showFailureSnackBar());
      }
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(_showFailureSnackBar());
    }
  }

  Widget _makePage(BuildContext context, int itemIndex) {
    List<Widget> components = new List();
    components.add(FirstCard(
        colorGradientOne: widget.colorGradientOne,
        colorGradentTwo: widget.colorGradentTwo,
        imageCard: _imageCard,
        textDateCard: _textDateCard,
        textNumberCard: _textNumberCard.isEmpty || _controllerNumberCard == null
            ? _textInitalValueNumberCard
            : _textNumberCard,
        textCardHolder: _textCardHolder));
    components.add(SecondCard(
      colorGradentTwo: widget.colorGradentTwo,
      colorGradientOne: widget.colorGradientOne,
      textDateSecurityCodeBackCard: widget.textDateSecurityCodeBackCard,
      textDateBackCard: widget.textDateBackCard,
      imageCard: _imageCard,
      textCvv: _textCvv.isEmpty || _controllerCVV == null
          ? CreditCardText.TEXT_DEFAULT_CVV
          : _textCvv,
      textCardNumber: _textNumberCard,
      textDate: _textDateCard,
    ));

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 270,
      child: components[itemIndex],
    );
  }

  void _clearDate() {
    setState(() {
      _controllerNumberCard.clear();
      _controllerNameCard.clear();
      _controllerDateExpire.clear();
      _controllerCVV.clear();
      if (_controllerCpf != null) _controllerCpf.clear();
    });
  }

  Widget _showFailureSnackBar() {
    return widget.customFailureSnackBar != null
        ? widget.customFailureSnackBar
        : FailureSnackBar(widget.textValidatorFields, () {
            _clearDate();
          }, widget.textButtonValidatorFields);
  }

  void _animateSecondCard() {
    setState(() {
      indexAnimated = 1;
    });
  }

  void _animateFirstCard() {
    setState(() {
      indexAnimated = 0;
    });
  }

  @override
  void onChangeCVV() {
    setState(() {
      _textCvv = _controllerCVV.text;
    });
  }
}
