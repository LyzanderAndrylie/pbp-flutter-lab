# Tugas 7

## Stateless Widget dan Stateful Widget
- Stateless widget adalah widget yang statenya tidak dapat diubah setelah widget tersebut dibuat. 
- Stateful widget adalah widget dengan state dapat diubah secara dinamis setelah widget tersebut dibuat. Selain itu, perubahan state dapat dilakukan berkali-kali selama masa hidupnya (*lifetime*). 

| Stateless Widget | Stateful Widget |
| --- | --- |
| Tidak memiliki mutable state | Memiliki mutable state |
| Tidak memiliki objek State | Memiliki objek State yang merepresentasikan state dari stateful widget tersebut |
| Memiliki method Build() yang berfungsi untuk me-return widget | memiliki method createState() yang berfungsi untuk me-return state |

Source: https://www.geeksforgeeks.org/flutter-stateful-vs-stateless-widgets/
***

## Widget-Widget pada Tugas 7
Widget-widget yang digunakan sebagai berikut.
1. MyApp() = widget untuk membuat MaterialApp() widget dan merupakan root widget dari aplikasi.
2. MaterialApp() = widget yang berfungsi untuk wrap beberapa widget lainnya yang biasanya digunakan untuk Material Design application. 
3. MyHomePage() = widget yang berfungsi sebagai home page dari aplikasi
4. AppBar() = widget yang mengandung toolbar dan bisa juga beberapa widget lainnya.
5. Center() = widget yang berfungsi untuk center child-nya 
6. Column() = widget yang menampilkan children-nya sebagai *vertical array* 
7. Row() = widget yang menampilkan children-nya sebagai *horizontal array*
8. Text() = widget untuk menampilkan text dengan style tunggal
9. Padding() = widget yang berfungsi untuk menyisipkan *child*-nya dengan *padding* tertentu.  
10. FloatingActionButton() = widget yang berfungsi sebagai button

***

## Fungsi setState()
setState() berfungsi untuk memberitahu flutter framework bahwa internal state dari sebuah `State` objek telah berubah yang menyebabkan flutter framework menjalankan/memanggil kembali method build sehingga dapat menampilkan perubahan state yang terjadi. 

> Perhatikan bahwa kita tidak bisa menggunakan `setState()` pada stateless widget

Variabel yang dapat terdampak dari fungsi `setState()` berupa variabel-variabel yang didefinisikan pada `State` objek. Dalam tugas 7 ini, variabel yang terdampak berupa `_counter` dan `_jenisBilangan` yang didefinisikan pada `_MyHomePageState`. 

***

## `const` dan `final`
<!-- TODO: complete -->
`const` dan `final` keyword digunakan untuk membuat variabel tidak bisa diubah kembali ketika variabel telah di-set dengan suatu objek ataupun value tertentu (variabel hanya dapat di-set sekali).
> `const` variabel adalah compile-time constant

```dart
const lstConst = [1, 2, 3]; // ekuivalen dengan const lstConst = const [1, 2, 3]
final lstFinal = [1, 2, 3];
```

Kita dapat menggunakan `const` untuk membuat value yang konstan dan juga untuk mendeklarasikan constructor yang membuat value yang constant. 

```dart
    var lst = const [1, 2, 3]; // yang tidak dapat diubah adalah list [1, 2, 3] karena valuenya konstan
    lst = [4, 5]; // variabel lst dapat di-assign kembali
    lst[0] = 3; // ERROR
```

***

### Perbedaan
- Instance variabel hanya bisa `final` dan tidak bisa `const`
- Walaupun `final` object tidak bisa dimodifikasi, field dari objek masih dapat diubah sedangkan untuk `const` object, field dari objek tersebut tidak bisa diubah (*Immutable*)
    ```dart
    lstFinal[0] = 4; // Valid
    lstConst[0] = 4;  // ERROR
    ```

## Implementasi
1. Membuat program Flutter baru dengan nama `counter_7`<br>
Hal ini dilakukan dengan *generate* proyek flutter dengan perintah berikut.
    ```
    flutter create counter_7
    ```

2. Mengubah tampilan program<br>
Pengubahan dilakukan dengan mengimplementasikan tahapan-tahapan berikut

3. Tombol `+` dan Tombol `-`<br>
Tombol `+` berfungsi untuk menambahkan angka sebanyak satu satuan dan tombol `-` berfungsi untuk mengurangi angka sebanyak satu satuan. Implementasi dilakukan dengan menambahkan properti berukti pada objek `Scaffold` yang di-*return* oleh *method* build.

    ```dart
    ...
    floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                ),
                ],
            )
    ...
    ```

    Perhatikan bahwa `Padding` merupakan widget yang berfungsi untuk menyisipkan *child*-nya dengan *padding* tertentu. `EdgeInsets` adalah *class* yang digunakan untuk mendeskripsikan dimensi *padding* dan *method* `only` berfungsi untuk membuat padding pada sisi tertentu saja (dalam contoh di atas berupa sisi kiri).

    Selanjutnya, child dari `Padding` berupa `Row`. Hal ini bertujuan untuk menempatkan tombol `-` dan `+` pada baris tersebut. untuk membuat tombol `-` dan `+` pada baris tersebut, properti mainAxisAlignment: MainAxisAlignment.spaceBetween, pada `Row` digunakan. Properti ini bertujuan agar kedua tombol berada pada ujung kiri dan ujung kanan.

    `Row` memiliki dua *child*, yaitu `FloatingActionButton` yang merepresentasikan tombol `-` dan `FloatingActionButton` yang merepresentasikan tombol `+`. Ketika tombol `-` ditekan, maka fungsi `_decrementCounter` akan dipanggil. Ketika tombol `+` ditekan, maka fungsi `_incrementCounter` akan dipanggil. Kedua fungsi tersebut diimplementasikan pada `_MyHomePageState` yang berfungsi untuk mengubah `state` dari `_counter` dan `_jenisBilangan`

    ```dart
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
    ```

    > Perhatikan pada fungsi `_decrementCounter`, apabila `_counter` bernilai 0, maka tombol `-` tidak memiliki efek apapun pada `_counter`.

4.  Teks indikator dan warna teks<br>
Implementasi agar teks indikator menjadi "GANJIL" dengan warna biru atau "GENAP" dengan warna merah pada saat `_counter` bernilai ganjil atau genap dilakukan dengan properti berikut pada `children` dari `Column` yang merupakan `child` dari `Center` dari properti `body` objek `Scaffold`.

    ```dart
    ...
    Text(
        _jenisBilangan,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: (_counter % 2 == 0)
                ? const Color.fromARGB(255, 255, 0, 0)
                : const Color.fromARGB(255, 0, 0, 255)),
    )
    ...
    ```
    > Perhatikan bahwa `_jenisBilangan` dan `_counter` merupakan state dari `_MyHomePageState`. Oleh karena itu, ketika `_counter` genap ataupun ganjil, color dari `Text` tinggal menyesuaikan. Selain itu, perubahan teks indikator berupa state `_jenisBilangan` terjadi dengan memanfaatkan fungsi `_setJenisBilanganCounter` yang akan dijalankan ketika tombol `-` atau `+` ditekan.
    - ketika `_counter` ganjil, maka teks indikator berupa "GANJIL" dengan warna biru
    - ketika `_counter` genap, maka teks indikator berupa "GENAP" dengan warna merah

***

# Tugas 8

## `Navigator.push` dan `Navigator.pushReplacement`
`Navigator.push` berfungsi untuk menambahkan route (screen) baru ke top of navigation stack. Ketika kita menambahkan route baru, maka route tersebut akan terletak di atas route kita sebelumnya dalam navigation stack. Namun, hal ini berbeda ketika kita menggunakan `Navigator.pushReplacement`. `Navigator.pushReplacement` berfungsi untuk mengganti current route dari suatu navigator dengan menambahkan (push) suatu route baru dan menghapus route sebelumnya ketika route baru tersebut sudah selesai dianimasikan.

## Widget-Widget pada Tugas 8
Widget-widget yang digunakan pada Tugas 8 sama dengan widget-widget pada tugas 7. Namun, ada beberapa tambahan widget pada tugas 8, yaitu sebagai berikut.
1. MyDrawer() = widget yang digunakan untuk menampilkan drawer/burger menu
2. MyFormPage() = widget yang digunakan untuk menampilkan halaman form
3. Form() = Widget yang berfungsi sebagai container untuk mengelompokkan beberapa form field widget
4. TextFormField() = FormField yang mengandung TextField yang digunakan untuk menampilkan text field yang memperbolehkan pengguna untuk meng-input text.
5. Expanded() = widget yang meng-expand child dari suatu Row, Column, atau Flex sedemikian hingga child tersebut akan mengisi ruang yang tersedia
6. InputDatePickerFormField() = sebuah TextFormField yang dikonfigurasi untuk menerima dan memvalidasi tanggal (date) yang di-input oleh user
7. IconButton() = widget icon yang berfungsi sebagai button
8. SizedBox() = widget yang berfungsi untuk membuat box dengan ukurang yang spesifik
9. TextButton() = widget yang berfungsi sebagai tombol 

## Jenis-jenis event pada Flutter
1. onPressed = berfungsi untuk mengeksekusi suatu fungsi ketika pengguna menekan button
2. onLongPress = berfungsi untuk mengeksekusi suatu fungsi ketika pengguna menekan lama button
3. onChanged = berfungsi untuk mengeksekusi suatu fungsi ketika pengguna melakukan perubahan pada suatu hal
4. onSaved = berfungsi untuk mengeksekusi suatu fungsi ketika pengguna melakukan save melalui FormState.save
5. onTap =  berfungsi untuk mengeksekusi suatu fungsi ketika pengguna melakukan tap pada suatu widget

> Event-event di atas akan melakukan suatu hal yang telah didefinisikan pada callback yang telah di-pass pada masing-masing properti.
> Callback adalah fungsi ataupun metode yang kita pass sebagai argumen pada suatu fungsi ataupun metode lainnya untuk melakukan suatu aksi tertentu

## Cara kerja `Navigator` dalam "mengganti" halaman dari aplikasi Flutter
Navigator merupakan widget yang berfungsi untuk me-manage route yang ada (route manager). Navigator bertugas untuk menavigasi dari satu route/screen ke route/screen lainnya. Selain itu, Navigator menampilkan screens ataupun routes sebagai stack, biasanya disebut sebagai navigation stack. Untuk menavigasi ke screen baru, kita harus mengakses Navigator melalui BuildContext milik suatu route dan memanggil method `push()` ataupun `pop()`.

> Navigation stack menyimpan route/screen sebagai Route object.
> Metode push() berfungsi untuk menambahkan screen baru ke top of the navigation stack (screen sebelumnya ada di bawah dari screen baru) .
> Metode pop() berfungsi untuk menghapus screen dari navigation stack dan kembali ke screen sebelumnya (screen di bawah dari screen yang baru dihapus). 

## Implementasi
1. Menambahkan drawer/humberger menu pada app<br>
Hal ini dilakukan dengan membuat widget `MyDrawer` pada file `drawer.dart` pada folder lib.
    ```dart
    class MyDrawer extends StatelessWidget {
    const MyDrawer({super.key});

    @override
    Widget build(BuildContext context) {
        return Drawer(
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
        );
    }
    }
    ```
    Kemudian, kita tinggal menambahkan `import 'package:counter_7/drawer.dart';` pada masing-masing halaman dan menambahkan property `drawer: const MyDrawer(),` pada `Scaffold` di method `build`.

2. Menambahkan tiga tombol navigasi pada drawer/hamburger<br>
Hal ini dilakukan dengan menambahkan `child` pada widget `Drawer`seperti di atas. Widget yang ditambahkan berupa `Column` dengan children berupa `ListTile` yang mengandung teks untuk masing-masing halaman dan `onTap` property dengan value berupa `fungsi` yang digunakan untuk berpindah dari satu halaman ke halaman yang lain.

    > Perhatikan bahwa `ListTile` pertama digunakan untuk navigasi ke halaman counter, `ListTile` kedua digunakan untuk navigasi ke halaman form, dan `ListTile` ketiga digunakan untuk navigasi ke halaman yang menampilkan data *budget* yang telah di-input melalui form.

3. Menambahkan halaman form<br>
Penambahan halaman form dilakukan dengan menggunakan widget `MyFormPage` pada `form_budget.dart`. Selanjutnya, pada property `body` pada `Scaffold` yang di-return oleh method build diassign value berupa widget `Form()` dengan key-nya berupa `_formKey`. `_formKey` berfungsi untuk mengidentifikasikan `Form` secara unik dan untuk memvalidasi form.

    Lalu, kita buat state untuk masing-masing input.
    ```dart
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
    ```

- Elemen input untuk judul budget
    ```dart
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
    ```

- Elemen input untuk nominal budget
    ```dart
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

    ```

- Elemen dropdown yang berisi tipe budget
    ```dart
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
    ```

- Button untuk menyimpan budget
    ```dart
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
    ```

4. Menambahkan Halaman data budget<br>
Penambahan dilakukan dengan membuat file `data_budget.dart` dan membuat Stateful Widget `MyDataBudget`. Selanjutnya, kita membuat fungsi untuk membuat widget bagi setiap data budget yang disimpan dalam `MyFormPageState` pada `MyDataBudgetState` sebagai berikut.
    ```dart
    class _MyDataBudgetState extends State<MyDataBudget> {
    List<Widget> listDataBudget = [];

    void addDataBudget() {
        setState(() {
        for (var i = 0; i < MyFormPageState.budgets.length; i++) {
            Budget data = MyFormPageState.budgets[i];
            listDataBudget.add(Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                    child: ListTile(
                title:
                    Text('${data.judul} (${data.tanggalPembuatan.toString()})'),
                subtitle: Text('${data.nomimal}'),
                trailing: Text(data.jenis),
                ))));
        }
        });
    }
    ```
    Kemudian, method `build` akan mengembalikan semua judul, nominal, dan tipe budget yang telah ditambahkan pada form ke `body` dari `Scaffold`.
    ```dart
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
        drawer: const MyDrawer(),
        body: Container(
            padding: const EdgeInsets.all(20),
            height: 800,
            child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listDataBudget,
            ),
            ),
        ));
    }
    ```