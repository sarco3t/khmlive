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

export default {
    components: {
    Spinner,
    Post
  },
  data: function() {
    return {
      lastResponse: false,
      busy: false,
      posts: [],
      page: 1,
    };
  },
  methods: {
    loadMore() {
      if (!this.lastResponse) {
        this.busy = true;
        this.$http
          .get(this.url + '.json', {
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
  created() {
    this.loadMore()
  }
};
</script>
