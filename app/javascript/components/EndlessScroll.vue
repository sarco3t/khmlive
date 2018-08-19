<template lang="jade">
  div(v-infinite-scroll="loadMore", infinite-scroll-disabled="busy", infinite-scroll-distance="10" infinite-scroll-throttle-delay="200")
    slot
    template(v-for="post in posts")
      post(:post="post", :key="post.id")
    spinner(v-if="busy")
</template>

<script>
import infiniteScroll from "vue-infinite-scroll";
import Spinner from 'vue-simple-spinner'
import Post from './Post'
import bus from '../event-bus'

export default {
    components: {
    Spinner,
    Post
  },
  data: function() {
    return {
      lastResponse: true,
      busy: false,
      posts: [],
      page: 0,
      categoryID: 0
    };
  },
  methods: {
    getUrl() {
      return this.url || '/' + this.categoryID
    },
    loadMore() {
      if (!this.lastResponse && this.url) {
        this.busy = true;
        this.$http
          .get(this.getUrl() + '.json', {
            params: {
              page: ++this.page,
            },
          })
          .then(response => {
            if (response.body.length) {
              response.body.map(post => this.posts.push(post));
            } else {
              this.lastResponse = true
            }
            this.busy = false
          }, () => { this.lastResponse = true })
      }
    },
  },
  directives: { infiniteScroll },
  props: {
    url: "",
  },
  mounted() {
    this.lastResponse = false
    if (this.url) {
      this.loadMore()
    }
    bus.$on('homeCategory', id => {
      console.log(id)
      this.categoryID = id
      this.lastResponse = false
      this.page = 0
      this.loadMore()

    })
  }
};
</script>
