<script setup lang="ts">
import type { VbenFormSchema } from '@vben-core/form-ui';

import type { AuthenticationProps, LoginAndRegisterParams } from './types';

import { computed, onMounted, reactive, ref } from 'vue';
import { useRouter } from 'vue-router';

import { $t } from '@vben/locales';

import { useVbenForm } from '@vben-core/form-ui';
import { VbenButton, VbenCheckbox } from '@vben-core/shadcn-ui';
import { cloneDeep } from '@vben-core/shared/utils';

import Title from './auth-title.vue';
import ThirdPartyLogin from './third-party-login.vue';

interface Props extends AuthenticationProps {
  formSchema: VbenFormSchema[];
}

defineOptions({
  name: 'AuthenticationLogin',
});

const props = withDefaults(defineProps<Props>(), {
  codeLoginPath: '/auth/code-login',
  forgetPasswordPath: '/auth/forget-password',
  formSchema: () => [],
  loading: false,
  qrCodeLoginPath: '/auth/qrcode-login',
  registerPath: '/auth/register',
  showCodeLogin: true,
  showForgetPassword: true,
  showQrcodeLogin: true,
  showRegister: true,
  showRememberMe: true,
  showThirdPartyLogin: true,
  submitButtonText: '',
  subTitle: '',
  title: '',
});

const emit = defineEmits<{
  submit: [LoginAndRegisterParams];
}>();

const [Form, formApi] = useVbenForm(
  reactive({
    commonConfig: {
      hideLabel: true,
      hideRequiredMark: true,
    },
    schema: computed(() => props.formSchema),
    showDefaultActions: false,
  }),
);
const router = useRouter();

const REMEMBER_ME_KEY = `REMEMBER_ME_USERNAME_${location.hostname}`;

const localUsername = localStorage.getItem(REMEMBER_ME_KEY) || '';

const rememberMe = ref(!!localUsername);

async function handleSubmit() {
  const { valid } = await formApi.validate();
  if (valid) {
    const values = cloneDeep(await formApi.getValues());
    localStorage.setItem(
      REMEMBER_ME_KEY,
      rememberMe.value ? values?.username : '',
    );
    // 加上认证类型
    (values as any).grantType = 'password';
    emit('submit', values as LoginAndRegisterParams);
  }
}

function handleGo(path: string) {
  router.push(path);
}

onMounted(() => {
  if (localUsername) {
    formApi.setFieldValue('username', localUsername);
  }
});

defineExpose({
  getFormApi: () => formApi,
});
</script>

<template>
  <div class="ai-training-login-container" @keydown.enter.prevent="handleSubmit">
    <!-- 背景装饰元素 -->
    <div class="login-background">
      <div class="bg-pattern"></div>
      <div class="floating-elements">
        <div class="floating-icon ai-icon">🤖</div>
        <div class="floating-icon brain-icon">🧠</div>
        <div class="floating-icon code-icon">💻</div>
        <div class="floating-icon data-icon">📊</div>
      </div>
    </div>

    <!-- 主要登录内容 -->
    <div class="login-content">
      <!-- 平台标识区域 -->
      <div class="platform-header">
        <div class="ai-logo">
          <div class="logo-circle">
            <!-- 将文字logo替换为图片logo -->
            <img
              src="/a7-logo.png"
              alt="AI Training Platform Logo"
              class="logo-image"
            />
          </div>
        </div>
        <h1 class="platform-title">智训工坊</h1>
        <p class="platform-subtitle">
          Artificial Intelligence Training Platform
        </p>
      </div>

      <!-- 登录表单区域 -->
      <div class="form-container w-[480px]">
        <slot name="title">
          <Title>
            <slot name="title">
              <span class="welcome-text">
                {{ title || '欢迎回来' }} 👋🏻
              </span>
            </slot>
            <template #desc>
              <span class="text-muted-foreground welcome-desc">
                <slot name="subTitle">
                  {{ subTitle || '登录您的AI实训账户，开始学习之旅' }}
                </slot>
              </span>
            </template>
          </Title>
        </slot>

        <Form />

        <div
          v-if="showRememberMe || showForgetPassword"
          class="mb-6 flex justify-between login-options"
        >
          <div class="flex-center">
            <VbenCheckbox
              v-if="showRememberMe"
              v-model:checked="rememberMe"
              name="rememberMe"
              class="remember-checkbox"
            >
              {{ $t('authentication.rememberMe') }}
            </VbenCheckbox>
          </div>

          <span
            v-if="showForgetPassword"
            class="vben-link text-sm font-normal forget-link"
            @click="handleGo(forgetPasswordPath)"
          >
            {{ $t('authentication.forgetPassword') }}
          </span>
        </div>

        <VbenButton
          :class="{
            'cursor-wait': loading,
          }"
          :loading="loading"
          aria-label="login"
          class="w-full login-button"
          @click="handleSubmit"
        >
          {{ submitButtonText || '立即登录' }}
        </VbenButton>

        <!-- 帮助链接 -->
        <!-- <div class="help-section">
          <div class="help-links">
            <a href="#" class="help-link">使用帮助</a>
            <span class="divider">|</span>
            <a href="#" class="help-link">联系管理员</a>
          </div>
        </div> -->

        <slot name="to-register">
          <div v-if="showRegister" class="mt-3 text-center text-sm register-section">
            {{ $t('authentication.accountTip') }}
            <span
              class="vben-link text-sm font-normal register-link"
              @click="handleGo(registerPath)"
            >
              {{ $t('authentication.createAccount') }}
            </span>
          </div>
        </slot>
      </div>
    </div>
  </div>
</template>

<style scoped>
.ai-training-login-container {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  /* overflow: hidden; */
}

.login-background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1;
}

.bg-pattern {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image:
    radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
  background-size: 100px 100px;
  animation: patternMove 20s linear infinite;
}

@keyframes patternMove {
  0% { transform: translate(0, 0); }
  100% { transform: translate(50px, 50px); }
}

.floating-elements {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}

.floating-icon {
  position: absolute;
  font-size: 2rem;
  opacity: 0.3;
  animation: float 6s ease-in-out infinite;
}

.ai-icon {
  top: 20%;
  left: 10%;
  animation-delay: 0s;
}

.brain-icon {
  top: 60%;
  left: 15%;
  animation-delay: 1.5s;
}

.code-icon {
  top: 30%;
  right: 20%;
  animation-delay: 3s;
}

.data-icon {
  top: 70%;
  right: 10%;
  animation-delay: 4.5s;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

.login-content {
  position: relative;
  z-index: 2;
  padding: 2rem;
}

.platform-header {
  text-align: center;
  margin-bottom: 2rem;
  color: white;
}

.ai-logo {
  margin-bottom: 1rem;
  display: flex;
  justify-content: center;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.logo-text {
  font-size: 1.5rem;
  font-weight: bold;
  color: white;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.platform-title {
  font-size: 2rem;
  font-weight: bold;
  margin-bottom: 0.5rem;
  background: linear-gradient(45deg, #ffffff, #e0e7ff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.platform-subtitle {
  font-size: 0.9rem;
  opacity: 0.9;
  letter-spacing: 1px;
}

.form-container {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.welcome-text {
  font-size: 1.5rem;
  font-weight: 600;
  color: #1a202c;
}

.welcome-desc {
  color: #718096;
  font-size: 0.9rem;
  margin-top: 0.5rem;
}

.login-options {
  align-items: center;
}

.remember-checkbox {
  color: #4a5568;
}

.forget-link {
  color: #667eea;
  transition: color 0.3s ease;
}

.forget-link:hover {
  color: #5a67d8;
}

.login-button {
  background: linear-gradient(45deg, #667eea, #764ba2);
  border: none;
  color: white;
  font-weight: 600;
  padding: 0.75rem 1.5rem;
  border-radius: 12px;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.login-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

.help-section {
  margin-top: 1.5rem;
  text-align: center;
}

.help-links {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.help-link {
  color: #667eea;
  text-decoration: none;
  font-size: 0.85rem;
  transition: color 0.3s ease;
}

.help-link:hover {
  color: #5a67d8;
  text-decoration: underline;
}

.divider {
  color: #cbd5e0;
  font-size: 0.85rem;
}

.register-section {
  color: #718096;
}

.register-link {
  color: #667eea;
  transition: color 0.3s ease;
}

.register-link:hover {
  color: #5a67d8;
}

/* 响应式设计 */
/* @media (max-width: 768px) {
  .login-content {
    max-width: 350px;
    padding: 1rem;
  }

  .platform-title {
    font-size: 1.5rem;
  }

  .form-container {
    padding: 1.5rem;
  }

  .floating-icon {
    font-size: 1.5rem;
  }
}

@media (max-width: 480px) {
  .login-content {
    max-width: 320px;
  }

  .platform-title {
    font-size: 1.3rem;
  }

  .logo-circle {
    width: 60px;
    height: 60px;
  }

  .logo-text {
    font-size: 1.3rem;
  }
} */

/* 深色模式适配 */
@media (prefers-color-scheme: dark) {
  .form-container {
    background: rgba(26, 32, 44, 0.95);
    border: 1px solid rgba(255, 255, 255, 0.1);
  }

  .welcome-text {
    color: #f7fafc;
  }

  .welcome-desc {
    color: #a0aec0;
  }

  .remember-checkbox {
    color: #e2e8f0;
  }

  .register-section {
    color: #a0aec0;
  }
}

.logo-image {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

/* 如果需要调整logo圆圈的大小 */
.logo-circle {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  /*background: linear-gradient(45deg, #00d4ff, #0099cc);*/
  display: flex;
  align-items: center;
  justify-content: center;
  /*box-shadow: 0 10px 30px rgba(0, 212, 255, 0.3);*/
  animation: pulse 2s ease-in-out infinite;
  padding: 8px; /* 为图片留出一些内边距 */
}
</style>
