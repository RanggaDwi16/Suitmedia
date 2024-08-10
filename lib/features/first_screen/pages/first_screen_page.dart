import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/features/first_screen/providers/name_provider.dart';
import 'package:suitmedia/features/first_screen/widgets/button_widget.dart';
import 'package:suitmedia/features/first_screen/widgets/input_widget.dart';
import 'package:suitmedia/routers/router_name.dart';
import 'package:suitmedia/utils/assets.gen.dart';
import 'package:suitmedia/features/first_screen/widgets/alert_dialog_widget.dart'; 

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  bool isPalindrome(String palindrome) {
    String cleaned =
        palindrome.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toLowerCase();
    String reversed = cleaned.split('').reversed.join('');
    return cleaned == reversed;
  }

  void _checkPalindrome() {
    final palindrome = _palindromeController.text;
    if (palindrome.isEmpty) {
      _showWarningDialog();
      return;
    }
    final result =
        isPalindrome(palindrome) ? 'is a palindrome' : 'is not a palindrome';
    _showResultDialog(palindrome, result);
  }

  void _showResultDialog(String text, String result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialogWidget(
        title: result,
        content: 'The text "$text" $result.',
      ),
    );
  }

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialogWidget(
        title: 'Warning',
        content: 'Please enter text to check for palindrome.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.images.background.path,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ic_photo.png'),
                  const Gap(51),
                  InputWidget(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
                  const Gap(16),
                  InputWidget(
                    controller: _palindromeController,
                    hintText: 'Palindrome',
                  ),
                  const Gap(45),
                  ButtonWidget(
                    onPressed: _checkPalindrome,
                    text: 'CHECK',
                  ),
                  const Gap(15),
                  ButtonWidget(
                    onPressed: () {
                      Provider.of<NameProvider>(context, listen: false)
                          .setName(_nameController.text);
                      context.pushNamed(RouterName.secondScreen);
                    },
                    text: 'NEXT',
                  ),
                  const Gap(16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
