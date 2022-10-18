import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';

import 'MyTextField.dart';

class TestForm extends StatefulWidget {
  final String? firstName;
  final String? secName;
  final TextEditingController? adress;
  final TextEditingController? country;
  final TextEditingController? state;
  final TextEditingController? postCode;
  final VoidCallback? orderDone;
  final bool? loadingOrder;
  final BuildContext? context;

  TestForm(
      {this.firstName,
      this.secName,
      this.loadingOrder,
      this.orderDone,
      this.adress,
      this.country,
      this.postCode,
      this.context,
      this.state});
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                width: halfMediaWidth,
                child: Text(
                  'First name ${widget.firstName}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                width: halfMediaWidth,
                child: Text(
                  'Last name ${widget.secName}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              MyTextFormField(
                hintText: 'Address',
                textEditingController: widget.adress,
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
                textEditingController: widget.country,
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
                textEditingController: widget.state,
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
                textEditingController: widget.postCode,
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
                  Navigator.pop(widget.context!);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
