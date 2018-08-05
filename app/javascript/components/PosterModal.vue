<template lang="jade">
  form(:action="category", @submit.prevent="handleForm", method="POST")
    .form-group
      .select_category
          select.selectCategory_modal(ref="select")
              option(disabled selected value="") Вибір розділу
              option(v-for="c in JSON.parse(categories)", :value="c[0]") {{ c[1] }}

    .form-group
        quillEditor(
          v-model="body",
          :options="options")
        .form-group
            label(for="location")
              | Місце
              sup *
            input(type="text" name="location" id="location" class="form-control")

        .form-group
            label(for="dateTime")
              | Дата і час
              sup *
            input(type="text" name="dateTime" id="dateTime" class="form-control")

        .form-group
            label(for="price")
              | Ціна
              sup *
            input(type="text" name="price" id="price" class="form-control")

        .form-group
            .row
                .col-md-6
                    .modal_price
                        input(type="checkbox" name="price_published" id="price_published" class="checkbox" checked)
                        label(for="price_published" Платна публікація)

                        .modal_content_price
                            .price 150 грн
                            .item
                                input(type="radio" name="day" id="one_day" class="radio")
                                label(for="one_day") 1 день

                            .item
                                input(type="radio" name="day" id="two_day" class="radio")
                                label(for="two_day") 1 день

                            .item
                                input(type="radio" name="day" id="three_day" class="radio")
                                label(for="three_day") 1 день

                .col-md-6
                    .text-right
                        a(href="#" class="modal_link") Детальніше

        .form-group
            .row
                .col-md-6
                    .form-group.button
                        button(type="submit" class="btn btn-primary") Надіслати і оплатити

                .col-md-6
                    .form-group
                        .text-right.recaptcha_content
                            img(src="/assets/re_captcha.jpg")

</template>
<script>
import { quillEditor } from "vue-quill-editor";

export default {
  components: {
    quillEditor,
  },
  data() {
    return {
      category: "",
      body: "",
      options: {
        modules: {
          toolbar: [["blockquote", "code-block"], ["link", "image", "video"]],
        },
        placeholder: "Введіть текст новини",
      },
    };
  },
  methods: {
    handleForm(e) {
      this.category = `/${$(this.$refs.select).val()}`;
      e.target.action = this.category;
      // e.target.submit()
      this.$http
        .post(this.category, {
          post: {
            type: this.post_type,
            body: this.body,
          },
        })
        .then(_ => window.location.reload(), console.log);
    },
    optionsSelected() {
      return JSON.parse(this.categories).map(c => {
        ({
          text: c[1],
          value: c[0],
        });
      }); //.unshift({text: 'Вибір розділу', id: null})
    },
  },
  mounted() {
    $(this.$refs.select).select2({
      allowClear: false,
      minimumResultsForSearch: -1,
      dropdownParent: $(this.post_type == "Post" ? "#addPost" : "#addNews"),
    });
  },
  props: {
    categories: {
      default: "[]",
      type: String,
    },
    post_type: {
      type: String,
      default: "Post",
    },
  },
};
</script>

<style lang="scss">
@import "quill/dist/quill.core.css";
@import "quill/dist/quill.snow.css";
@import "quill/dist/quill.bubble.css";
.quill-editor {
  z-index: 99;
  padding-bottom: 20px;
}
.ql-toolbar {
  border: 0 !important;
  border-bottom: 1px solid #ccc !important;
}
.ql-container {
  height: 100px !important;
}
</style>

