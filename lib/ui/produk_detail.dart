import 'package:bflutter/ui/produk_form.dart';
import 'package:bflutter/ui/produk_page.dart';
import 'package:flutter/material.dart';
import '../model/produk_model.dart';
import 'package:bflutter/bloc/produk_bloc.dart';


class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}
class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        ),
      body: Center(
        child: Column(
            children: [
              Text(
                "Kode : ${widget.produk!.kodeProduk}",
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                "Nama : ${widget.produk!.namaProduk}",
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
                style: const TextStyle(fontSize: 18.0),
              ),
              _tombolHapusEdit()
            ],
        ),
      ),
    );
  }
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
        children: [
          //Tombol Edit
          OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => ProdukForm(produk: widget.produk!)));
            }),
            //Tombol Hapus
            OutlinedButton(
              child: const Text("DELETE"), onPressed: () => confirmHapus()),
        ],
      );
    }
  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () async {
            try {
              bool success = await ProdukBloc.deleteProduk(id: widget.produk!.id);
              Navigator.pop(context); // Tutup dialog
              if (success) {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produk berhasil dihapus.')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal menghapus produk.')),
                );
              }
            } catch (e) {
              print("Error: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Terjadi kesalahan: $e')),
              );
            }
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }


}


