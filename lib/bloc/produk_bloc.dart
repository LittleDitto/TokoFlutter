import 'dart:convert';
import 'package:bflutter/helpers/api.dart';
import 'package:bflutter/helpers/api_url.dart';
import 'package:bflutter/model/produk_model.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    try {
      String apiUrl = ApiUrl.listProduk;
      var response = await Api().get(apiUrl);
      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
        return listProduk.map((item) => Produk.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load produk: ${response.statusCode}");
      }
    } catch (e) {
      print("Errors: $e");
      rethrow;
    }
  }

  static Future addProduk({Produk? produk}) async {
    if (produk == null) {
      throw ArgumentError("Produk tidak boleh null");
    }
    String apiUrl = ApiUrl.createProduk;
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == 'success';
  }

  static Future<bool> deleteProduk({int? id}) async {
    if (id == null) throw ArgumentError("ID tidak boleh null");
    String apiUrl = ApiUrl.deleteProduk(id);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == 'success';
  }
}
