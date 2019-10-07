import { Controller } from "stimulus"
import axios from "axios"
import translate from '../helpers/translate'

export default class extends Controller {
  static targets = [ "article", "language" ]

  connect(){
    this.lang = "original"
    this.loadArticle()
  }

  loadArticle(){
    let id = this.data.get("id")
    axios.get(`/api/v1/articles/${id}`).then((response) => {
      this.article = response.data
      this.articleTarget.innerHTML = articleTemplate(this.article, this.lang);
    })
  }

  changeLang(event){
    this.lang = event.target.value
    this.articleTarget.innerHTML = articleTemplate(this.article, this.lang);
  }

  deleteArticle(event) {
    let id = this.data.get("id")
    if (confirm("Are you sure?")) {
      axios.delete(`/api/v1/articles/${id}`).then((response) => {
        window.location.replace("/")
      })
    }
  }
}

function articleTemplate(article, currentLang) {
  if (currentLang == "original") {
    return `
      <p><h2>${article.question.content}</h2></p>
      <p>${article.answer.content}</p>
    `
  } else {
    return `
      <p><h2>${translate(article.question, currentLang)}</h2></p>
      <p>${translate(article.answer, currentLang)}</p>
    `
  }
}

