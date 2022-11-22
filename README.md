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

# Tugas 9

## Pengambilan data JSON dengan/tanpa Model
Kita bisa saja melakukan pengambilan data JSON tanpa membuat model terlebih dahulu. Namun, hal ini akan membuat pengolahan data tidak mudah dan tidak efisien karena kita harus memproses respons JSON tersebut secara manual setelah menerima respons dari *web service*. Oleh karena itu, hal tersebut tidaklah lebih baik daripada kita membuat model terlebih dahulu sebelum melakukan pengambilan data JSON.

## Widget-Widget pada Tugas 9
Widget-widget yang digunakan pada Tugas 9 sama dengan widget-widget pada tugas 7 dan 8. Namun, ada beberapa tambahan widget pada tugas 9, yaitu sebagai berikut.
1. FutureBuilder() = widget yang membangun dirinya sendiri berdasarkan interaksi snapshot terakhir dengan `Future`.
2. MyWatchDetail() = widget yang digunakan untuk menampilkan detail dari mywatch
3. RichText() = widget yang dapat menampilkan text dengan menggunakan beberapa *style* yang berbeda.
4. GestureDetector() = widget yang dapat mendeteksi gestur pengguna.
5. ListTile() = Widget yang merepresentasikan satu baris dengan tinggi tetap.
6. CheckboxListTile() = `ListTile` dengan `Checkbox`.

## Mekanisme Pengambilan data dari JSON dan Menampilkan data pada Flutter
Mekanisme mengambil dan menapilkan data dari JSON pada Flutter sebagai berikut.
1. Membuat Model kustom yang sesuai dengan data JSON.
2. Mengambil data JSON dari *web service* dengan metode `http.get`.
3. Mengolah data JSON dari *web service* dengan memanfaatkan metode pada Model kustom yang telah dibuat untuk mengubah JSON menjadi objek model kustom.
4. Menampilkan data dari *web service* yang telah diproses ke widget yang sesuai.

## Implementasi
1. Menambahkan tombol navigasi pada drawer/hamburger untuk ke halaman mywatchlist.<br>
Penambahan tombol navigasi pada drawer dilakukan dengan menambahkan kode berikut pada `drawer.dart`.
    ```dart
    Drawer(
      child: Column(
        children: [
          ...
          ListTile(
            title: const Text('My Watch List'),
            onTap: () {
              // Route menu ke halaman mywatchlist
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyWatchListPage()),
              );
            },
          ),
        ],
      ),
    );
    ```

2. Membuat satu file dart yang berisi model mywatchlist<br>
Hal ini dilakukan dengan memanfaatkan [QuickType](https://app.quicktype.io/) untuk membantu pembuatan model yang menyesuaikan dengan data JSON.
    ```dart
    import 'dart:convert';

    List<MyWatchList> myWatchListFromJson(String str) => List<MyWatchList>.from(
        json.decode(str).map((x) => MyWatchList.fromJson(x)));

    String myWatchListToJson(List<MyWatchList> data) =>
        json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    class MyWatchList {
    MyWatchList({
        required this.model,
        required this.pk,
        required this.fields,
    });

    Model model;
    int pk;
    Fields fields;

    factory MyWatchList.fromJson(Map<String, dynamic> json) => MyWatchList(
            model: modelValues.map[json["model"]]!,
            pk: json["pk"],
            fields: Fields.fromJson(json["fields"]),
        );

    Map<String, dynamic> toJson() => {
            "model": modelValues.reverse[model],
            "pk": pk,
            "fields": fields.toJson(),
        };
    }

    class Fields {
    Fields({
        required this.watched,
        required this.title,
        required this.rating,
        required this.releaseDate,
        required this.review,
    });

    bool watched;
    String title;
    int rating;
    DateTime releaseDate;
    String review;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
            watched: json["watched"],
            title: json["title"],
            rating: json["rating"],
            releaseDate: DateTime.parse(json["release_date"]),
            review: json["review"],
        );

    Map<String, dynamic> toJson() => {
            "watched": watched,
            "title": title,
            "rating": rating,
            "release_date":
                "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
            "review": review,
        };
    }

    enum Model { MYWATCHLIST_MYWATCHLIST }

    final modelValues =
        EnumValues(map: {"mywatchlist.mywatchlist": Model.MYWATCHLIST_MYWATCHLIST});

    class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues({required this.map});

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
    }
    ```

3. Menambahkan halaman mywatchlist yang berisi semua watch list yang ada pada endpoint JSON di Django pada [Tugas 3](http://django-tugas-2-lyz.herokuapp.com/mywatchlist/json/)<br>
Hal ini dilakukan dengan membuat file `mywatchlist_page.dart` yang merupakan `Stateful Widget` untuk menampilkan semua watchlist. Selain itu, fungsi `fetchMyWatchList()` yang didefinisikan pada `fetch_mywatchlist.dart` digunakan untuk mengambil data mywatchlist.
    ```dart
    class MyWatchListPageState extends State<MyWatchListPage> {
    late Future<List<MyWatchList>> myWatchList;

    @override
    void initState() {
        super.initState();
        myWatchList = fetchMyWatchList();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
            title: const Text('My Watch List'),
            ),
            drawer: const MyDrawer(),
            body: FutureBuilder(
                future: myWatchList,
                builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return Column(
                        children: const [
                        Text(
                            "Tidak ada MyWatchList :(",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                    } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => GestureDetector(
                                onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyWatchDetail(
                                            myWatch: snapshot.data![index])),
                                );
                                },
                                child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: ((snapshot
                                                .data![index].fields.watched)
                                            ? Colors.green
                                            : Colors.red)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 0.5)
                                    ]),
                                child: Row(
                                    children: [
                                    Expanded(
                                        child: Text(
                                        "${snapshot.data![index].fields.title}",
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                    ),
                                    SizedBox(
                                        width: 30,
                                        child: CheckboxListTile(
                                            value: snapshot
                                                .data![index].fields.watched,
                                            onChanged: (bool? value) {
                                            setState(() {
                                                snapshot.data![index].fields
                                                        .watched =
                                                    !snapshot.data![index].fields
                                                        .watched;
                                            });
                                            }),
                                    )
                                    ],
                                ),
                                ),
                            ));
                    }
                }
                }));
    }
    }

    ```

4. Membuat navigasi dari setiap judul watch list ke halaman detail<br>
Hal ini dilakukan dengan menggunakan widget `GestureDetector` pada `ListView.builder` dan memanfaatkan properti `onTap` dengan value berupa `fungsi` yang digunakan untuk untuk menavigasi ke halaman detail dari masing-masing judul watchlist.
    ```
    GestureDetector(
        onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyWatchDetail(
                    myWatch: snapshot.data![index])),
        );
        },
        child: ...)
    ```

5. Menambahkan halaman detail untuk setiap mywatchlist<br>
Hal ini dilakukan dengan membuat file `mywatchlist_detail.dart` yang berfungsi untuk menampilkan halaman detail untuk masing-masing watchlist. Perhatikan bahwa class `MyWatchDetail` memiliki *required parameter* berupa `MyWatchList`. Hal ini bertujuan untuk memanfaatkan objek yang di-*pass* ketika widget `MyWatchDetail` dibuat sehingga widget tersebut dapat menampilkan data dari objek tersebut.

6. Menambahkan tombol untuk kembali ke daftar mywatchlist<br>
Hal ini dilakukan dengan menambahkan `TextButton` pada build method dari widget `MyWatchDetail` dan memanfaatkan properti `onPressed` dengan value berupa `fungsi` yang digunakan untuk untuk menavigasi kembali ke halaman mywatchlsit.
    ```dart
    TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyWatchListPage()),
            );
        },
        child: const SizedBox(
            height: 40,
            width: 200,
            child: Center(
                child: Text(
                "Back",
                style: TextStyle(color: Colors.white),
                ),
            ))),
    ```
