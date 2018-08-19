<template lang="jade">
  form(:action="category", @submit.prevent="handleForm", method="POST")
    .form-group(v-if="rootPath()")
      .select_category
          select.selectCategory_modal(ref="select")
              option(disabled value="") Вибір розділу
              option(v-for="(c, idx) in localCategories", :value="c[0]", :selected="idx == 0") {{ c[1] }}
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
      p.help-block(style="color:red" v-if="message") {{ message }}
    .form-group
        input(type="hidden", value="Post" name="post[type]")
        quillEditor(
          v-model="body",
          :options="options")
    .form-group
      vue-dropzone(:options="dropzoneOptions",
        ref="zone",
        id="dz-1"
      )
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
import { quillEditor } from "vue-quill-editor";
import vue2Dropzone from "vue2-dropzone";
import "vue2-dropzone/dist/vue2Dropzone.min.css";
const formData = new FormData();
export default {
  components: {
    quillEditor,
    "vue-dropzone": vue2Dropzone,
  },
  data() {
    return {
      localCategories: JSON.parse(this.categories),
      dropzoneOptions: {
        url: "/users",
        autoQueue: false,
        uploadMultiple: true,
        accept: (file, done) => {
          formData.append("files", "file");
          console.log(formData);
          done();
        },
        acceptedFiles: "image/*",
        dictDefaultMessage: "Перетягніть щоб завантажити файли",
      },
      category: "",
      message: "",
      body: "",
      options: {
        modules: {
          toolbar: [["blockquote", "code-block"], ["link", "video"]],
        },
        placeholder: "Введіть текст новини",
      },
    };
  },
  methods: {
    rootPath() {
      return window.location.pathname == "/";
    },
    handleForm(e) {
      this.message = "";
      if (!window.current_user) {
        this.message = "Увійдіть щоб запропонувати новину";
        return;
      }
      this.category = `/${$(this.$refs.select).val()}`;
      const url = this.rootPath()
        ? window.location.origin + this.category
        : window.location.pathname;
      console.log(url);
      this.$http
        .post(url, {
          post: {
            type: this.post_type,
            body: this.body,
          },
        })
        .then(_ => {
          $(this.post_type == "Post" ? "#addPost" : "#addNews").modal("toggle");
          $("#successModal").modal("show");
        }, console.log);
    },
  },
  mounted() {
    if (this.rootPath()) {
      $(this.$refs.select).select2({
        allowClear: false,
        minimumResultsForSearch: -1,
        dropdownParent: $(this.post_type == "Post" ? "#addPost" : "#addNews"),
      });
    }
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

