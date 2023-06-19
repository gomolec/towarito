import 'dart:developer';

import '../../core/error/exceptions.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class ProductsRemoteDatasource {
  /// Returns an updated [Product] with downloaded urls.
  ///
  /// Throw a [ConnectionException] when there is no internet connection.
  Future<Product> getProductRemoteData(Product product);
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  @override
  Future<Product> getProductRemoteData(Product product) async {
    final url = Uri.https(
      'krukam.pl',
      'search.php',
      {
        'xmlType': 'typeahead',
        'getProductXML': 'true',
        'json': 'true',
        'text': product.code.replaceAll(' ', ''),
        'limit': '1',
      },
    );

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
      },
    );
    log("$url $response");

    if (response.statusCode != 200) {
      throw ConnectionException;
    }

    final jsonResponse = convert.jsonDecode(response.body);
    return product.copyWith(
      imageUrl: () =>
          "https://krukam.pl${jsonResponse['products'][0]['icon_src']}",
      url: () => "https://krukam.pl${jsonResponse['products'][0]['link']}",
    );
  }
}
