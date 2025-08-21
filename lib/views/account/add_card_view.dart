import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/widgets/buttons/custom_button.dart';
import 'package:recycleapp/widgets/re-use/fonction.dart';

class CreditCardView extends StatefulWidget {
  const CreditCardView({super.key});

  @override
  State<CreditCardView> createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => onWillPop(context, '/profile-view'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Informations Carte',
          ), // Card Info ➔ Informations Carte
          leading: BackButton(onPressed: () => context.go('/profile-view')),
        ),
        body: SafeArea(
          child: Column(
            children: [
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                enableFloatingCard: true,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                isSwipeGestureEnabled: true,
                cardBgColor: Colors.green,
                onCreditCardWidgetChange: (creditCardBrand) {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        onCreditCardModelChange: onCreditCardModelChange,
                        inputConfiguration: const InputConfiguration(
                          cardNumberDecoration: InputDecoration(
                            labelText:
                                'Numéro de carte', // Card Number ➔ Numéro de carte
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: InputDecoration(
                            labelText:
                                'Date d\'expiration', // Expiry Date ➔ Date d'expiration
                            hintText: 'MM/AA',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            labelText: 'CVV', // CVV (unchanged)
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            labelText:
                                'Titulaire de la carte', // Card Holder ➔ Titulaire de la carte
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: GradientButton(
                  text:
                      'Ajouter une carte bancaire', // Add Credit Card ➔ Ajouter une carte bancaire
                  onPressed: _onValidate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
    } else {}
  }

  void onCreditCardModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }
}
