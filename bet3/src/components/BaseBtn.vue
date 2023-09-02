<template>
  <button class="ripple-button" @click="addRippleEffect">
    <span class="text"><slot /></span>
  </button>
</template>

<script>
export default {
  name: "BaseBtn",
  methods: {
    addRippleEffect(e) {
      let button = e.currentTarget;

      // Create ripple element
      let ripple = document.createElement("span");
      ripple.classList.add("ripple");

      // Set ripple size and position
      let rect = button.getBoundingClientRect();
      let size = Math.max(rect.width, rect.height);
      ripple.style.width = ripple.style.height = size + "px";
      ripple.style.left = e.clientX - rect.left - size / 2 + "px";
      ripple.style.top = e.clientY - rect.top - size / 2 + "px";

      // Add to button and animate
      button.appendChild(ripple);
      ripple.addEventListener("animationend", () => {
        ripple.remove();
      });
      this.$emit("click");
    },
  },
};
</script>

<style scoped lang="scss"></style>

<style>
.ripple-button {
  position: relative;
  overflow: hidden;
  transform: translate3d(0, 0, 0);
}

.ripple {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.7); /* you can use any color */
  transform: scale(0);
  animation: ripple-animation 0.6s linear;
}

@keyframes ripple-animation {
  to {
    transform: scale(4);
    opacity: 0;
  }
}
</style>
