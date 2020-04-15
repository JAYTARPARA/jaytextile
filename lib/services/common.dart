import 'dart:convert';

import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:http/http.dart' as http;

class Common {
  String mobile = '919824868568';
  String commonMsg = "Hey, I want to know more about Jay Textile...";
  var response, apiSendURL;
  var resultError;
  var apiURL = 'http://textile.jaytarpara.in';
  WooCommerceAPI wcAPI = new WooCommerceAPI(
    "http://textile.jaytarpara.in",
    "ck_7b4ff0cb8989b3f2595414dfa4d2782c70c84130",
    "cs_495fec8a56ffc6581d4b9255a4ec5e34683769f4",
  );

  Future getAllProducts() async {
    var prodAll = await wcAPI.getAsync("products?page=1&per_page=15");
    return prodAll;
  }

  Future getSliderProducts() async {
    var prodSlider = await wcAPI.getAsync("products?category=94");
    return prodSlider;
  }

  Future loadMoreProducts(page) async {
    var loadMore = await wcAPI.getAsync("products?page=$page&per_page=15");
    return loadMore;
  }

  Future loadMoreProductsWithCategory(cid, page) async {
    var loadMoreWithCategory =
        await wcAPI.getAsync("products?category=$cid&page=$page&per_page=15");
    return loadMoreWithCategory;
  }

  Future getProductDetails(pid) async {
    var productDetails = await wcAPI.getAsync("products/$pid");
    return productDetails;
  }

  Future getRelatedProduct(cid) async {
    // var getProducts = cid.join(',');
    var prodLength = 5;
    var returnProducts = [];
    if (cid.length < 5) {
      prodLength = cid.length;
    }
    for (var i = 0; i < prodLength; i++) {
      var relatedProducts = await wcAPI.getAsync("products/${cid[i]}");
      returnProducts.add(relatedProducts);
    }
    // print(returnProducts);
    return returnProducts;
  }

  Future getProductCategories() async {
    var prodCategories =
        await wcAPI.getAsync("products/categories?parent=0&order=desc");
    return prodCategories;
  }

  Future getSubCategories(cid) async {
    var subCategories =
        await wcAPI.getAsync("products/categories?parent=$cid&order=desc");
    return subCategories;
  }

  Future getCategoryProducts(cid) async {
    var catProducts = await wcAPI.getAsync("products?category=$cid");
    return catProducts;
  }

  Future getPage(pageid) async {
    apiSendURL = '$apiURL/wp-json/wp/v2/pages/$pageid';
    try {
      response = await http.get(apiSendURL);
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }
}
