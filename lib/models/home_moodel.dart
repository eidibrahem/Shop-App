class HomeModel {
  bool? status;

  Data? data;

  HomeModel.fromjson(Map<String, dynamic?>? json) {
    status = json!['status'];

    data = json['data'] != null ? new Data.fromjson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Banners>? banners;
  List<Products>? products;

  Data({List<Banners>? banners, List<Products>? products}) {
    if (banners != null) {
      this.banners = banners;
    }
    if (products != null) {
      this.products = products;
    }
  }

  Data.fromjson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromjson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromjson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Banners {
  int? id;
  String? image;

  Banners({int? id, String? image}) {
    if (id != null) {
      this.id = id;
    }
    if (image != null) {
      this.image = image;
    }
  }

  int? get kid => this.id;
  set kid(int? id) => this.id = id;
  String? get kimage => image;
  set kimage(String? image) => this.image = image;

  Banners.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;

    return data;
  }
}

class Products {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;

  bool? inFavorites=true;
  bool? inCart;

  Products(
      {int? id,
      dynamic price,
      dynamic oldPrice,
      dynamic discount,
      String? image,
      String? name,
      String? description,
      List<String>? images,
      bool? inFavorites,
      bool? inCart}) {
    if (id != null) {
      this.id = id;
    }
    if (price != null) {
      this.price = price;
    }
    if (oldPrice != null) {
      this.oldPrice = oldPrice;
    }
    if (discount != null) {
      this.discount = discount;
    }
    if (image != null) {
      this.image = image;
    }
    if (name != null) {
      this.name = name;
    }
    if (description != null) {
      this.description = description;
    }

    if (inFavorites != null) {
      this.inFavorites = inFavorites;
    }
    if (inCart != null) {
      this.inCart = inCart;
    }
  }

  Products.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];

    inFavorites = json['in_favorites'];
    print(json['id'].toString());
    print(json["in_favorites"]);
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}

/*


class HomeModel {
    bool? _status;
    Null? _message;
    Data? _data;
  
    HomeModel({bool? status, Null? message, Data? data}) {
      if (status != null) {
        this._status = status;
      }
      if (message != null) {
        this._message = message;
      }
      if (data != null) {
        this._data = data;
      }
    }
  
    bool? get status => _status;
    set status(bool? status) => _status = status;
    Null? get message => _message;
    set message(Null? message) => _message = message;
    Data? get data => _data;
    set data(Data? data) => _data = data;
  
    HomeModel.fromJson(Map<String, dynamic> json) {
      _status = json['status'];
      _message = json['message'];
      _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['status'] = this._status;
      data['message'] = this._message;
      if (this._data != null) {
        data['data'] = this._data!.toJson();
      }
      return data;
    }
  }
  
  class Data {
    List<Banners>? _banners;
    List<Products>? _products;
    String? _ad;
  
    Data({List<Banners>? banners, List<Products>? products, String? ad}) {
      if (banners != null) {
        this._banners = banners;
      }
      if (products != null) {
        this._products = products;
      }
      if (ad != null) {
        this._ad = ad;
      }
    }
  
    List<Banners>? get banners => _banners;
    set banners(List<Banners>? banners) => _banners = banners;
    List<Products>? get products => _products;
    set products(List<Products>? products) => _products = products;
    String? get ad => _ad;
    set ad(String? ad) => _ad = ad;
  
    Data.fromJson(Map<String, dynamic> json) {
      if (json['banners'] != null) {
        _banners = <Banners>[];
        json['banners'].forEach((v) {
          _banners!.add(new Banners.fromJson(v));
        });
      }
      if (json['products'] != null) {
        _products = <Products>[];
        json['products'].forEach((v) {
          _products!.add(new Products.fromJson(v));
        });
      }
      _ad = json['ad'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this._banners != null) {
        data['banners'] = this._banners!.map((v) => v.toJson()).toList();
      }
      if (this._products != null) {
        data['products'] = this._products!.map((v) => v.toJson()).toList();
      }
      data['ad'] = this._ad;
      return data;
    }
  }
  
  class Banners {
    int? _id;
    String? _image;
    Null? _category;
    Null? _product;
  
    Banners({int? id, String? image, Null? category, Null? product}) {
      if (id != null) {
        this._id = id;
      }
      if (image != null) {
        this._image = image;
      }
      if (category != null) {
        this._category = category;
      }
      if (product != null) {
        this._product = product;
      }
    }
  
    int? get id => _id;
    set id(int? id) => _id = id;
    String? get image => _image;
    set image(String? image) => _image = image;
    Null? get category => _category;
    set category(Null? category) => _category = category;
    Null? get product => _product;
    set product(Null? product) => _product = product;
  
    Banners.fromJson(Map<String, dynamic> json) {
      _id = json['id'];
      _image = json['image'];
      _category = json['category'];
      _product = json['product'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this._id;
      data['image'] = this._image;
      data['category'] = this._category;
      data['product'] = this._product;
      return data;
    }
  }
  
  class Products {
    int? _id;
    double? _price;
    double? _oldPrice;
    int? _discount;
    String? _image;
    String? _name;
    String? _description;
    List<String>? _images;
    bool? _inFavorites;
    bool? _inCart;
  
    Products(
        {int? id,
        double? price,
        double? oldPrice,
        int? discount,
        String? image,
        String? name,
        String? description,
        List<String>? images,
        bool? inFavorites,
        bool? inCart}) {
      if (id != null) {
        this._id = id;
      }
      if (price != null) {
        this._price = price;
      }
      if (oldPrice != null) {
        this._oldPrice = oldPrice;
      }
      if (discount != null) {
        this._discount = discount;
      }
      if (image != null) {
        this._image = image;
      }
      if (name != null) {
        this._name = name;
      }
      if (description != null) {
        this._description = description;
      }
      if (images != null) {
        this._images = images;
      }
      if (inFavorites != null) {
        this._inFavorites = inFavorites;
      }
      if (inCart != null) {
        this._inCart = inCart;
      }
    }
  
    int? get id => _id;
    set id(int? id) => _id = id;
    double? get price => _price;
    set price(double? price) => _price = price;
    double? get oldPrice => _oldPrice;
    set oldPrice(double? oldPrice) => _oldPrice = oldPrice;
    int? get discount => _discount;
    set discount(int? discount) => _discount = discount;
    String? get image => _image;
    set image(String? image) => _image = image;
    String? get name => _name;
    set name(String? name) => _name = name;
    String? get description => _description;
    set description(String? description) => _description = description;
    List<String>? get images => _images;
    set images(List<String>? images) => _images = images;
    bool? get inFavorites => _inFavorites;
    set inFavorites(bool? inFavorites) => _inFavorites = inFavorites;
    bool? get inCart => _inCart;
    set inCart(bool? inCart) => _inCart = inCart;
  
    Products.fromJson(Map<String, dynamic> json) {
      _id = json['id'];
      _price = json['price'];
      _oldPrice = json['old_price'];
      _discount = json['discount'];
      _image = json['image'];
      _name = json['name'];
      _description = json['description'];
      _images = json['images'].cast<String>();
      _inFavorites = json['in_favorites'];
      _inCart = json['in_cart'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this._id;
      data['price'] = this._price;
      data['old_price'] = this._oldPrice;
      data['discount'] = this._discount;
      data['image'] = this._image;
      data['name'] = this._name;
      data['description'] = this._description;
      data['images'] = this._images;
      data['in_favorites'] = this._inFavorites;
      data['in_cart'] = this._inCart;
      return data;
    }
  }


*/


