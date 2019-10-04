import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "question", "answer", "submit" ]

  create(e){
    e.preventDefault()
    axios.post(this.data.get("url"), {
      question_attributes: {
        content: this.questionTarget.value
      },
      answer_attributes: {
        content: this.answerTarget.value
      }
    }).then(() => {
      window.location.replace("/")
    })
  }
}
