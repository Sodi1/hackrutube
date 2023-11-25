<template>
  <v-select
    variant="solo"
    :menu-props="{ transition: 'slide-y-transition' }"
    :items="items"
    menu-icon=""
    :model-value="modelValue"
    @update:menu="arrowRed = $event"
    @update:model-value="emit('update:modelValue', $event)"
  >
    <template #append-inner="props">
      <v-icon
        :class="{
          'dot-icon': true,
          'dot-icon__active': arrowRed,
        }"
        icon="mdi-chevron-left"
      />
    </template>
    <template #selection="{ item }">
      {{ item.title }}
    </template>
  </v-select>
</template>
<script setup>
import { ref } from "vue";

const arrowRed = ref(false);
const emit = defineEmits("update:modelValue");
const props = defineProps({
  items: Array,
  modelValue: String,
});
</script>
<style scoped lang="scss">
@import "../assets/css/main.scss";
.dot-icon {
  color: grey;
  transition: all 0.15s ease;
  &__active {
    transform: rotate(-90deg);
    color: $active;
    opacity: 1 !important;
  }
}
</style>
