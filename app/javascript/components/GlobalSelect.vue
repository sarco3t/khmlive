<template lang="jade">
  select(class="selectCategory" ref="select")
    option(v-for="c in localCategories", :value="c[0]") {{ c[1] }}
</template>

<script>
import bus from '../event-bus'
export default {
  data () {
    return {
      localCategories: JSON.parse(this.categories)
    }
  },
  props: {
    categories: {}
  },
  mounted () {
    $(this.$refs.select).select2({
       allowClear: false,
       minimumResultsForSearch: -1,
   });
   if (this.localCategories.length) {
    $(this.$refs.select).change((e) => {
      bus.$emit('homeCategory', e.target.value)
    })
      setTimeout(() => {
        bus.$emit('homeCategory', this.localCategories[0][0])
      }, 500)
    }
  },
}
</script>
