import 'package:bflutter/ui/produk_detail.dart';
import 'package:bflutter/ui/produk_page.dart';
import 'package:flutter/material.dart';
import 'package:bflutter/model/produk_model.dart';

import '../bloc/produk_bloc.dart';
import '../widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;

  ProdukForm({Key? key,this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}
class _ProdukFormState extends State<ProdukForm>{
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }
  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
        widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }
  //Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
        keyboardType: TextInputType.text,
        controller: _kodeProdukTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Kode Produk harus diisi";
            }
          return null;
          },
    );
  }
  //Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
        keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
          }
        return null;
      },
    );
  }
  //Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
          }
        return null;
      },
    );
  }
  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate){
          if(!_isLoading){
            if(widget.produk != null){
              //kodisi  update produk
              ubah();
            }else{
              //kodisi tambah produk
              simpan();
            }
          }
        }
        });
    }
  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk =
      int.parse(_hargaProdukTextboxController.text);
      ProdukBloc.addProduk(produk: createProduk).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
      }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
          ));
      });
      setState(() {
        _isLoading = false;
      });
  }
  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: null);
    updateProduk.id = widget.produk!.id;
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
        description: "Permintaan ubah data gagal, silahkan coba lagi",
        ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}


//
//
// Widget build(BuildContext context){
//   return Scaffold(
//   appBar: AppBar(
//   title: const Text('Form Produk'),
//   ),
//     body: SingleChildScrollView(
//     child: Column(
//     children: [
//       _textboxKodeProduk(),
//       _textboxNamaProduk(),
//       _textboxHargaProduk(),
//       _tombolSimpan()
//     ],
//     ),
//     ),
//   );
// }
// _textboxKodeProduk(){
//   return TextField(
//   decoration: const InputDecoration(labelText: "Kode Produk"),
//     controller: _kodeProdukTextboxController,
//   );
// }
// _textboxNamaProduk(){
//   return TextField(
//   decoration: const InputDecoration(labelText: "Nama Produk"),
//     controller: _namaProdukTextboxController,
//   );
// }
// _textboxHargaProduk(){
//   return TextField(
//   decoration: const InputDecoration(labelText: "Harga "),
//     controller: _hargaProdukTextboxController,
//   );
// }
// _tombolSimpan(){
//   return ElevatedButton(
//   onPressed: () {
//     String kodeProduk = _kodeProdukTextboxController.text;
//     String namaProduk = _namaProdukTextboxController.text;
//     int harga = int.parse(
//     _hargaProdukTextboxController.text); //parsing dari String ke int
//     // pindah ke halaman Produk Detail dan mengirim data
//     Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => ProdukDetail(
//     kodeProduk: kodeProduk,
//       namaProduk: namaProduk,
//       harga: harga,
//     )));
//   },
//       child: const Text('Simpan'));
// }
// }


