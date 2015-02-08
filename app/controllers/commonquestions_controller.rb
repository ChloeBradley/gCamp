class CommonQuestionsController < ApplicationController
def index

end

class Question
def initialize
    @commonquestions= CommmonQuestions.find [Q1:"What is gCamp?",Q2:"How do I join gCamp?",Q3:"When will gCamp be finished?"]
  end
end
end
