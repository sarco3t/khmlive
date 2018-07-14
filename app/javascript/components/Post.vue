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
    .text_post
      {{ post.body }}
      p
        a(href="#")
          img(src="img/posts/content_1.jpg" class="img-responsive")

    .post_like
      .like_btns
        a(href="#" class="like_btn like active")
          .like_button_icon
            i.fas.fa-heart
          .like_button_count
            | 130

        a(href="#" class="like_btn comment")
          .like_button_icon
            i.fas.fa-comment
          .like_button_count {{ post.comments_count }}

        a(href="#" class="like_btn share active")
          .like_button_icon
            i.fas.fa-share
          .like_button_count
            | 8

      .like_views.views
        .like_icon
          i.fas.fa-eye
        .like_count
          | 2536
  comments(:comments="post.latest_comments || post.comments", :url="post.url")
</template>

<script>
import Comments from './Comments'
export default {
  components: { Comments },
  props: ['post']
}
</script>
