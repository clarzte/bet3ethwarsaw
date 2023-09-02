<template>
  <div id="the-header">
    <div class="header">
      <div class="back">
        <inline-svg :src="back" @click="$router.go(-1)" />
      </div>
      <div class="title">
        <slot />
      </div>
      <div class="right">
        <slot name="right" />
      </div>
    </div>
  </div>
</template>

<script>
import InlineSvg from "vue-inline-svg";
export default {
  name: "TheHeader",
  components: {
    InlineSvg,
  },
  data() {
    return {
      back: require("../assets/arrow-left.svg"),
    };
  },
  computed: {},
  methods: {},
};
</script>

<style lang="scss" scoped>
#the-header {
  position: relative;
  .back {
    float: left;
  }
  .title {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
  }

  .right {
    float: right;
  }
}
</style>
