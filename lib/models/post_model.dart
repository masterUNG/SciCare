class PostModel {
  String message;
  String dateTimeMessage;
  String answerAdmin;

  PostModel({this.message, this.dateTimeMessage, this.answerAdmin});

  PostModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    dateTimeMessage = json['DateTimeMessage'];
    answerAdmin = json['AnswerAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['DateTimeMessage'] = this.dateTimeMessage;
    data['AnswerAdmin'] = this.answerAdmin;
    return data;
  }
}

