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