import 'package:counter_7/widgets/drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'counter_7',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = 'Program Counter';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _jenisBilangan = "GENAP";

  void _incrementCounter() {
    setState(() {
      _counter++;
      _setJenisBilanganCounter();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter != 0) {
        setState(() {
          _counter--;
          _setJenisBilanganCounter();
        });
      }
    });
  }

  void _setJenisBilanganCounter() {
    if (_counter % 2 == 0) {
      _jenisBilangan = "GENAP";
    } else {
      _jenisBilangan = "GANJIL";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Menambahkan drawer menu
      drawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _jenisBilangan,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: (_counter % 2 == 0)
                      ? const Color.fromARGB(255, 255, 0, 0)
                      : const Color.fromARGB(255, 0, 0, 255)),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: _counter != 0,
                child: FloatingActionButton(
                  heroTag: "decrementButton",
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ),
              FloatingActionButton(
                heroTag: "incrementButton",
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ],
          )),
    );
  }
}
