import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _listenForOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: FutureBuilder(
        future: getAppSignature(),
        initialData: 'InitialData',
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          return Column(
            children: [
              Center(child: buildPinPut()),
              SizedBox(
                height: 20,
              ),
              Text(
                'pin: ${snapshot.data}',
                style: TextStyle(fontSize: 30),
              )
            ],
          );
        },
      ),
    );
  }

  Future<String?> getAppSignature() async {
    try {
      final smartAuth = SmartAuth();
      final res = await smartAuth.getAppSignature();
      return res;
    } catch (e) {
      final res = await SmsAutoFill().getAppSignature;
      return res;
    }
  }

  void _listenForOtp() async {
    await SmsAutoFill().listenForCode();
  }

  Widget buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      length: 6,
      validator: (s) {
        return s == '222222' ? null : 'Pin no es correcto';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
