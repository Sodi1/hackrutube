<template>
  <div
    class="w-100 d-flex justify-center"
    style="padding-top: 40vh; min-height: 100vh"
  >
    <div class="logo">
      <logo />
    </div>
    <div class="wrapper">
      <Transition>
        <v-btn
          class="close-btn"
          variant="text"
          size="x-small"
          color="rgb(244, 18, 64)"
          icon="mdi-close"
          @click="
            searchStr = '';
            fetchData('');
          "
          v-if="searchStr.length"
        />
      </Transition>
      <div class="close-to" v-show="time" v-if="closeTo">
        Возможно вы имели ввиду:
        <span
          class="close-to__link"
          @click="
            searchStr = closeTo;
            fetchData(closeTo);
          "
        >
          {{ closeTo }}
        </span>
      </div>
      <span class="request-timing" v-show="time">
        Время ответа: {{ time }}мс
      </span>
      <v-menu
        v-model="menuShown"
        transition="slide-y-transition"
        :close-on-click="false"
      >
        <template v-slot:activator="{ props }">
          <v-text-field
            v-bind="props"
            class="autocomplete"
            placeholder="Поиск"
            autofocus
            :loading="isLoading"
            variant="solo"
            menu-icon=""
            v-model="searchStr"
            @update:model-value="fetchData($event)"
          >
            <template #append-inner="props">
              <v-icon
                :class="{
                  'dot-icon': true,
                  'dot-icon__active': props.isActive.value,
                }"
                icon="mdi-circle-medium"
              />
            </template>
            <template #append>
              <v-menu
                :close-on-content-click="false"
                location="end"
                transition="slide-x-transition"
                v-model="settingBtnActive"
              >
                <template v-slot:activator="{ props }">
                  <v-btn
                    :color="settingBtnActive ? 'red' : 'white'"
                    variant="plain"
                    icon="mdi-tune-variant"
                    v-bind="props"
                  ></v-btn>
                </template>
                <div class="settings-menu">
                  <Select
                    :items="[
                      { title: 'За все время', value: -Infinity },
                      { title: 'За сегодня', value: 86400000 },
                      { title: 'За неделю', value: 86400000 * 7 },
                      { title: 'За месяц', value: 86400000 * 30.5 },
                      { title: 'За год', value: 86400000 * 365 },
                    ]"
                    v-model="timeSelect"
                  ></Select>
                  <Select
                    :items="[
                      { title: 'Любая длительность', value: [0, Infinity] },
                      { title: 'До 5 минут', value: [0, 300] },
                      { title: '5 - 20 минут', value: [300, 1200] },
                      { title: '20 - 60 минут', value: [1200, 3600] },
                      { title: 'Более 60 минут', value: [3600, Infinity] },
                    ]"
                    v-model="lengthSelect"
                  ></Select>
                  <Select
                    :items="[
                      'По релевантности',
                      'По дате: сначала новые',
                      'по дате: сначала старые',
                      'По просмотрам',
                    ]"
                    v-model="othersSelect"
                  ></Select>
                </div>
              </v-menu>
            </template>
            <template v-slot:loader>
              <v-progress-linear
                v-show="isLoading"
                color="red-darken-4"
                height="2"
                indeterminate
              ></v-progress-linear>
            </template>
          </v-text-field>
        </template>
        <v-list
          v-show="searchItems.length"
          style="max-height: 45vh; margin-right: 64px"
        >
          <v-list-item
            v-for="(it, i) in searchItems"
            :key="it + i"
            @click="
              searchStr = it;
              fetchData(it);
            "
          >
            {{ it }}
          </v-list-item>
        </v-list>
      </v-menu>

      <SearchResults :data="videos" />
    </div>
  </div>
</template>
<script setup>
import logo from "@/components/logo.vue";
import Select from "@/components/select.vue";
import SearchResults from "@/components/searchResults.vue";
import { VideosController } from "@/api/controllers";
import { ref } from "vue";

const searchStr = ref("");
const searchItems = ref([]);
const settingBtnActive = ref(false);
const isLoading = ref(false);
const videos = ref([]);
const time = ref();

const menuShown = ref(false);

const timeSelect = ref({ title: "За все время", value: -Infinity });
const lengthSelect = ref({ title: "Любая длительность", value: [0, Infinity] });
const othersSelect = ref({ title: "По релевантности", value: "relevancy" });

const closeTo = ref("");

let timer1;
let timer2;

function fetchData(str) {
  if (str) {
    clearTimeout(timer1);
    clearTimeout(timer2);
    timer1 = setTimeout(async () => {
      const resp = await VideosController.getSearchHelpers(str);
      if (resp) {
        searchItems.value = [...resp.autocomplete];
      }
    }, 200);
    timer2 = setTimeout(async () => {
      const date = Date.now();
      isLoading.value = true;
      const resp = await VideosController.getList(str);
      time.value = Date.now() - date;
      isLoading.value = false;
      if (resp) {
        videos.value = resp.search.query;
        if (resp.suggestions.length) closeTo.value = resp.suggestions[0];
        else closeTo.value = "";
      }
    }, 400);
  } else {
    searchItems.value = [];
    videos.value = [];
  }
}
</script>

<style lang="scss">
.autocomplete {
  & input {
    color: black !important;
    font-weight: 500 !important;
    font-size: 18px !important;
  }
}
</style>

<style scoped lang="scss">
@import "../assets/css/main.scss";
.wrapper {
  width: 60%;
  position: relative;
  .dot-icon {
    color: grey;
    transition: all 0.15s ease;
    &__active {
      transform: translate(9px, -9px);
      color: $active;
      opacity: 1 !important;
    }
  }
  .request-timing {
    width: 200px;
    display: flex;
    justify-content: end;
    animation: 0.6s slidein ease;
    right: 65px;
    top: -26px;
    position: absolute;
    font-size: 14px;
    color: white;
  }
  .close-to {
    animation: 0.5s slidein ease;
    display: flex;
    align-items: center;
    left: 0;
    top: -26px;
    position: absolute;
    font-size: 14px;
    color: white;
    &__link {
      padding: 2px 6px 2px 6px;
      border-radius: 3px;
      cursor: pointer;
      color: $active;
      &:hover {
        background-color: rgba(244, 18, 64, 0.1);
      }
    }
  }
  .close-btn {
    position: absolute;
    top: 14px;
    left: -40px;
  }
}

.settings-menu {
  position: relative;
  width: 15vw;
  left: 16px;
  top: -3px;
}
.logo {
  position: fixed;
  left: 24px;
  top: 24px;
  height: 40px;
  width: 160px;
}

.v-enter-active,
.v-leave-active {
  transition: all 0.5s ease;
}

.v-enter-from,
.v-leave-to {
  transform: translateX(40px) rotate(135deg);
}
</style>
