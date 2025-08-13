<template>
  <div class="skeleton-loader" :class="containerClass">
    <!-- 头像骨架屏 -->
    <div v-if="showAvatar" class="skeleton-avatar" :class="avatarSizeClass"></div>
    
    <!-- 内容区域 -->
    <div class="skeleton-content" :class="{ 'with-avatar': showAvatar }">
      <!-- 标题骨架屏 -->
      <div v-if="showTitle" class="skeleton-title"></div>
      
      <!-- 文本行骨架屏 -->
      <div v-for="(line, index) in textLines" 
           :key="index" 
           class="skeleton-text"
           :class="getLineClass(index)"
           :style="{ width: getLineWidth(index) }">
      </div>
      
      <!-- 按钮骨架屏 -->
      <div v-if="showButtons" class="skeleton-buttons">
        <div v-for="n in buttonCount" 
             :key="n" 
             class="skeleton-button">
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  variant?: 'text' | 'article' | 'card' | 'list' | 'message' | 'custom'
  lines?: number
  showAvatar?: boolean
  avatarSize?: 'sm' | 'md' | 'lg'
  showTitle?: boolean
  showButtons?: boolean
  buttonCount?: number
  animated?: boolean
  width?: string
  height?: string
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'text',
  lines: 3,
  showAvatar: false,
  avatarSize: 'md',
  showTitle: false,
  showButtons: false,
  buttonCount: 2,
  animated: true
})

const containerClass = computed(() => [
  `skeleton-${props.variant}`,
  { 'skeleton-animated': props.animated }
])

const avatarSizeClass = computed(() => `avatar-${props.avatarSize}`)

const textLines = computed(() => {
  const variants = {
    text: props.lines,
    article: 5,
    card: 3,
    list: 2,
    message: 2,
    custom: props.lines
  }
  return variants[props.variant] || props.lines
})

const getLineClass = (index: number) => {
  return {
    'first-line': index === 0,
    'last-line': index === textLines.value - 1
  }
}

const getLineWidth = (index: number) => {
  const patterns = {
    text: ['100%', '95%', '88%', '92%', '75%'],
    article: ['100%', '98%', '92%', '96%', '68%'],
    card: ['90%', '85%', '72%'],
    list: ['88%', '65%'],
    message: ['95%', '80%'],
    custom: ['100%', '90%', '85%']
  }
  
  const pattern = patterns[props.variant] || patterns.custom
  return pattern[index % pattern.length]
}
</script>

<style scoped>
.skeleton-loader {
  display: flex;
  gap: 12px;
  padding: 16px;
  width: 100%;
}

/* 骨架屏基础样式 */
.skeleton-avatar,
.skeleton-title,
.skeleton-text,
.skeleton-button {
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  border-radius: 8px;
}

/* 动画效果 */
.skeleton-animated .skeleton-avatar,
.skeleton-animated .skeleton-title,
.skeleton-animated .skeleton-text,
.skeleton-animated .skeleton-button {
  animation: skeleton-loading 1.5s ease-in-out infinite;
}

@keyframes skeleton-loading {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}

/* 头像样式 */
.skeleton-avatar {
  flex-shrink: 0;
  border-radius: 50%;
}

.avatar-sm {
  width: 32px;
  height: 32px;
}

.avatar-md {
  width: 48px;
  height: 48px;
}

.avatar-lg {
  width: 64px;
  height: 64px;
}

/* 内容区域 */
.skeleton-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.skeleton-content.with-avatar {
  padding-top: 4px;
}

/* 标题样式 */
.skeleton-title {
  height: 24px;
  width: 60%;
  margin-bottom: 4px;
  border-radius: 6px;
}

/* 文本行样式 */
.skeleton-text {
  height: 16px;
  border-radius: 4px;
}

.skeleton-text.first-line {
  height: 18px;
}

.skeleton-text.last-line {
  margin-bottom: 8px;
}

/* 按钮样式 */
.skeleton-buttons {
  display: flex;
  gap: 8px;
  margin-top: 8px;
}

.skeleton-button {
  height: 36px;
  width: 80px;
  border-radius: 8px;
}

/* 变体样式 */
.skeleton-text {
  background: linear-gradient(90deg, #f8f9fa 25%, #e9ecef 50%, #f8f9fa 75%);
}

.skeleton-article {
  max-width: 800px;
}

.skeleton-card {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.skeleton-list .skeleton-content {
  gap: 4px;
}

.skeleton-message {
  max-width: 70%;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

/* 深色模式 */
.dark .skeleton-avatar,
.dark .skeleton-title,
.dark .skeleton-text,
.dark .skeleton-button {
  background: linear-gradient(90deg, #374151 25%, #4b5563 50%, #374151 75%);
  background-size: 200% 100%;
}

.dark .skeleton-text {
  background: linear-gradient(90deg, #1f2937 25%, #374151 50%, #1f2937 75%);
  background-size: 200% 100%;
}

.dark .skeleton-card {
  background: rgba(31, 41, 55, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.dark .skeleton-message {
  background: rgba(31, 41, 55, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

/* 响应式调整 */
@media (max-width: 768px) {
  .skeleton-loader {
    padding: 12px;
    gap: 8px;
  }
  
  .skeleton-content {
    gap: 6px;
  }
  
  .skeleton-title {
    height: 20px;
  }
  
  .skeleton-text {
    height: 14px;
  }
  
  .skeleton-button {
    height: 32px;
    width: 70px;
  }
}

/* 自定义宽高 */
.skeleton-custom {
  width: v-bind('props.width');
  height: v-bind('props.height');
}
</style>
