// ignore_for_file: avoid_print

import 'package:expensify/controllers/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "note";
  String type = "income";
  static DateTime selecteddate = DateTime.now();
  void dt() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2024))
        .then((value) {
      setState(() {
        selecteddate = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.note_add,
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
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Description",
                      hintStyle: TextStyle(fontSize: 21)),
                  style: const TextStyle(fontSize: 24),
                  onChanged: (value) {
                    try {
                      amount = int.parse(value);
                    } catch (e) {}
                  },
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
                child: IconButton(
                    onPressed: () {
                      dt();
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              const SizedBox(width: 25),
              Text(
                  '${selecteddate.day}-${selecteddate.month}-${selecteddate.year}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.orange)),
                onPressed: () async {
                  if (amount != null && note != null) {
                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addData(amount!, selecteddate, note, type);
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
