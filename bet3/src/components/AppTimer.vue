<template>
  <div class="root">
    <svg class="svg" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <g class="circle">
        <circle class="time-elapsed-path" cx="50" cy="50" r="45" />
        <path
          class="time-left-path"
          v-if="timeLeft > 0"
          d="
            M 50, 50
            m -45, 0
            a 45,45 0 1,0 90,0
            a 45,45 0 1,0 -90,0
          "
          :style="{ strokeDasharray }"
        ></path>
      </g>
    </svg>
    <div class="time-left-container">
      <span class="time-left-label">{{ timeLeftString }}</span>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    padToTwo(num) {
      return String(num).padStart(2, "0");
    },
  },
  computed: {
    timeLeftString() {
      const timeLeft = this.timeLeft;
      const hours = Math.floor(timeLeft / 3600);
      const minutes = Math.floor(timeLeft / 60) % 60;
      const seconds = timeLeft % 60;
      return `${hours} ${this.padToTwo(minutes)}:${this.padToTwo(seconds)}`;
    },
    timeLeft() {
      return this.limit - this.elapsed;
    },
    strokeDasharray() {
      const radius = 45;
      const total = 2 * Math.PI * radius;
      const timeFraction = this.timeLeft / this.limit;
      const adjTimeFraction = timeFraction - (1 - timeFraction) / this.limit;
      const elapsedDash = Math.floor(adjTimeFraction * total);
      return `${elapsedDash} ${total}`;
    },
  },
  props: {
    elapsed: {
      type: Number,
      required: true,
    },
    limit: {
      type: Number,
      required: true,
    },
  },
};
</script>

<style>
/** Sets the container's height and width */
.root {
  height: 300px;
  width: 300px;
  position: relative;
}

/** Removes SVG styling that would hide the time label */
.circle {
  fill: none;
  stroke: none;
}

/** The SVG path that displays the timer's progress */
.time-elapsed-path {
  stroke-width: 1px;
  stroke: #424242;
}

.time-left-container {
  /** Size should be the same as that of parent container */
  height: inherit;
  width: inherit;

  /** Place container on top of circle ring */
  position: absolute;
  top: 0;

  /** Center content (label) vertically and horizontally  */
  display: flex;
  align-items: center;
  justify-content: center;
}

.time-left-label {
  font-size: 24px;
  color: white;
}

.time-left-path {
  /* Same thickness as the original ring */
  stroke-width: 1px;

  /* Rounds the path endings  */
  stroke-linecap: round;

  /* Makes sure the animation starts at the top of the circle */
  transform: rotate(90deg);
  transform-origin: center;

  /* One second aligns with the speed of the countdown timer */
  transition: 1s linear all;

  /* Colors the ring */
  stroke: #fdb022;
}

.svg {
  transform: scaleX(-1);
}
</style>
