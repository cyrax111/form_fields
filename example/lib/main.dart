import 'package:example/model.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

void main() {
  runApp(const MaterialApp(home: FormFieldExample()));
}

class FormFieldExample extends StatelessWidget {
  const FormFieldExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const currencies = <Currency>[
      Currency(name: 'USD'),
      Currency(name: 'EUR'),
      Currency(name: 'RUB'),
    ];

    void _message(String msg) {
      final snackBar = SnackBar(
        content: Text('Selected: $msg'),
      );
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form field example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownTextField<Currency>(
                values: currencies,
                currentValue: currencies.first,
                decoration: const InputDecoration(
                  label: Text('label'),
                  border: OutlineInputBorder(),
                ),
                child: TextField(
                  decoration: null,
                  onChanged: _message,
                ),
                onChanged: (value) => _message(value.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
