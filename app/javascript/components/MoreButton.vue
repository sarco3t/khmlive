<template lang="jade">
  a(href="#" @click.prevent="$emit('load')")
    | Переглянути ще
    //- | " #{post.comments_count - 5} "
    | коментарів
</template>
<script>
export default {
}
</script>
