class SlideObject {
  String title;
  String subtitile;
  String image;

  SlideObject(this.title, this.subtitile, this.image);
}

class SliderViewObject {
  SlideObject slideObject;
  int numberofslides;
  int currentindex;

  SliderViewObject(this.slideObject, this.currentindex, this.numberofslides);
}

class Customer {
  String id;
  String name;
  int numofbotifications;

  Customer(this.id, this.name, this.numofbotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Contacts? contacts;
  Customer? customer;

  Authentication(this.customer, this.contacts);
}

class ForgotPassword {
  String support;

  ForgotPassword(this.support);
}
