import 'package:flutter/material.dart';
import 'package:mvvm/model/customer.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('SingUp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.name,
              focusNode: firstNameFocusNode,
              decoration: const InputDecoration(
                  hintText: 'First Name',
                  labelText: 'First Name',
                  prefixIcon: Icon(Icons.person)),
              onFieldSubmitted: (valu) {
                Utils.fieldFocusChange(
                    context, firstNameFocusNode, lastNameFocusNode);
              },
            ),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.name,
              focusNode: lastNameFocusNode,
              decoration: const InputDecoration(
                  hintText: 'Last Name',
                  labelText: 'Last Name',
                  prefixIcon: Icon(Icons.person)),
              onFieldSubmitted: (valu) {
                Utils.fieldFocusChange(
                    context, lastNameFocusNode, emailFocusNode);
              },
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email)),
              onFieldSubmitted: (valu) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value,
                    focusNode: passwordFocusNode,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: Icon(_obsecurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility)),
                    ),
                  );
                }),
            SizedBox(
              height: height * .085,
            ),
            RoundButton(
              title: 'Sign Up',
              loading: authViewMode.signUpLoading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please enter email', context);
                } else if (_firstNameController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      'Please enter first name', context);
                } else if (_lastNameController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please enter last name', context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please enter password', context);
                } else if (_passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      'Please enter 6 digit password', context);
                } else {
                  authViewMode.signUpApi(
                      CustomerModel(
                        email: _emailController.text.toString(),
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        password: _passwordController.text.toString(),
                      ),
                      context);
                  print('api hit');
                }
              },
            ),
            SizedBox(
              height: height * .02,
            ),
            // InkWell(
            //     onTap: () {
            //       Navigator.pushNamed(context, RoutesName.login);
            //     },
            //     child: Text("Already  hace an accont? Logi"))
          ],
        ),
      ),
    );
  }
}
