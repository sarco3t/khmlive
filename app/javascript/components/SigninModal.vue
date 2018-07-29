<template lang="jade">
  form(:action="url", @submit.prevent="handleForm", method="post")
    .form-group
        input(type="text" name="user[email]" placeholder="E-mail/Логін" class="form-control" v-model="email")

    .form-group
        input(type="password" name="password" placeholder="Пароль" class="form-control" v-model="password")

    .form-group
        button(type="submit" class="btn btn-primary full-width") Вхід

    .form-group
        input(type="checkbox" name="remember" id="remember" class="checkbox" checked="true")
        label(for="remember") Запам’ятати мене


</template>
<script>
export default {
  components: {
  },
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    handleForm(e) {
      const {
        email, password
      } = this
      this.$http.post(this.url, {
        user: {
          email,
          password
        }
      }).then(() => {
        window.location.reload()
      }, console.log)
    },
  },
  mounted () {
    $(this.$refs.select).select2({
       allowClear: false,
       minimumResultsForSearch: -1,
       dropdownParent: $('#addNews')
   });
  },
  props: {
    url: {}
  }
}
</script>

