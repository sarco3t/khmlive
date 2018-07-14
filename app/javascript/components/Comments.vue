<template lang="jade">
  .replies
    paginate(:url="url + '/comments'")
      template(slot-scope="props")
        .replies_list
          .button_more
            more-button(@load="props.load")
          template(v-for="comment in comments.concat(props.collection)")
            comment(:comment="comment")

</template>

<script>
import Comment from './Comment'
import Paginate from './Paginate'
import MoreButton from './MoreButton'
export default {
  components: {
    Comment,
    Paginate,
    MoreButton
  },
  props: ['comments', 'url']

}
</script>

