<template>
  <Transition
    :name="transitionName"
    :mode="mode"
    :appear="appear"
    @before-enter="onBeforeEnter"
    @enter="onEnter"
    @after-enter="onAfterEnter"
    @before-leave="onBeforeLeave"
    @leave="onLeave"
    @after-leave="onAfterLeave"
  >
    <slot />
  </Transition>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  name?: 'fade' | 'slide-left' | 'slide-right' | 'slide-up' | 'slide-down' | 'scale' | 'rotate' | 'zoom'
  mode?: 'in-out' | 'out-in' | 'default'
  appear?: boolean
  duration?: number
}

const props = withDefaults(defineProps<Props>(), {
  name: 'fade',
  mode: 'out-in',
  appear: true,
  duration: 300
})

interface Emits {
  (e: 'before-enter', el: Element): void
  (e: 'enter', el: Element, done: () => void): void
  (e: 'after-enter', el: Element): void
  (e: 'before-leave', el: Element): void
  (e: 'leave', el: Element, done: () => void): void
  (e: 'after-leave', el: Element): void
}

const emit = defineEmits<Emits>()

const transitionName = computed(() => `page-${props.name}`)

// 转场钩子函数
const onBeforeEnter = (el: Element) => {
  emit('before-enter', el)
}

const onEnter = (el: Element, done: () => void) => {
  emit('enter', el, done)
  setTimeout(done, props.duration)
}

const onAfterEnter = (el: Element) => {
  emit('after-enter', el)
}

const onBeforeLeave = (el: Element) => {
  emit('before-leave', el)
}

const onLeave = (el: Element, done: () => void) => {
  emit('leave', el, done)
  setTimeout(done, props.duration)
}

const onAfterLeave = (el: Element) => {
  emit('after-leave', el)
}
</script>

<style scoped>
/* 淡入淡出 */
.page-fade-enter-active,
.page-fade-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-fade-enter-from,
.page-fade-leave-to {
  opacity: 0;
}

/* 左滑 */
.page-slide-left-enter-active,
.page-slide-left-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-slide-left-enter-from {
  opacity: 0;
  transform: translateX(100%);
}

.page-slide-left-leave-to {
  opacity: 0;
  transform: translateX(-100%);
}

/* 右滑 */
.page-slide-right-enter-active,
.page-slide-right-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-slide-right-enter-from {
  opacity: 0;
  transform: translateX(-100%);
}

.page-slide-right-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

/* 上滑 */
.page-slide-up-enter-active,
.page-slide-up-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-slide-up-enter-from {
  opacity: 0;
  transform: translateY(100%);
}

.page-slide-up-leave-to {
  opacity: 0;
  transform: translateY(-100%);
}

/* 下滑 */
.page-slide-down-enter-active,
.page-slide-down-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-slide-down-enter-from {
  opacity: 0;
  transform: translateY(-100%);
}

.page-slide-down-leave-to {
  opacity: 0;
  transform: translateY(100%);
}

/* 缩放 */
.page-scale-enter-active,
.page-scale-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-scale-enter-from,
.page-scale-leave-to {
  opacity: 0;
  transform: scale(0.8);
}

/* 旋转 */
.page-rotate-enter-active,
.page-rotate-leave-active {
  transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-rotate-enter-from {
  opacity: 0;
  transform: rotate(-180deg) scale(0.8);
}

.page-rotate-leave-to {
  opacity: 0;
  transform: rotate(180deg) scale(0.8);
}

/* 缩放变焦 */
.page-zoom-enter-active,
.page-zoom-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-zoom-enter-from {
  opacity: 0;
  transform: scale(1.2);
  filter: blur(4px);
}

.page-zoom-leave-to {
  opacity: 0;
  transform: scale(0.8);
  filter: blur(4px);
}

/* 通用样式 */
.page-fade-enter-active,
.page-slide-left-enter-active,
.page-slide-right-enter-active,
.page-slide-up-enter-active,
.page-slide-down-enter-active,
.page-scale-enter-active,
.page-rotate-enter-active,
.page-zoom-enter-active {
  z-index: 10;
}

.page-fade-leave-active,
.page-slide-left-leave-active,
.page-slide-right-leave-active,
.page-slide-up-leave-active,
.page-slide-down-leave-active,
.page-scale-leave-active,
.page-rotate-leave-active,
.page-zoom-leave-active {
  z-index: 5;
}
</style>
