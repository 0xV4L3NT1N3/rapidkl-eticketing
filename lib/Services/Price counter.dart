class PriceChecker {
  PriceConfirm(String place) {
    double price;
    if (place == 'Merdeka') {
      price = 1.20;
    } else {
      price = 1.00;
    }
    return price;
  }
}
