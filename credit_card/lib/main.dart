import 'package:credit_card/core/utils/ui-common/ui-common.dart';
import 'package:credit_card/ui/card_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.black,
      theme: ThemeData(
        backgroundColor: Colors.black
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Credit-Card Component"),
            backgroundColor: Colors.black,
          ),
          body: CreditCardHtk(
            labelCvv: "CVV",
            labelDateCard: "MM/YY",
            labelTextNameCard: "Nome do cartão",
            labelTextNumberCard: "Número do cartão",
            labelCPF: "Cpf do Titular",
            textDateBackCard: "VALID\nTHRU",
            textDateSecurityCodeBackCard: "SECURITY\nCODE",
            enableCpf: false,
            labelPressedButton: Text("Salvar"),
            colorPressedButton: Colors.green,
            textValidatorFields: Text("Preencha os dados!"),
            textButtonValidatorFields: "Limpar",
            colorGradentTwo: CreditCardColor.qreyBold,
            colorGradientOne: CreditCardColor.greySemiBold,
            onPressedButton: (numberCard,nameCard,dateCard,cvv,cpf){
              print(numberCard);
              print(nameCard);
              print(dateCard);
              print(cvv);
            },
          )),
    );
  }
}