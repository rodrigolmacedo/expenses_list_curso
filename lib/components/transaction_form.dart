import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
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

  final FocusNode _titleNode = FocusNode();
  final FocusNode _valueNode = FocusNode();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                focusNode: _titleNode,
                label: 'Título',
                controller: _titleController,
                onSubmitted: (_) => _valueNode.requestFocus(),
              ),
              AdaptativeTextField(
                focusNode: _valueNode,
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                label: 'Valor (R\$)',
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                AdaptativeButton(
                  label: 'Nova Transação',
                  onPressed: _submitForm,
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
