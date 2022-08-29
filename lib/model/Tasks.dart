class Tasks {
  int? id;
  String? title;
  String? description;
  int? status;

  taskMap() {
    var mapping = Map<String, dynamic>();
    mapping["id"] = id;
    mapping["title"] = title;
    mapping["description"] = description;
    mapping["status"] = status;

    return mapping;
  }

  getBool(int x) {
    bool value;
    if (x == 1)
      value = true;
    else
      value = false;
    return value;
  }
}
