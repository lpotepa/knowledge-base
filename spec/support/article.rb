# frozen_string_literal: true

def valid_params
  {
    question_attributes: {
      content: 'Good question'
    },
    answer_attributes: {
      content: 'Good answer'
    }
  }
end

def invalid_params
  {
    question_attributes: {
      content: nil
    },
    answer_attributes: {
      content: 'Answer'
    }
  }
end
