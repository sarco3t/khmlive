<template lang="jade">
  div
    .replies
      paginate(:url="url + '/comments'")
        template(slot-scope="props")
          .replies_list
            .button_more
              more-button(@load="props.load")
            template(v-for="comment in sortedComments(props.collection)")
              comment(:comment="comment")
    .reply_box
        .reply_box_wrapper
          .reply_box_image
            a(href="#")
              img(src="/assets/user.jpg")

          .reply_box_comment
            textarea(name="comment"
              placeholder="Написати коментар"
              data-emojiable="true"
              class="comment_text_1"
              @input="handle"
              ref="form"
            )

            .reply_box_action
              .action_item.reply_box_attach_image
                input(type="file")
                a(href="#" data-turbolinks="false")
                  i.fas.fa-camera

              .action_item.reply_box_emoji
                //- a(href="#" data-turbolinks="false")
                //-   i.far.fa-smile

    .reply_box_button
      .button
        button(class="btn btn-primary" @click="send") Відправити

</template>

<script>
import Comment from './Comment'
import Paginate from './Paginate'
import MoreButton from './MoreButton'
export default {
  components: {
    Comment,
    Paginate,
    MoreButton,
  },
  created () {
      setTimeout(() => {
        window.emojiPicker.discover();
        $(this.$refs.form).siblings('.emoji-wysiwyg-editor').keydown((e) => {
          if (e.ctrlKey && e.keyCode == 13) {
            this.body = e.target.innerHTML
            e.target.innerHTML = ''
            this.send()
          }
        })
      }, 200)
  },
  data () {
    return {
      body: '',
      newComments: []
    }
  },
  methods: {
    handle (e) {
      this.body = e.target.value
    },
    sortedComments (collection) {
      return collection.concat(this.comments, this.newComments).sort((a, b) => a.id - b.id)
    },
    send() {
      if (!window.current_user) {
        $('#signinModal').modal('toggle')
        return
      }
      this.$http.post(this.url + '/comments', {
        comment: {
          body: this.body
        }
      }).then(({body}) => {
        this.newComments.push(body)
        this.body = ''
      })
    }
  },
  props: ['comments', 'url']

}
</script>

