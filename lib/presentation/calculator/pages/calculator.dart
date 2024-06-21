import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Component/Utils/DeviceUtils.dart';
import '../../../component/Constant/PrefKey.dart';
import '../../../generated/l10n.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }
  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).select_language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  await const AppLocalizationDelegate().load(const Locale( 'vi' ));
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(PrefsKey.LANGUAGES, 'vi' );
                  Navigator.of(context).pop();
                  setState(() {
                  });
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/Icon_Flag_VN.png', width: 24, height: 24),
                    const SizedBox(width: 8),
                    Text(S.of(context).language_TV),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  await const AppLocalizationDelegate().load(const Locale( 'en' ));
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(PrefsKey.LANGUAGES, 'en' );
                  Navigator.of(context).pop();
                  setState(() {
                  });
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/Icon_Flag_EN.png', width: 25, height: 25),
                    const SizedBox(width: 8),
                    Text(S.of(context).language_TA),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
}
  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).maytinh),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // Icon cài đặt
            onPressed: () {
              showLanguageDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("×"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: [
                  buildButton("C"),
                  buildButton("="),
                ],
              ),
              SizedBox(height: 30+DeviceUtils.padding.bottom,)
            ],
          ),
        ],
      ),
    );
  }
}