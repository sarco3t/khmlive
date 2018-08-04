<template lang="jade">
  form(:action="category", @submit.prevent="handleForm", method="POST")
    .form-group
      .select_category
          select.selectCategory_modal(ref="select")
              option(disabled selected value="") Вибір розділу
              option(v-for="c in JSON.parse(categories)", :value="c[0]") {{ c[1] }}
    //- .form-group
        //- .modal_action
            //- ul
            //-   li
            //-       a(href="#")
            //-           i.fas.fa-quote-right
            //-   li
            //-       a(href="#")
            //-           i.fas.fa-camera
            //-   li
            //-       a( href="#")
            //-           i.fab.fa-youtube

    .form-group
        input(type="hidden", value="Post" name="post[type]")
        quillEditor(
          v-model="body",
          :options="options")

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
import { quillEditor } from 'vue-quill-editor'

export default {
  components: {
    quillEditor
  },
  data() {
    return {
      category: '',
      body: '',
      options: {
        modules: {
          toolbar: [
            ['blockquote', 'code-block'],
            ['link', 'image', 'video'],
          ]
        },
        placeholder: "Введіть текст новини"
      },
    }
  },
  methods: {
    handleForm(e) {
      this.category = `/${$(this.$refs.select).val()}`
      e.target.action = this.category
      // e.target.submit()
      this.$http.post(this.category, {
        post: {
          type: this.post_type,
          body: this.body
        }
      }).then(_ => window.location.reload(), console.log)
    },
    optionsSelected () {
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
       dropdownParent: $( this.post_type == 'Post' ? '#addPost': '#addNews')
   });
  },
  props: {
    categories: {
      default: '[]',
      type: String
    },
    post_type: {
      type: String,
      default: 'Post'
    }
  }
}
</script>

<style lang="scss">
@import 'quill/dist/quill.core.css';
@import 'quill/dist/quill.snow.css';
@import 'quill/dist/quill.bubble.css';
.quill-editor {
  z-index: 99;
  padding-bottom: 20px
}
.ql-toolbar {
  border: 0 !important;
  border-bottom: 1px solid #ccc !important;
}
.ql-container {
  height: 100px !important;
}
</style>

