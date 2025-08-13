<template>
  <div class="loading-spinner" :class="sizeClass">
    <div class="spinner-container">
      <!-- 主要旋转环 -->
      <div class="spinner-ring primary-ring">
        <div class="ring-segment"></div>
        <div class="ring-segment"></div>
        <div class="ring-segment"></div>
        <div class="ring-segment"></div>
      </div>
      
      <!-- 次要旋转环 -->
      <div class="spinner-ring secondary-ring">
        <div class="ring-segment"></div>
        <div class="ring-segment"></div>
        <div class="ring-segment"></div>
      </div>
      
      <!-- 中心脉冲点 -->
      <div class="center-pulse"></div>
    </div>
    
    <!-- 加载文字 -->
    <div v-if="showText" class="loading-text">
      <span v-for="(char, index) in loadingText" 
            :key="index" 
            class="loading-char"
            :style="{ animationDelay: `${index * 100}ms` }">
        {{ char === ' ' ? '\u00A0' : char }}
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  size?: 'sm' | 'md' | 'lg' | 'xl'
  showText?: boolean
  text?: string
}

const props = withDefaults(defineProps<Props>(), {
  size: 'md',
  showText: true,
  text: 'AI正在思考中...'
})

const sizeClass = computed(() => {
  const sizes = {
    sm: 'size-sm',
    md: 'size-md', 
    lg: 'size-lg',
    xl: 'size-xl'
  }
  return sizes[props.size]
})

const loadingText = computed(() => props.text.split(''))
</script>

<style scoped>
.loading-spinner {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 16px;
}

.spinner-container {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* 旋转环基础样式 */
.spinner-ring {
  position: absolute;
  border-radius: 50%;
  border: 2px solid transparent;
  animation: spin 2s linear infinite;
}

/* 主要旋转环 */
.primary-ring {
  border-top-color: #667eea;
  border-right-color: #764ba2;
  animation-duration: 1.5s;
}

/* 次要旋转环 */
.secondary-ring {
  border-top-color: #f093fb;
  border-left-color: #f5576c;
  animation-duration: 2s;
  animation-direction: reverse;
}

/* 中心脉冲点 */
.center-pulse {
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea, #764ba2);
  animation: pulse 1.5s ease-in-out infinite;
}

/* 尺寸变体 */
.size-sm .primary-ring {
  width: 24px;
  height: 24px;
}

.size-sm .secondary-ring {
  width: 16px;
  height: 16px;
}

.size-sm .center-pulse {
  width: 4px;
  height: 4px;
}

.size-md .primary-ring {
  width: 32px;
  height: 32px;
}

.size-md .secondary-ring {
  width: 24px;
  height: 24px;
}

.size-md .center-pulse {
  width: 6px;
  height: 6px;
}

.size-lg .primary-ring {
  width: 48px;
  height: 48px;
}

.size-lg .secondary-ring {
  width: 36px;
  height: 36px;
}

.size-lg .center-pulse {
  width: 8px;
  height: 8px;
}

.size-xl .primary-ring {
  width: 64px;
  height: 64px;
}

.size-xl .secondary-ring {
  width: 48px;
  height: 48px;
}

.size-xl .center-pulse {
  width: 12px;
  height: 12px;
}

/* 动画定义 */
@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
    opacity: 0.8;
  }
  50% {
    transform: scale(1.3);
    opacity: 0.4;
  }
}

/* 加载文字样式 */
.loading-text {
  font-size: 14px;
  color: #667eea;
  font-weight: 500;
  text-align: center;
}

.loading-char {
  display: inline-block;
  animation: bounce 1.4s ease-in-out infinite both;
}

@keyframes bounce {
  0%, 80%, 100% {
    transform: scale(1) translateY(0);
  }
  40% {
    transform: scale(1.1) translateY(-4px);
  }
}

/* 深色模式适配 */
.dark .loading-text {
  color: #93c5fd;
}

.dark .center-pulse {
  background: linear-gradient(135deg, #60a5fa, #a78bfa);
}

.dark .primary-ring {
  border-top-color: #60a5fa;
  border-right-color: #a78bfa;
}

.dark .secondary-ring {
  border-top-color: #f472b6;
  border-left-color: #fb7185;
}
</style>
