<template lang="jade">
.reply.reply_item
  .wrap_reply
    a(href="#" class="reply_image")
      img(src="assets/user.jpg")

    .reply_content
      .reply_action

      .reply_author
        a(href="#" class="author") {{ comment.user.email }}

      .reply_text
        .wall_reply_text {{ comment.body }}

      .reply_footer
        .reply_info
          a(href="#" class="reply_btn reply") Відповісти

          .reply_date {{ comment.created_at }} тому
        .reply_like
          like(:url="comment.url", :count="comment.likes_count", :has_like="comment.has_like")

</template>

<script>
import Like from './Like'
export default {
  components: { Like },
  props: ['comment']
}
</script>
