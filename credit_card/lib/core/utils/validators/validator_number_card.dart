import 'dart:collection';

import 'package:credit_card/core/base/credit_card_htk.dart';
import 'package:credit_card/core/enums/enums_credit_card.dart';

class ValidatorInput implements CreditCardHtkActionInputValidator {
  static const int _CONTROLLER_LENGTH_NUMBER_CARD = 16;
  static const String _SPACE_CREDIT_CARD_INPUT = " ";

  @override
  Map<String, bool> validateInputNumberCard(String input) {
    Map<String, bool> result = {input: false};
    if (input.length == _CONTROLLER_LENGTH_NUMBER_CARD) {
      String newInput = input.substring(0, 4) +
          _SPACE_CREDIT_CARD_INPUT +
          input.substring(4, 8) +
          _SPACE_CREDIT_CARD_INPUT+
          input.substring(8, 12) +
          _SPACE_CREDIT_CARD_INPUT+
          input.substring(12, 16);
      Map<String, bool> result = {newInput: true};
      return result;
    }
    return result;
  }

  @override
  CardType getCardTypeFormNumber(String input) {
    CardType cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.MasterCard;
    } else if (input.startsWith(new RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input
        .startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }
}
