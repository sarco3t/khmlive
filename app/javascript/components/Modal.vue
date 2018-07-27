<template lang="jade">
  form(:action="category", @submit.prevent="handleForm", method="POST")
    .form-group
      .select_category
          select.selectCategory_modal(ref="select")
              option(disabled selected value="") Вибір розділу
              option(v-for="c in JSON.parse(categories)", :value="c[0]") {{ c[1] }}
    .form-group
        .modal_action
            ul
              li
                  a(href="#")
                      i.fas.fa-quote-right
              li
                  a(href="#")
                      i.fas.fa-camera
              li
                  a( href="#")
                      i.fab.fa-youtube

    .form-group
        input(type="hidden", value="Post" name="post[type]")
        textarea( class="form-control" placeholder="Введіть текст новини" name="post[body]")

    .form-group
        .row
            .col-md-6
                .form-group.button
                    button( type="submit" class="btn btn-primary") Надіслати

            .col-md-6
                .form-group
                    .text-right.recaptcha_content
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
    categories: {
      default: '[]',
      type: String
    }
  }
}
</script>

