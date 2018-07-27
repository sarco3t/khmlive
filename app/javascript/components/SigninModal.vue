<template lang="jade">
  form(:action="url", @submit.prevent="handleForm")
    .form-group
        input(type="text" name="user[email]" placeholder="E-mail/Логін" class="form-control")

    .form-group
        input(type="password" name="password" placeholder="Пароль" class="form-control")

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
      category: ''
    }
  },
  methods: {
    handleForm(e) {
      this.category = `/${$(this.$refs.select).val()}`
      e.target.submit()
      console.log(this.category)
    },
    options () {
      return JSON.parse(this.categories).map(c => {
        ({
          text: c[1],
          value: c[0]
        })
      }) //.unshift({text: 'Вибір розділу', id: null})
    }
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

