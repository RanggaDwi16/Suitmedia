import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/features/first_screen/providers/name_provider.dart';
import 'package:suitmedia/features/first_screen/widgets/button_widget.dart';
import 'package:suitmedia/features/second_screen/provider/user_name_provider.dart';
import 'package:suitmedia/helpers/widgets/custom_appbar.dart';
import 'package:suitmedia/routers/router_name.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<NameProvider>(context).name;
    final selectedUserName =
        Provider.of<UserNameProvider>(context).selectedUserName;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Second Screen',
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  name.isNotEmpty ? name : 'John Doe',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              selectedUserName.isNotEmpty
                  ? selectedUserName
                  : 'Selected User Name',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ButtonWidget(
          onPressed: () => context.pushNamed(RouterName.thirdScreen),
          text: 'Choose a User',
        ),
      ),
    );
  }
}
