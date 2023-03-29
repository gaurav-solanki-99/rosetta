// // To parse this JSON data, do
// //
// //     final collectionCategory = collectionCategoryFromJson(jsonString);
//
// import 'dart:convert';
//
// CollectionCategory collectionCategoryFromJson(String str) => CollectionCategory.fromJson(json.decode(str));
//
// String collectionCategoryToJson(CollectionCategory data) => json.encode(data.toJson());
//
// class CollectionCategory {
//   CollectionCategory({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool status;
//   String message;
//   Data data;
//
//   factory CollectionCategory.fromJson(Map<String, dynamic> json) => CollectionCategory(
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.product,
//     this.productColors,
//     this.productAttributes,
//     this.productCertificates,
//   });
//
//   CollectionProduct product;
//   List<ProductColor> productColors;
//   List<ProductAttribute> productAttributes;
//   List<ProductCertificate> productCertificates;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     product: CollectionProduct.fromJson(json["product"]),
//     productColors: List<ProductColor>.from(json["product_colors"].map((x) => ProductColor.fromJson(x))),
//     productAttributes: List<ProductAttribute>.from(json["product_attributes"].map((x) => ProductAttribute.fromJson(x))),
//     productCertificates: List<ProductCertificate>.from(json["product_certificates"].map((x) => ProductCertificate.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product": product.toJson(),
//     "product_colors": List<dynamic>.from(productColors.map((x) => x.toJson())),
//     "product_attributes": List<dynamic>.from(productAttributes.map((x) => x.toJson())),
//     "product_certificates": List<dynamic>.from(productCertificates.map((x) => x.toJson())),
//   };
// }
//
// class CollectionProduct {
//   CollectionProduct({
//     this.id,
//     this.name,
//     this.price,
//     this.category,
//     this.coverImage,
//     this.backgroundImage,
//   });
//
//   String id;
//   String name;
//   int price;
//   String category;
//   String coverImage;
//   String backgroundImage;
//
//   factory CollectionProduct.fromJson(Map<String, dynamic> json) => CollectionProduct(
//     id: json["id"],
//     name: json["name"],
//     price: json["price"],
//     category: json["category"],
//     coverImage: json["cover_image"],
//     backgroundImage: json["background_image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "price": price,
//     "category": category,
//     "cover_image": coverImage,
//     "background_image": backgroundImage,
//   };
// }
//
// class ProductAttribute {
//   ProductAttribute({
//     this.id,
//     this.productId,
//     this.attributeId,
//     this.value,
//     this.createdDatetime,
//     this.attributeName,
//   });
//
//   String id;
//   String productId;
//   String attributeId;
//   String value;
//   DateTime createdDatetime;
//   String attributeName;
//
//   factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
//     id: json["id"],
//     productId: json["product_id"],
//     attributeId: json["attribute_id"],
//     value: json["value"],
//     createdDatetime: DateTime.parse(json["created_datetime"]),
//     attributeName: json["attribute_name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "attribute_id": attributeId,
//     "value": value,
//     "created_datetime": createdDatetime.toIso8601String(),
//     "attribute_name": attributeName,
//   };
// }
//
// class ProductCertificate {
//   ProductCertificate({
//     this.id,
//     this.productId,
//     this.navId,
//     this.title,
//     this.doc,
//     this.createdAt,
//   });
//
//   String id;
//   String productId;
//   dynamic navId;
//   String title;
//   String doc;
//   DateTime createdAt;
//
//   factory ProductCertificate.fromJson(Map<String, dynamic> json) => ProductCertificate(
//     id: json["id"],
//     productId: json["product_id"],
//     navId: json["nav_id"],
//     title: json["title"],
//     doc: json["doc"],
//     createdAt: DateTime.parse(json["created_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "nav_id": navId,
//     "title": title,
//     "doc": doc,
//     "created_at": createdAt.toIso8601String(),
//   };
// }
//
// class ProductColor {
//   ProductColor({
//     this.id,
//     this.productsId,
//     this.imageClassId,
//     this.imagePath,
//     this.isRectangularImage,
//     this.isCoverImage,
//     this.productColorCode,
//     this.navId,
//     this.description,
//     this.searchDescription,
//     this.colour,
//     this.isActive,
//     this.displayInConfigurator,
//     this.displayInCatalogue,
//   });
//
//   String id;
//   String productsId;
//   String imageClassId;
//   String imagePath;
//   String isRectangularImage;
//   String isCoverImage;
//   String productColorCode;
//   String navId;
//   String description;
//   String searchDescription;
//   String colour;
//   String isActive;
//   List<String> displayInConfigurator;
//   String displayInCatalogue;
//
//   factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
//     id: json["id"],
//     productsId: json["products_id"],
//     imageClassId: json["image_class_id"],
//     imagePath: json["image_path"],
//     isRectangularImage: json["is_rectangular_image"],
//     isCoverImage: json["is_cover_image"],
//     productColorCode: json["product_color_code"],
//     navId: json["nav_id"],
//     description: json["description"],
//     searchDescription: json["search_description"],
//     colour: json["colour"],
//     isActive: json["is_active"],
//     displayInConfigurator: json["display_in_configurator"],
//     displayInCatalogue: json["display_in_catalogue"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "products_id": productsId,
//     "image_class_id": imageClassId,
//     "image_path": imagePath,
//     "is_rectangular_image": isRectangularImage,
//     "is_cover_image": isCoverImage,
//     "product_color_code": productColorCode,
//     "nav_id": navId,
//     "description": description,
//     "search_description": searchDescription,
//     "colour": colour,
//     "is_active": isActive,
//     "display_in_configurator": displayInConfigurator,
//     "display_in_catalogue": displayInCatalogue,
//   };
// }
