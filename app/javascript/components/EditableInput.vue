<template lang="jade">
  .item_contact
    .name {{ title }} :
    template(v-if="!edit")
      .value {{ localValue }}
      div(v-if="!edit" @click="edit = true" style="margin-left: 10px")
        span.fa.fa-edit
    input(type="text" v-else @keyup.enter="handle", :value="localValue")
</template>

<script>
export default {
  data() {
    return {
      edit: false,
      localValue: this.value,
    };
  },
  methods: {
    handle(e) {
      this.localValue = e.target.value;
      this.edit = false;
      this.$http.put(this.url, {
        user: {
          extra: {
            [this.name]: this.localValue,
          },
        },
      });
    },
  },
  props: {
    name: {},
    value: {},
    title: {},
    url: {
      type: String,
      default: window.location.pathname,
    },
  },
};
</script>
