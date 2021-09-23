import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginData {
  String username = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  _LoginData _data = new _LoginData();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('logging in'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "ESTS MOHCC APP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _data.username = value!;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                obscureText: _isObscure,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _data.password = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(300, 45))),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  _submit();
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
