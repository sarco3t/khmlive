<template lang="jade">
  div
    .sort_post.sidebar_item
      .header
        input( type="checkbox" name="sort_post" id="sort_post" v-model="popular")
        label( for="sort_post")  Спочатку популярні

    .latest_post.sidebar_item
      .header Останні новини

      .content
        .post(v-for="post in posts")
          .image
            a( href="#")
              img( src="/assets/posts/item.jpg")
          .content
            .post_info
              span.date {{ post.date }}
              span.category
                a(:href="post.category.url") {{ post.category.title }}

            .text(v-html="post.title || post.body")
        .button
          a(href="/news")  Переглянути всі новини

</template>

<script>
export default {
  props: ["category"],
  data() {
    return {
      popular: false,
      posts: [],
    };
  },
  methods: {
    getPosts() {
      const params = {};
      if (this.popular) {
        params.popular = true;
      }
      this.$http
        .get(window.location.origin + `/${this.category}`, { params })
        .then(({ body }) => (this.posts = body), console.log);
    },
  },
  watch: {
    popular() {
      this.getPosts();
    },
  },
  mounted() {
    this.getPosts();
  },
};
</script>
