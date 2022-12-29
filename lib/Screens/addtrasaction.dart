import 'package:expensify/controllers/dbhelper.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "note";
  String type = "income";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Add Transaction",
          style: TextStyle(
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.attach_money,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Amount",
                    hintStyle: TextStyle(fontSize: 21),
                  ),
                  style: const TextStyle(fontSize: 24),
                  onChanged: ((value) {
                    amount = int.parse(value);
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: 
              
              const SizedBox(
                width: 25,
              ),
          )],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.moving_sharp,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 25),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(
                      color: type == 'income' ? Colors.white : Colors.black),
                ),
                selected: type == 'income' ? true : false,
                selectedColor: Colors.orange,
                onSelected: (value) {
                  setState(() {
                    type = 'income';
                  });
                },
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(
                      color: type == 'expense' ? Colors.black : Colors.white),
                ),
                selected: type == 'expense' ? true : false,
                selectedColor: Colors.orange,
                onSelected: (value) {
                  setState(() {
                    type = 'expense';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                onPressed: () async {
                  if (amount != null && note != null) {
                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addData(amount!, note, type);
                    Navigator.pop(context);
                  } else {
                    print("All values are note added");
                  }
                },
                child: const Text("Add")),
          ),
        ],
      ),
    );
  }
}
