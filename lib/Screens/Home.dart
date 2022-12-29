import 'package:expensify/Screens/addtrasaction.dart';
import 'package:expensify/controllers/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int totalbalance = 0;
  int totalincome = 0;
  int totalexpense = 0;

  getTotalBalance(Map entireData) {
    totalbalance = 0;
    totalincome = 0;
    totalexpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == 'income') {
        totalbalance += (value['amount'] as int);
        totalincome += (value['amount'] as int);
      } else {
        totalbalance -= (value['amount'] as int);
        totalexpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          "Expensify",
          style: TextStyle(
            letterSpacing: 10,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTransaction()))
              .whenComplete(() {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<Map>(
          future: dbHelper.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("unexpected Error Occured"),
              );
            }
            if (snapshot.hasData) {
              getTotalBalance(snapshot.data!);
              return ListView(children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 50),
                      Text(
                          "Hey Bibs",
                         style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700,letterSpacing: 5),
                        ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.orange,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Total Balance",
                            style: TextStyle(fontSize: 25, letterSpacing: 10),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$totalbalance',
                            style:
                                const TextStyle(fontSize: 22, letterSpacing: 3),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              income(totalincome.toString()),
                              expence('$totalexpense'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.orange)),
                        onPressed: () async {
                          setState(() {
                            Hive.box('money').clear();
                          });
                        },
                        child: const Text("Reset")),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(child: Text("Recent Expenses",style: TextStyle(fontSize: 20,letterSpacing: 10),)),
                const SizedBox(height: 10),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Map dataAtIndex = snapshot.data![index];
                      if (dataAtIndex['type'] == 'income') {
                        return incometile(dataAtIndex['amount'].toString(),
                           'Income');
                      } else {
                        return expensetile(dataAtIndex['amount'].toString(),
                            'Expense');
                      }
                    })
              ]);
            } else {
              return const Center(
                child: Text("unexpected Error Occured"),
              );
            }
          }),
    );
  }
}

Widget income(String value) {
  return Row(
    children: [
      const SizedBox(width: 10),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.white),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_upward,
            color: Colors.green,
          ),
        ),
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Income",
            style: TextStyle(fontSize: 15, letterSpacing: 3),
          ),
          Text(value.toString(),
              style: const TextStyle(fontSize: 20, letterSpacing: 2)),
        ],
      )
    ],
  );
}

Widget expence(String value) {
  return Row(
    children: [
      const SizedBox(width: 10),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.white),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_downward,
            color: Colors.red,
          ),
        ),
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expense",
            style: TextStyle(fontSize: 15, letterSpacing: 3),
          ),
          Text(value.toString(),
              style: const TextStyle(fontSize: 20, letterSpacing: 2)),
        ],
      )
    ],
  );
}

Widget expensetile(String value, String note) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.orange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            ),
          ),
          Text(note),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('-$value',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w700,fontSize: 17),),
          ),
        ],
      ),
    ),
  );
}

Widget incometile(String value, String note) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.orange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.green,
                  size: 24,
                ),
              ),
            ),
          ),
          Text(note),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(value.toString(),style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w700,fontSize: 17),),
          ),
        ],
      ),
    ),
  );
}
