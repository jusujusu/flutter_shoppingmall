// 상품 데이터 설정
class Product {
  int? productNo;
  String? productName;
  String? productDetails;
  String? productImageUrl;
  double? price;

  // 생성자
  Product({
    this.productNo,
    this.productName,
    this.productDetails,
    this.productImageUrl,
    this.price,
  });

  // JSON 데이터를 Product 객체로 변환하는 팩토리 생성자
  Product.fromJson(Map<String, dynamic> json) {
    productNo = int.parse(json['productNo']);
    productName = json['productName'];
    productDetails = json['productDetails'];
    productImageUrl = json['productImageUrl'];
    price = double.parse(json['price']);
  }

  // Product 객체를 JSON 데이터로 변환하는 메서드
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productNo'] = productNo;
    data['productName'] = productName;
    data['productDetails'] = productDetails;
    data['productImageUrl'] = productImageUrl;
    data['price'] = price;
    return data;
  }
}