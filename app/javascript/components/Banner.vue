<template lang="jade">
  .banner_item(v-if="image")
    a(:href="link")
      img(:src="image" class="img-responsive")
</template>

<script>
export default {
  data() {
    return {
      link: "",
      image: "",
    };
  },
  methods: {
    getBanner() {
      this.$http
        .get("/banners/next", {
          params: {
            position: this.position,
          },
        })
        .then(({ body }) => {
          this.link = body.link;
          this.image = body.image
          setTimeout(this.getBanner, 5000)
        }, console.log);
    },
  },
  props: ['position'],
  mounted () {
    this.getBanner()
  }
};
</script>

