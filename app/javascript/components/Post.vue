<template lang="jade">
.post
  .post_header
    .post_image
      a(href="#")
        img(:src="post.category.logo_url")

    .post_info
      .post_category
        a(:href="post.category.url") {{ post.category.title }}
      .post_date {{ post.created_at }} тому

    .post_action
      a(href="#")
        i.fas.fa-ellipsis-h

  .post_content
    .text_post(v-html="post.body")

    .post_like
      .like_btns
        like(:url="post.url", :count="post.likes_count", :has_like="post.has_like")
        a(href="#" class="like_btn comment")
          .like_button_icon
            i.fas.fa-comment
          .like_button_count {{ post.comments_count }}

        a(href="#" class="like_btn share active")
          .like_button_icon
            i.fas.fa-share
          .like_button_count
            | 0

      .like_views.views
        .like_icon
          i.fas.fa-eye
        .like_count {{ post.views_count }}
  comments(:comments="post.latest_comments || post.comments", :url="post.url")
</template>

<script>
import Like from './Like'
import Comments from './Comments'
export default {
  components: { Comments, Like },
  props: ['post']
}
</script>
