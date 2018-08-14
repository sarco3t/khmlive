<template lang="jade">
  div.wrap-drop
    vue-dropzone(:options="dropzoneOptions",
    @vdropzone-success="complete",
    ref="zone"
    )
    img(:src="this.src", class="img-responsive")

</template>

<script>
import vue2Dropzone from 'vue2-dropzone'
import 'vue2-dropzone/dist/vue2Dropzone.min.css'

export default {
  components: {vueDropzone: vue2Dropzone },
  data () {
    return {
      dropzoneOptions: {
        url: '/users',
        method: 'put',
        paramName: 'user[avatar]',
        headers: {
          'X-CSRF-Token': window.csrf
        }
      }
    }
  },
  methods: {
    complete (_f, response) {
      this.src = response.url
      this.$refs.zone.removeAllFiles()
    }
  },
  props: {
    src: {}
  }
}
</script>

<style lang="scss">
  .wrap-drop {
    position: relative;
    min-height: 150px;
    > img {
      position: absolute;
    }
  }
  .wrap-drop .dropzone .dz-message {
    display:  none !important;
  }
  .wrap-drop .dropzone {
    min-height: 0;
    height: 100%;
    width: 100%;
    position: absolute;
    z-index: 99;
    background: transparent !important;
  }
</style>
