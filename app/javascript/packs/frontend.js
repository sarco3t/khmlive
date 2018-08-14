/* eslint no-console: 0 */

import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'

import EndlessScroll from '../components/EndlessScroll'
import Paginate from '../components/Paginate'
import MoreButton from '../components/MoreButton'
import Post from '../components/Post'
import Modal from '../components/Modal'
import SignupModal from '../components/SignupModal'
import SigninModal from '../components/SigninModal'
import PosterModal from '../components/PosterModal'
import Banner from '../components/Banner'
import AvatarUploader from '../components/AvatarUploader'
import EditableInput from '../components/EditableInput'
import GlobalSelect from '../components/GlobalSelect'

// require styles
import 'quill/dist/quill.core'
import 'quill/dist/quill.snow'
import 'quill/dist/quill.bubble'

Vue.use(TurbolinksAdapter)
Vue.use(VueResource)
window.csrf = document.getElementsByName('csrf-token')[0].getAttribute('content')
Vue.http.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0].getAttribute('content')
document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('[data-vue="true"]').forEach(el => {
    new Vue({
      el: el,
      components: { EndlessScroll, Paginate, MoreButton, Post, Banner,  AvatarUploader, EditableInput, GlobalSelect }
    })
  })
  const app =
  document.querySelectorAll('[data-vue-modal="true"]').forEach(el => {
    new Vue({
      el: el,
      components: { Modal, SignupModal, SigninModal, PosterModal }
    })
  })
})
