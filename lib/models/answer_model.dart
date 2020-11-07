class AnswerModel {
  String answer;
  String dateTimeAnswer;

  AnswerModel({this.answer, this.dateTimeAnswer});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    answer = json['Answer'];
    dateTimeAnswer = json['DateTimeAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Answer'] = this.answer;
    data['DateTimeAnswer'] = this.dateTimeAnswer;
    return data;
  }
}
