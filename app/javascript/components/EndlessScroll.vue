<template lang="jade">
  div(v-infinite-scroll="loadMore", infinite-scroll-disabled="busy", infinite-scroll-distance="10" infinite-scroll-throttle-delay="500")
    slot
    div(v-html="content")
    spinner(v-if="busy")
</template>

<script>
import infiniteScroll from "vue-infinite-scroll";
import Spinner from 'vue-simple-spinner'

export default {
    components: {
    Spinner
  },
  data: function() {
    return {
      lastResponse: false,
      busy: false,
      content: "",
      page: 1,
    };
  },
  methods: {
    loadMore() {
      if (!this.lastResponse) {
        this.busy = true;
        this.$http
          .get(this.url + '.js', {
            params: {
              page: ++this.page,
            },
          })
          .then(response => {
            if (response.body) {
              this.content += response.body;
            } else {
              this.lastResponse = true
            }
            this.busy = false
          })
      }
    },
  },
  directives: { infiniteScroll },
  props: {
    url: "",
  },
};
</script>
