class TransactionModel {
  String? transactionName;
  int? amount;
  String? transactionType;
  String? date;

  TransactionModel(
      {this.transactionName, this.amount, this.transactionType, this.date});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    transactionName = json["transactionName"];
    amount = json["amount"];
    transactionType = json["transactionType"];
    date = json["date"];
  }

  static List<TransactionModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => TransactionModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["transactionName"] = transactionName;
    _data["amount"] = amount;
    _data["transactionType"] = transactionType;
    _data["date"] = date;
    return _data;
  }
}
