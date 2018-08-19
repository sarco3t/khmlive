<template lang="jade">
    a(@click.prevent="handle", href="#", :class="hasLike ? 'like_btn like active' : 'like_btn like'")
      .like_button_icon
        i.fas.fa-heart
      .like_button_count {{ likesCount }}

</template>

<script>
export default {
  data () {
    return {
      hasLike: this.has_like,
      likesCount: this.count
    }
  },
  props: ['count', 'url', 'has_like'],
  methods: {
    handle() {
      if (!window.current_user) {
        $('#signinModal').modal('toggle')
        return
      }
      if (!this.hasLike) {
        this.hasLike = true
        this.$http.post(this.url + '/like')
        this.likesCount++
      } else {
        this.likesCount--
        this.$http.delete(this.url + '/dislike')
        this.hasLike = false
      }
    }
  }
}
</script>

