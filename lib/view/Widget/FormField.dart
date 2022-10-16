import 'package:flutter/material.dart';

import 'MyTextField.dart';

class TestForm extends StatefulWidget {
  final String? firstName;
  final String? secName;
  final TextEditingController? adress;
  final TextEditingController? country;
  final TextEditingController? state;
  final TextEditingController? postCode;

  TestForm(
      {this.firstName,
      this.secName,
      this.adress,
      this.country,
      this.postCode,
      this.state});
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: Text('${widget.firstName}'),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: Text('${widget.secName}'),
                ),
              ],
            ),
          ),
          MyTextFormField(
            hintText: 'Address',
            isEmail: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid adress';
              }
              return '';
            },
            onSaved: (value) {
              widget.adress!.text = value!;
            },
          ),
          MyTextFormField(
            hintText: 'Country',
            isEmail: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid country name';
              }
              return '';
            },
            onSaved: (value) {
              widget.country!.text = value!;
            },
          ),
          MyTextFormField(
            hintText: 'State',
            isPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid state';
              }
              return '';
            },
            onSaved: (value) {
              widget.state!.text = value!;
            },
          ),
          MyTextFormField(
            hintText: 'Postal Code',
            isPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid postal code';
              }
              _formKey.currentState!.save();
              return '';
            },
            onSaved: (value) {
              widget.postCode!.text = value!;
            },
          ),
          RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print("DONE");
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
