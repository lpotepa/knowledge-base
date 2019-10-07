import { Controller } from "stimulus"
import translate from '../helpers/translate'

export default class extends Controller {
  static targets = [ "articles" ]

  connect() {
    this.lang = "original"
    this.loadArticles()
  }

  changeLang(event){
    this.lang = event.target.value
    this.renderArticles()
  }

  renderArticles(){
    let articlesHtml = this.articles.map((article) => {
      return articleTemplate(article, this.lang)
    })
    this.articlesTarget.innerHTML = articlesHtml;
  }

  loadArticles() {
    fetch(this.data.get("url")).then((response) => {
      return response.json()
    }).then((articles) => {
      this.articles = articles
      this.renderArticles()
    })
  }
}

function articleTemplate(article, currentLang) {
  if (currentLang == "original") {
    return `
      <li class="list-group-item">
        <a href="/articles/${article.id}">${article.question.content}</a>
      </li>
    `
  } else {
    return `
      <li class="list-group-item">
        <a href="/articles/${article.id}">${translate(article.question, currentLang)}</a>
      </li>
    `
  }
}
