import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (!RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$')
                    .hasMatch(text ?? '')) {
                  return 'digite um CPF válido';
                }
                return null;
              },
              inputFormatters: [
                CPFMask(),
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) {
                if (!RegExp(r'[a-zA-z0-9.-_]+@[a-zA-z0-9-_]+\..+').hasMatch(
                  email ?? '',
                )) {
                  return 'Digite um E-mail válido';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CPFMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > 14 ||
        !RegExp(r'^([\d-.]+)?$').hasMatch(
          newValue.text,
        )) {
      return oldValue;
    }
    var cpf = newValue.text.replaceAll(
      RegExp(r'\D'),
      '',
    );
    final characters = cpf.characters.toList();
    var formatted = '';
    for (var i = 0; i < characters.length; i++) {
      if (i < 3) {
        formatted += characters[i];
      } else if (i == 3) {
        formatted += '.';
        formatted += characters[i];
      } else if (i == 6) {
        formatted += '.';
        formatted += characters[i];
      } else if (i == 9) {
        formatted += '-';
        formatted += characters[i];
      } else {
        formatted += characters[i];
      }
    }
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}
