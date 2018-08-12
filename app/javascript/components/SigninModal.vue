<template lang="jade">
  form(:action="url", @submit.prevent="handleForm", method="post")
    .form-group
        input(type="text" name="user[login]" placeholder="E-mail/Логін" class="form-control" v-model="login")

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
      login: '',
      password: ''
    }
  },
  methods: {
    handleForm(e) {
      const {
        login, password
      } = this
      this.$http.post(this.url, {
        user: {
          login,
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

