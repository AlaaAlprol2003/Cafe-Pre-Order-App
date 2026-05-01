import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/graduation_project_model.dart';

class OrderModel {
  String orderId;
  Products product;
  String uId;
  String size;
  String sugarLevel;
  String? milkType;
  int quantity;
  double totalPrice;

  OrderModel(
      {required this.orderId,
      required this.product,
      required this.size,
      required this.sugarLevel,
      required this.milkType,
      required this.quantity,
      required this.uId,
      required this.totalPrice});

  OrderModel.fromJson(Map<String, dynamic> json)
      : this(
            orderId: json["orderId"],
            uId: json["userId"],
            product: Data.allProducts.firstWhere(
                (product) => product.productid == json["productId"]),
            size: json["size"],
            sugarLevel: json["sugarLevel"],
            milkType: json["milkType"],
            quantity: json["quantity"],
            totalPrice: json["totalPrice"]);

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "productId": product.productid,
        "userId": uId,
        "size": size,
        "sugarLevel": sugarLevel,
        "milkType": milkType,
        "quantity": quantity,
        "totalPrice": totalPrice
      };
}
