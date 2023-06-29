import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  late List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    "Nenhuma Transação cadastrada!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('R\$${tr.value}'),
                            ),
                          )),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        DateFormat('dd/MM/yyyy hh:m:ss').format(tr.date),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () { onRemove(tr.id);},
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                },);
  }
}
