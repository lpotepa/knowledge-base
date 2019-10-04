import { Controller } from "stimulus"
import axios from "axios"

export default class extends Controller {
  static targets = [ "question", "answer", "submit" ]

  connect(){
    this.loadArticle()
  }

  loadArticle(){
    let id = this.data.get("id")
    axios.get(`/api/v1/articles/${id}`).then((response) => {
      this.article = response.data
      this.questionTarget.value = this.article.question.content
      this.answerTarget.value = this.article.answer.content
    })
  }

  update(e){
    e.preventDefault()
    axios.put(`${this.data.get("url")}/${this.data.get("id")}`, {
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
