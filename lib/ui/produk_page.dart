import 'package:bflutter/ui/produk_detail.dart';
import 'package:bflutter/ui/produk_form.dart';
import 'package:bflutter/model/produk_model.dart';
import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/produk_bloc.dart';
import 'login_page.dart';

class ProdukPage extends StatefulWidget {
  final dynamic produk;

  const ProdukPage({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukForm()),
                );
                if (result == true) {
                  setState(() {});
                }
              },
            ),
          )
        ],
      ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()))
                  });
                },
              )
            ],
          ),
    ),
      body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Produk tidak tersedia'),
            );
          } else {
            return ListProduk(list: snapshot.data);
          }
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;
  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produkList = list ?? [];
    return ListView.builder(
      itemCount: produkList.length,
      itemBuilder: (context, i) {
        return ItemProduk(produk: produkList[i]);
      },
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk ?? 'Produk tanpa nama'),
          subtitle: Text('Harga: Rp. ${produk.hargaProduk?.toString() ?? '0'}'),
        ),
      ),
    );
  }
}
