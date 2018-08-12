<template lang="jade">
  form(:action="url", @submit.prevent="handleForm", method="POST")
    .form-group
      input(type="text" name="user[email]" placeholder="E-mail" class="form-control" v-model="email")
      p.help-block(v-if="errors.email && errors.email.length" style="color: red")
        {{ errors.email[0] }}
    .form-group
      input(type="text" name="user[username]" placeholder="Логін" class="form-control" v-model="username")
      p.help-block(v-if="errors.username && errors.username.length" style="color: red")
        {{ errors.username[0] }}
    .form-group
      input(type="password" name="user[password]" placeholder="Пароль" class="form-control" v-model="password")
      p.help-block(v-if="errors.password && errors.password.length" style="color: red")
        {{ errors.password[0] }}

    .form-group
        input(type="password" name="user[password_confirmation]" placeholder="Повторити пароль" class="form-control" v-model="password_confirmation")
        p.help-block(v-if="errors.password_confirmation && errors.password_confirmation.length" style="color: red")
          {{ errors.password_confirmation[0] }}

    .form-group
        button(type="submit" class="btn btn-primary full-width") Зареєструватись
    .form-group(v-if="message")
      {{ message }}
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
      errors: {},
      message: '',
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
      this.errors = {}
      this.$http.post(this.url, {
        user: {
          email,
          username,
          password_confirmation,
          password
        }
      }).then(({ body }) => {
        this.message = 'Підтвердіть ваш емейл.'
      }, ({body}) => {
        this.errors = body.errors
        this.message = ''
      })
    },
  },
  props: {
    url: {}
  }
}
</script>

