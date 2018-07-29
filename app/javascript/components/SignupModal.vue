<template lang="jade">
  form(:action="url", @submit.prevent="handleForm", method="POST")
    .form-group
      input(type="text" name="user[email]" placeholder="E-mail" class="form-control" v-model="email")

    .form-group
        input(type="text" name="user[username]" placeholder="Логін" class="form-control" v-model="username")

    .form-group
        input(type="password" name="user[password]" placeholder="Пароль" class="form-control" v-model="password")

    .form-group
        input(type="password" name="user[password_confirmation]" placeholder="Повторити пароль" class="form-control" v-model="password_confirmation")

    .form-group
        button(type="submit" class="btn btn-primary full-width") Зареєструватись

    .form-group
        .text-center.recaptcha_content
          img(src="/assets/re_captcha.jpg")

</template>
<script>
export default {
  components: {
  },
  data() {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      username: ''
    }
  },
  methods: {
    handleForm(e) {
      const {
        email, password, password_confirmation, username
      } = this
      this.$http.post(this.url, {
        user: {
          email,
          username,
          password_confirmation,
          password
        }
      }).then(({ body }) => {
        window.location.href = '/u/' + body.slug
      }, console.log)
    },
  },
  props: {
    url: {}
  }
}
</script>

