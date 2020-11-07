import 'dart:convert';

class AnswerModel {
  final String answer;
  final DateTime dateTimeAnswer;
  AnswerModel({
    this.answer,
    this.dateTimeAnswer,
  });

  AnswerModel copyWith({
    String answer,
    DateTime dateTimeAnswer,
  }) {
    return AnswerModel(
      answer: answer ?? this.answer,
      dateTimeAnswer: dateTimeAnswer ?? this.dateTimeAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'dateTimeAnswer': dateTimeAnswer?.millisecondsSinceEpoch,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return AnswerModel(
      answer: map['answer'],
      dateTimeAnswer: DateTime.fromMillisecondsSinceEpoch(map['dateTimeAnswer']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) => AnswerModel.fromMap(json.decode(source));

  @override
  String toString() => 'AnswerModel(answer: $answer, dateTimeAnswer: $dateTimeAnswer)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is AnswerModel &&
      o.answer == answer &&
      o.dateTimeAnswer == dateTimeAnswer;
  }

  @override
  int get hashCode => answer.hashCode ^ dateTimeAnswer.hashCode;
}
