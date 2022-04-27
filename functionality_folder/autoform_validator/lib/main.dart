import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _autoValidatemode = true;

  bool _isLoading = false;
  bool _isValid = false;

  late String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: _isLoading
          ? _buildLoadingSpinner(context)
          : _buildPasswordForm(context),
      autovalidateMode: _autoValidatemode,
    );
}
Widget _buildLoadingSpinner(BuildContext context) {
    return (const Center(child: CircularProgressIndicator()));
  }

  Widget _buildPasswordForm(BuildContext context) {
    print('isValid: ' + _isValid.toString());

    return Column(
      children: <Widget>[
        const Text(
          'Please enter your email address.',
          style: TextStyle(fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
        const Text(
          'You will recieve a link to reset your password.',
          style: TextStyle(fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32.0),
        TextFormField(
          controller: _emailController,
          validator: _validateForgetEmail,
          keyboardType: TextInputType.emailAddress,
          autovalidate: _autoValidate,
          style: const TextStyle(fontSize: 14.0),
          onSaved: (String val) {
            email = val;
          },
          decoration: const InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            labelText: 'Email',
            border: InputBorder.none,
            labelStyle: TextStyle(fontSize: 14.0, color: Colors.lightBlueAccent),
            errorStyle: TextStyle(fontSize: 10.0, height: 0.5),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreenAccent, width: 2.0),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        FloatingActionButton(
          backgroundColor: _isValid ? Colors.lightBlue : Colors.grey,
          onPressed: () {
            _submitPasswordReset();
          },
          child: const Icon(Icons.arrow_forward_ios, size: 14.0),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  void _submitPasswordReset() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      UserPasswordResetRequest newPasswordRequest =
          UserPasswordResetRequest(email: _emailController.text);

      http.Response response = await ApiService.queryPost(
          '/api/users/password-forgot',
          body: newPasswordRequest.toJson());

      final int statusCode = response.statusCode;

      if (statusCode == 400) {
        Scaffold.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong email or password'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red));

        setState(() {
          _isLoading = false;
        });
      }

      if (statusCode == 200) {
        // setState(() {
        //   _isLoading = false;
        // });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserBackToLogin()),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _validateForgetEmail(String value) {
    String patttern =
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      setState(() {
        _isValid = false;
      });

      return "Must be a valid email address";
    }

    print('value' + value);

    setState(() {
      _isValid = true;
    });

    return null;
  }









