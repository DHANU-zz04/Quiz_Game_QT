
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import RandomQuestionFilterModels 1.0

Page {
    id: quiz

    property int correctAnswers: 0

    signal finnished(int correctAnswers)

    width: parent.width
    height: parent.height

    Component.onCompleted: {
        quizPageRepeater.itemAt(quizPageRepeater.count - 1).lastQuestion = true
    }

    SwipeView {
        id: quizSwipeView
        interactive: false
        anchors.fill: parent

        Repeater {
            id: quizPageRepeater
            model: RandomQuestionFilterModel
            delegate: QuizPage {
                questionId: model.idx
                askedQuestion: model.askedQuestion
                answer1: model.answer1
                answer2: model.answer2
                answer3: model.answer3
                answer4: model.answer4
                correctAnswer: model.correctAnswer
                picture: model.picture
                onAnsweredCorrectly: quiz.answeredCorrectly()
                onAnsweredWrong: quiz.answeredWrong()
            }
        }
    }

    footer: ColumnLayout {
        Label {
            id: footerTextArea
            text: qsTr("Question %1 / %2").arg(
                      quizSwipeView.currentIndex + 1).arg(quizSwipeView.count)
            Layout.alignment: Qt.AlignRight
        }
    }

    function answeredCorrectly() {
        ++quiz.correctAnswers
        loadNextQuestionOrEmitFinnished()
    }

    function answeredWrong() {
        loadNextQuestionOrEmitFinnished()
    }

    function loadNextQuestionOrEmitFinnished() {
        if (quizSwipeView.currentIndex < quizSwipeView.count - 1) {
            quizSwipeView.incrementCurrentIndex()
        } else {
            finnished(correctAnswers)
        }
    }
}
