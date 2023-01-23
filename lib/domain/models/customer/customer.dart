class WooCustomer {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  String? password;
  Billing? billing;
  Shipping? shipping;
  bool? isPayingCustomer;
  String? avatarUrl;
  List<WooCustomerMetaData>? metaData;
  Links? links;
  String? name;

  WooCustomer(
      {this.id,
      this.dateCreated,
      this.name,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.email,
      this.firstName,
      this.lastName,
      this.role,
      this.username,
      this.password,
      this.billing,
      this.shipping,
      this.isPayingCustomer,
      this.avatarUrl,
      this.metaData,
      this.links});

  WooCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    name = json['name'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    username = json['username'];
    billing =
        json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    isPayingCustomer = json['is_paying_customer'];
    avatarUrl = json['avatar_url'];

    links = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (dateCreated != null) {
      result.addAll({'dateCreated': dateCreated});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (dateCreatedGmt != null) {
      result.addAll({'dateCreatedGmt': dateCreatedGmt});
    }
    if (dateModified != null) {
      result.addAll({'dateModified': dateModified});
    }
    if (dateModifiedGmt != null) {
      result.addAll({'dateModifiedGmt': dateModifiedGmt});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (firstName != null) {
      result.addAll({'first_name': firstName});
    }
    if (lastName != null) {
      result.addAll({'last_name': lastName});
    }
    if (role != null) {
      result.addAll({'role': role});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (billing != null) {
      result.addAll({'billing': billing!.toJson()});
    }
    if (shipping != null) {
      result.addAll({'shipping': shipping!.toJson()});
    }
    if (isPayingCustomer != null) {
      result.addAll({'isPayingCustomer': isPayingCustomer});
    }
    if (avatarUrl != null) {
      result.addAll({'avatarUrl': avatarUrl});
    }
    if (metaData != null) {
      result.addAll({'metaData': metaData!.map((x) => x.toJson()).toList()});
    }
    if (links != null) {
      result.addAll({'links': links!.toJson()});
    }

    return result;
  }

  @override
  toString() => this.toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooCustomer && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  WooCustomer copyWith({
    int? id,
    String? dateCreated,
    String? dateCreatedGmt,
    String? dateModified,
    String? dateModifiedGmt,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? username,
    String? password,
    Billing? billing,
    Shipping? shipping,
    bool? isPayingCustomer,
    String? avatarUrl,
    List<WooCustomerMetaData>? metaData,
    Links? links,
  }) {
    return WooCustomer(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
      dateModified: dateModified ?? this.dateModified,
      dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      username: username ?? this.username,
      password: password ?? this.password,
      billing: billing ?? this.billing,
      shipping: shipping ?? this.shipping,
      isPayingCustomer: isPayingCustomer ?? this.isPayingCustomer,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      metaData: metaData ?? this.metaData,
      links: links ?? this.links,
    );
  }
}

class WooCustomerMetaData {
  final int? id;
  final String? key;
  final dynamic value;

  WooCustomerMetaData(this.id, this.key, this.value);

  WooCustomerMetaData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        value = json['value'];

  Map<String, dynamic> toJson() => {'id': id, 'key': key, 'value': value};
}

class Billing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  Billing(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (firstName != null) {
      result.addAll({'first_name': firstName});
    }
    if (lastName != null) {
      result.addAll({'last_name': lastName});
    }
    if (company != null) {
      result.addAll({'company': company});
    }
    if (address1 != null) {
      result.addAll({'address1': address1});
    }
    if (address2 != null) {
      result.addAll({'address2': address2});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (state != null) {
      result.addAll({'state': state});
    }
    if (postcode != null) {
      result.addAll({'postcode': postcode});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }

    return result;
  }

  Billing copyWith({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? email,
    String? phone,
  }) {
    return Billing(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Shipping(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    company = json['company'] ?? "";
    address1 = json['address_1'] ?? "";
    address2 = json['address_2'] ?? "";
    city = json['city'] ?? "";
    state = json['state'] ?? "";
    postcode = json['postcode'] ?? "";
    country = json['country'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (firstName != null) {
      result.addAll({'first_name': firstName});
    }
    if (lastName != null) {
      result.addAll({'last_name': lastName});
    }
    if (company != null) {
      result.addAll({'company': company});
    }
    if (address1 != null) {
      result.addAll({'address1': address1});
    }
    if (address2 != null) {
      result.addAll({'address2': address2});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (state != null) {
      result.addAll({'state': state});
    }
    if (postcode != null) {
      result.addAll({'postcode': postcode});
    }
    if (country != null) {
      result.addAll({'country': country});
    }

    return result;
  }
}

class Links {
  List<Self>? self;
  List<Collection>? collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(new Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Collection {
  String? href;

  Collection({this.href});

  Collection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
