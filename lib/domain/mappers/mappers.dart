import 'package:ecommerce_app/app/extension.dart';

import '../../data/response/response.dart';
import '../models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(this?.id.OrEmpty() ?? "", this?.name.OrEmpty() ?? "",
        this?.numofbotifications.OrZero() ?? 0);
  }
}

extension ContactResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.OrEmpty() ?? "", this?.phone.OrEmpty() ?? "",
        this?.link?.OrEmpty() ?? "");
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(
        this.customerResponse.toDomain(), this.contactsResponse.toDomain());
  }
}

extension ForgotResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.OrEmpty() ?? "";
  }
}
