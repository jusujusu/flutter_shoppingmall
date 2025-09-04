/*
 장바구니 페이지
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingmall/constants.dart';
import 'package:shoppingmall/item_checkout_page.dart';
import 'package:shoppingmall/models/product.dart';

class ItemBasketPage extends StatefulWidget {
  // 생성자
  const ItemBasketPage({super.key});

  @override
  State<ItemBasketPage> createState() =>
      _ItemBasketPageState();
}

class _ItemBasketPageState extends State<ItemBasketPage> {
  // 장바구니 목록 더미 데이터
  List<Product> basketList = [
    Product(
      productNo: 1,
      productName: "노트북(Laptop)",
      productImageUrl: "https://picsum.photos/id/1/300/300",
      price: 600000,
    ),
    Product(
      productNo: 4,
      productName: "키보드(Keyboard)",
      productImageUrl:
          "https://picsum.photos/id/60/300/300",
      price: 50000,
    ),
  ];

  // 장바구니 수량 더미 데이터
  List<Map<int, int>> quantityList = [
    {1: 2},
    {4: 3},
  ];

  // 장바구니 가격 총 합
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < basketList.length; i++) {
      totalPrice +=
          basketList[i].price! *
          quantityList[i][basketList[i].productNo]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("장바구니"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: basketList.length,
        itemBuilder: (context, index) {
          return basketContainer(
            productNo: basketList[index].productNo ?? 0,
            productName:
                basketList[index].productName ?? "",
            productImageUrl:
                basketList[index].productImageUrl ?? "",
            price: basketList[index].price ?? 0,
            quantity:
                quantityList[index][basketList[index]
                    .productNo] ??
                0,
          );
        },
      ),
      // 결제 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {
            //결제 페이지로 이동
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ItemCheckoutPage();
                },
              ),
            );
          },
          child: Text(
            "총 ${numberFormat.format(totalPrice)}원 결제하기",
          ),
        ),
      ),
    );
  }

  // 장바구니 컨테이너 위젯
  Widget basketContainer({
    required int productNo,
    required String productName,
    required String productImageUrl,
    required double price,
    required int quantity,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 장바구니 상품 이미지
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.cover,
            imageUrl: productImageUrl,
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const Center(child: Text("오류 발생"));
            },
          ),

          // 장바구니 상품 정보
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 장바구니 상품 이름
                Text(
                  productName,
                  textScaler: TextScaler.linear(1.5),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 상품 가격
                Text("${numberFormat.format(price)}원"),
                Row(
                  children: [
                    const Text("수량"),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                Text(
                  "합계 : ${numberFormat.format(price * quantity)}원",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
