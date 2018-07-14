<template lang="jade">
  div
    slot(:load="loadMore", :collection="collection")
    spinner(v-if="busy")
</template>

<script>
import Spinner from 'vue-simple-spinner'

export default {
  components: {Spinner},
  data () {
    return {
      page: 1,
      collection: [],
      busy: false
    }
  },
  methods: {
    loadMore () {
      this.busy = true
      this.$http.get(this.url + '.json', {
        params: ++this.page
      }).then(({body}) => {
        body.map( resource => this.collection.push(resource))
        this.busy = false
      })
    }
  },
  props: ['url']
}
</script>
