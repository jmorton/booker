/* eslint no-console: 0 */

import '../src/mine.css'
import 'axios'

import Vue from 'vue/dist/vue.esm'
import App from '../mine.vue'

document.addEventListener('DOMContentLoaded', () => {
  
  console.log("Mine...");

  const mine = new Vue({
    el: '#app',
    components: { App }
  })
})
