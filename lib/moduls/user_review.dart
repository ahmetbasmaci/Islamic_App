class UserReviewsData {
  List<ReviewData> data;

  UserReviewsData({required this.data});

  factory UserReviewsData.fromJson(Map<String, dynamic> json) {
    List<ReviewData> data = [];
    for (var element in json['data']) data.add(ReviewData.fromJson(element as Map<String, dynamic>));
    return UserReviewsData(
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['data'] = data;
    return data;
  }
}

class ReviewData {
  String name;
  String review;
  String machineCode;
  ReviewData({required this.name, required this.review, required this.machineCode});

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      name: json['name'],
      review: json['review'],
      machineCode: json['machineCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['review'] = review;
    data['name'] = name;
    data['machineCode'] = machineCode;
    return data;
  }
}
