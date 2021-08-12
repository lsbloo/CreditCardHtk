import 'package:credit_card/core/enums/enums_credit_card.dart';

abstract class CreditCardHtkAction {
  void onChangeNumberCard();

  String onChangeCardHolder();

  void onChangeDateExpire();

  void onChangeImageCard(CardType type);

  void onSetupControllersInput();

  void onDestroyControllersInput();

  void onClearNumberCard();

  void pressedButton();
}

abstract class CreditCardHtkActionInputValidator {
  Map<String, bool> validateInputNumberCard(String input);

  CardType getCardTypeFormNumber(String input);
}
