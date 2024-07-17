class CurrencyDataModel{
  int USD;
  int EUR;
  int GBP;
  int INR;
  int JPY;
  int AUD;

  CurrencyDataModel(
      {required this.USD,
    required this.EUR,
    required this.GBP,
    required this.INR,
    required this.JPY,
    required this.AUD,
  });

  factory CurrencyDataModel.fromJson(Map<String, dynamic> json) {
    return CurrencyDataModel(
        USD: json['USD'],
        EUR: json['EUR'],
        GBP: json['GBP'],
        INR: json['INR'],
        JPY: json['JPY'],
        AUD: json['AUD']);
  }
}