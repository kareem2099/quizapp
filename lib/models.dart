class Question {
  String? questionText;
  List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  String? AnswerText;
  bool isCorrect;

  Answer(this.AnswerText, this.isCorrect);
}

List<Question> getQuestion() {
  List<Question> qlist = [];
  qlist.add(Question("Who is the owner of flutter?", [
    Answer("Oppo", false),
    Answer("Google", true),
    Answer("Nokia", false),
    Answer("Samsung", false),
  ]));
  qlist.add(Question("What the first product by apple?", [
    Answer("Iphone", false),
    Answer("Ipad", false),
    Answer("Labtop", false),
    Answer("Apple 1", true),
  ]));
  qlist.add(Question("Youtube is -------- platform?", [
    Answer("music Sharing", false),
    Answer("Video Sharing", false),
    Answer("Live streaming", false),
    Answer("all of the above", true),
  ]));
  qlist.add(Question("Are you sleep early", [
    Answer("yes", true),
    Answer("no", false),
  ]));
  return qlist;
}
