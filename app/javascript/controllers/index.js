// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js.
import axios from "axios"

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

axios.interceptors.response.use(function (response) {
  return response;
  }, function (error) {
    if(error.response) {
      switch(error.response.status) {
        case 422:
          alert(error.response.data)
          break;
        case 500:
          alert("Internal server error")
          break;
        case 404:
          window.location.replace("/")
          break;
        default:
          alert("Something went wrong")
      }
    }
    return Promise.reject(error);
});

