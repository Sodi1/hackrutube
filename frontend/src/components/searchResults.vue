<template>
  <div class="search-results">
    <div
      :class="{
        'search-result': true,
        'search-result__animated': vid.animated,
      }"
      v-for="(vid, i) in formattedData"
      :key="vid.id"
    >
      <div>id: {{ vid.id }}</div>
      <div>{{ vid.video_title }}</div>
    </div>
  </div>
</template>
<script setup>
import { ref, unref } from "vue";
import { watch } from "vue";

const formattedData = ref([]);
const props = defineProps({ data: Array });
watch(
  () => props.data,
  (v) => {
    formattedData.value = [...v.map((v1) => ({ ...v1, animated: false }))];
    recursive(0);
  }
);
function recursive(i) {
  if (!formattedData?.value[i]) return;
  formattedData.value[i].animated = true;
  setTimeout(() => {
    recursive(i + 1);
  }, 60);
}
</script>
<style scoped lang="scss">
@import "../assets/css/main.scss";
.search-result {
  padding: 6px 14px 6px 14px;
  border-radius: 6px;
  color: white;
  font-size: 18px;
  display: flex;
  position: relative;
  opacity: 0;
  cursor: pointer;
  &:hover {
    color: $active;
    background-color: rgba(244, 18, 64, 0.1);
  }
  & > :first-child {
    width: 146px;
  }
  &__animated {
    opacity: 1;
    animation: 0.6s slidein ease;
  }
}
</style>
