class ClientModel {
  String id;
  String note;
  String name;
  String type;
  int startDate;
  int endDate;

  ClientModel({
    this.id = "",  // Optional parameter with a default empty value
    required this.name,
    required this.note,
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  // Factory method to create an instance from JSON
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json["id"] ?? "",         // Handle null ID gracefully
      name: json["name"] ?? "",
      note: json["note"] ?? "",
      type: json["type"] ?? "",
      startDate: json["startDate"]?.toInt() ?? 0,
      endDate: json["endDate"]?.toInt() ?? 0,
    );
  }

  // Convert the model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "note": note,
      "type": type,
      "startDate": startDate,
      "endDate": endDate,
    };
  }
}
