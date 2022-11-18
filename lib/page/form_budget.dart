import 'package:counter_7/features/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => MyFormPageState();
}

class MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _judulBudget = "";
  int _nomimalBudget = 0;
  DateTime _tanggalPembuatan = DateTime.now();

  String? _jenisBudget;
  final List<String> _listJenisBudget = ["Pemasukan", "Pengeluaran"];
  static List<Budget> budgets = [];

  List<Budget> get getBudgets {
    return budgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Budget'),
      ),
      drawer: const MyDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Judul",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat judul diketik
                          onChanged: (String? value) {
                            setState(() {
                              _judulBudget = value!;
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              _judulBudget = value!;
                            });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Judul budget tidak boleh kosong!';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: "Masukkan Angka",
                            labelText: "Nominal",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat nominal diketik
                          onChanged: (String? value) {
                            setState(() {
                              _nomimalBudget =
                                  (value!.isEmpty) ? 0 : int.parse(value);
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              _nomimalBudget =
                                  (value!.isEmpty) ? 0 : int.parse(value);
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Nominal budget tidak boleh kosong!';
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InputDatePickerFormField(
                              firstDate: DateTime(2000),
                              initialDate: _tanggalPembuatan,
                              lastDate: DateTime(2099),
                              onDateSubmitted: (value) {
                                setState(() {
                                  _tanggalPembuatan = value;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.date_range),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2099),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _tanggalPembuatan = value;
                                  });
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              hint: const Text("Pilih jenis"),
                              value: _jenisBudget,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: _listJenisBudget.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _jenisBudget = newValue!;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nominal budget tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 40,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    budgets.add(Budget(
                                        jenis: _jenisBudget!,
                                        judul: _judulBudget,
                                        nomimal: _nomimalBudget,
                                        tanggalPembuatan: _tanggalPembuatan));
                                  });

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 15,
                                        child: ListView(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            const Center(
                                                child: Text('Informasi Data')),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  "Tanggal Pembuatan: $_tanggalPembuatan \n $_jenisBudget dengan judul $_judulBudget dan harga $_nomimalBudget berhasil ditambahkan",
                                                  textAlign: TextAlign.center,
                                                )),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Kembali'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text(
                                "Simpan",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class Budget {
  String judul;
  int nomimal;
  String jenis;
  DateTime tanggalPembuatan;

  Budget(
      {required this.jenis,
      required this.judul,
      required this.nomimal,
      required this.tanggalPembuatan});
}
