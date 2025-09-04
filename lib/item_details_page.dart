/* 
상품 상세 페이지 
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingmall/constants.dart';
import 'package:shoppingmall/models/product.dart';

class ItemDetailsPage extends StatefulWidget {
  // 받아올 상품 정보
  int productNo;
  String productName;
  String productImageUrl;
  double price;

  ItemDetailsPage({
    super.key,
    required this.productNo,
    required this.productName,
    required this.productImageUrl,
    required this.price,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바
      appBar: AppBar(
        // 제목
        title: const Text("제품 상세 페이지"),
        centerTitle: true,
      ),
      // body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상품 이미지
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
                imageUrl: widget.productImageUrl,
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorWidget: (context, url, error) {
                  return const Center(child: Text("오류 발생"));
                },
              ),
            ),

            // 상품 이름
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                widget.productName,
                textScaler: TextScaler.linear(1.5),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            // 상품 가격
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "${numberFormat.format(widget.price)}원",
                textScaler: TextScaler.linear(1.3),
              ),
            ),
          ],
        ),
      ),

      // 장바구니 담기 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(onPressed: () {}, child: const Text("장바구니 담기")),
      ),
    );
  }
}
