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
      p(v-html="post.body")
      .page_post_thumbs(v-if="post.images")
        .row
          template(v-for="(image, idx) in post.images")
            .col-md-6(v-if="idx < 2")
              a(href="#")
                img(:src="image", class="img-responsive")
            .col-md-2(v-else)
              a(href="#")
                img(:src="image", class="img-responsive")

          //- .col-md-2.more_thumbs
          //-     a(href="#")
          //-         img(src="img/posts/content_1.jpg" class="img-responsive")
          //-         .count_thumbs
          //-             | + 10
    .post_like
      .like_btns
        like(:url="post.url", :count="post.likes_count", :has_like="post.has_like")
        a(href="#" class="like_btn comment")
          .like_button_icon
            i.fas.fa-comment
          .like_button_count {{ post.comments_count }}

        //- a(href="#" class="like_btn share active")
        //-   .like_button_icon
        //-     i.fas.fa-share
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
