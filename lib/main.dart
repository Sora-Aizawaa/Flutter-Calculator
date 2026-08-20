import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueAccent,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '0';

  void _onButtonPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '0';
      } else if (text == '=') {
        try {
          String evalExpr = _expression
              .replaceAll('×', '*')
              .replaceAll('÷', '/')
              .replaceAll('π', '3.14159265359')
              .replaceAll('e', '2.71828182846');

          Parser p = Parser();
          Expression exp = p.parse(evalExpr);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          _result = eval.toString();
          if (_result.endsWith('.0')) {
            _result = _result.substring(0, _result.length - 2);
          }
        } catch (e) {
          _result = 'Error';
        }
      } else if (text == '⌫') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else {
        _expression += text;
      }
    });
  }

  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[850],
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => _onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression,
                      style: const TextStyle(fontSize: 32, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _result,
                      style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildButton('sin', color: Colors.grey[900], textColor: Colors.greenAccent),
                        _buildButton('cos', color: Colors.grey[900], textColor: Colors.greenAccent),
                        _buildButton('tan', color: Colors.grey[900], textColor: Colors.greenAccent),
                        _buildButton('^', color: Colors.grey[900], textColor: Colors.greenAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('π', color: Colors.grey[900], textColor: Colors.greenAccent),
                        _buildButton('e', color: Colors.grey[900], textColor: Colors.greenAccent),
                        _buildButton('(', color: Colors.grey[900], textColor: Colors.greenAccent),
                        _buildButton(')', color: Colors.grey[900], textColor: Colors.greenAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('C', color: Colors.red[400], textColor: Colors.white),
                        _buildButton('⌫', color: Colors.grey[800], textColor: Colors.white),
                        _buildButton('%', color: Colors.grey[800], textColor: Colors.greenAccent),
                        _buildButton('÷', color: Colors.grey[800], textColor: Colors.greenAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('7'),
                        _buildButton('8'),
                        _buildButton('9'),
                        _buildButton('×', color: Colors.grey[800], textColor: Colors.greenAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('4'),
                        _buildButton('5'),
                        _buildButton('6'),
                        _buildButton('-', color: Colors.grey[800], textColor: Colors.greenAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('1'),
                        _buildButton('2'),
                        _buildButton('3'),
                        _buildButton('+', color: Colors.grey[800], textColor: Colors.greenAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('0'),
                        _buildButton('.'),
                        _buildButton('=', color: Colors.green, textColor: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
