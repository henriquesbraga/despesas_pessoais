import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  _TransactionFormState createState() => _TransactionFormState();

}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now()
    ).then((pickedDate) => {
      setState(() {
        _selectedDate = pickedDate!;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Título'
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$) '
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text( _selectedDate == null
                    ? "Nenhuma Data selecionada"
                    : "Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}"
                    )
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      foregroundColor: Theme.of(context).primaryColor
                    ),
                    child: const Text("Selecionar Data"),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _submitForm,
                  style: TextButton.styleFrom(
                    side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Nova Transação'),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}