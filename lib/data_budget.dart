import 'package:flutter/material.dart';
import 'package:counter_7/main.dart';
import 'package:counter_7/form_budget.dart';

class MyDataBudget extends StatefulWidget {
  const MyDataBudget({super.key});

  @override
  State<MyDataBudget> createState() => _MyDataBudgetState();
}

class _MyDataBudgetState extends State<MyDataBudget> {
  List<Widget> listDataBudget = [];

  void addDataBudget() {
    setState(() {
      for (var i = 0; i < MyFormPageState.budgets.length; i++) {
        Budget data = MyFormPageState.budgets[i];
        listDataBudget.add(Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Card(
                child: ListTile(
              title: Text(data.judul),
              subtitle: Text('${data.nomimal}'),
              trailing: Text(data.jenis),
            ))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listDataBudget.isEmpty) {
      addDataBudget();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Budget"),
      ),
      // Menambahkan drawer menu
      drawer: Drawer(
        child: Column(
          children: [
            // Menambahkan clickable menu
            ListTile(
              title: const Text('counter_7'),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Tambah Budget'),
              onTap: () {
                // Route menu ke halaman form
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Data Budget'),
              onTap: () {
                // Route menu ke halaman form
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyDataBudget()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listDataBudget,
            ),
          ),
        )
      ]),
    );
  }
}
