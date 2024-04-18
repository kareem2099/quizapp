import 'package:flutter/material.dart';
import 'package:quizapp/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Question> questionList = getQuestion();
  int currentQuestion = 0;
  int score = 0;
  Color textColor = Colors.black;
  Answer? selectedAnswer;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Simple Quiz App",
            style: TextStyle(
              fontSize: 29,
              fontFamily: "Dansing Script",
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Question ${currentQuestion + 1}/${questionList.length}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: "Dancing Script"),
                ),
                const SizedBox(height: 30),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 80,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            textColor = textColor == Colors.black
                                ? Colors.white
                                : Colors.black;
                          });
                        },
                        child: Text(
                          "${questionList[currentQuestion].questionText}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: -18,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.check, color: Colors.green),
                      ),
                    ),
                    const Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: FractionalTranslation(
                        translation: Offset(0.47, 0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: FractionalTranslation(
                        translation: Offset(-0.47, 0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    for (Answer answer
                        in questionList[currentQuestion].answerList)
                      AnswerButton(answer)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                nextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnswerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;
    return Container(
      margin: const EdgeInsets.all(10),
      width: 150,
      height: 40,
      decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: isSelected ? Colors.orange : Colors.white,
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
          });
        },
        child: Text(
          "${answer.AnswerText}",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  nextButton() {
    bool isLastQuestion = false;
    if (currentQuestion == questionList.length - 1) {
      isLastQuestion = true;
    }
    return Container(
      margin: const EdgeInsets.all(10),
      width: 180,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          if (selectedAnswer!.isCorrect) {
            score++;
          }
          if (selectedAnswer == null) {
          } else {
            if (isLastQuestion) {
              bool isPassed = false;
              if (score >= questionList.length * 0.5) {
                isPassed = true;
              }

              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      "${isPassed ? 'passed' : 'failed'} | score is $score",
                      style: TextStyle(
                          color: score >= questionList.length * 0.5
                              ? Colors.green
                              : Colors.red),
                    ),
                    content: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10)), // Apply the same shape to ensure consistent appearance
                      color: Colors.black,
                      minWidth: 200,
                      height: 40,
                      textColor: Colors.white,
                      child: const Text(
                        "Restart",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                          currentQuestion = 0;
                          selectedAnswer = null;
                          score = 0;
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              setState(() {
                selectedAnswer = null;
                currentQuestion++;
              });
            }
          }
        },
        child: Text(
          isLastQuestion ? "S u b m i t  " : "N e x t",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
