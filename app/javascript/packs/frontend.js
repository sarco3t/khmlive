/* eslint no-console: 0 */

import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'

import EndlessScroll from '../components/EndlessScroll'
import Paginate from '../components/Paginate'
import MoreButton from '../components/MoreButton'
import Post from '../components/Post'

Vue.use(TurbolinksAdapter)
Vue.use(VueResource)
Vue.http.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0].getAttribute('content')
document.addEventListener('turbolinks:load', () => {
  console.log('load')
  const app = new Vue({
    el: '[data-vue="true"]',
    components: { EndlessScroll, Paginate, MoreButton, Post }
  })
})
