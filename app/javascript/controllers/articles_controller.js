import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "articles" ]

  connect() {
    this.loadArticles()
  }

  loadArticles() {
    fetch(this.data.get("url")).then((response) => {
      return response.json()
    }).then((articles) => {
      let articlesHtml = articles.map((article) => {
        return articleTemplate(article)
      })
      this.articlesTarget.innerHTML = articlesHtml;
    })
  }
}

function articleTemplate(article) {
  return `
    <li class="list-group-item">
      <a href="/articles/${article.id}">${article.question.content}</a>
    </li>
  `
}
