import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              RaisedButton(
                onPressed: _submitForm,
                child: Text('Nova Transação'),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
