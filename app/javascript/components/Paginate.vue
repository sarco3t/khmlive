<template lang="jade">
  div
    slot(:load="loadMore")
    div(v-html="content")
    spinner(v-if="busy")
</template>

<script>
import Spinner from 'vue-simple-spinner'

export default {
  components: {Spinner},
  data () {
    return {
      page: 1,
      content: '',
      busy: false
    }
  },
  methods: {
    loadMore () {
      this.busy = true
      this.$http.get(this.url + '.js', {
        params: ++this.page
      }).then(({body}) => {
        this.content += body
        this.busy = false
      })
    }
  },
  props: ['url']
}
</script>
