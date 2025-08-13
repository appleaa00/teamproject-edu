<template>
  <div class="login-container">
    <!-- 背景装饰 -->
    <div class="background-decoration">
      <div class="circle circle-1"></div>
      <div class="circle circle-2"></div>
      <div class="circle circle-3"></div>
    </div>

    <!-- 登录卡片 -->
    <div class="login-card">
      <!-- 头部Logo -->
      <!--<div class="login-header">
        <div class="logo">
          <i class="fas fa-graduation-cap fa-3x"></i>
          <h1>智训工坊</h1>
          <p>智能化教学，个性化学习</p>
        </div>
      </div>
          -->
      <!-- 登录表单 -->
      <div class="login-form">
        <h2>欢迎登录</h2>

        <form @submit.prevent="handleLogin">
          <div class="form-group">
            <label for="username">
              <i class="fas fa-user"></i>
              用户名/邮箱
            </label>
            <input
              type="text"
              id="username"
              v-model="loginForm.username"
              placeholder="请输入用户名或邮箱"
              required
            />
          </div>

          <div class="form-group">
            <label for="password">
              <i class="fas fa-lock"></i>
              密码
            </label>
            <div class="password-input">
              <input
                :type="showPassword ? 'text' : 'password'"
                id="password"
                v-model="loginForm.password"
                placeholder="请输入密码"
                required
              />
              <button
                type="button"
                class="password-toggle"
                @click="togglePassword"
              >
                <i :class="showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
              </button>
            </div>
          </div>

          <div class="form-options">
            <label class="remember-me">
              <input type="checkbox" v-model="loginForm.rememberMe">
              <span class="checkmark"></span>
              记住我
            </label>
            <a href="#" class="forgot-password">忘记密码？</a>
          </div>

          <button type="submit" class="login-btn" :disabled="loading">
            <i v-if="loading" class="fas fa-spinner fa-spin"></i>
            <i v-else class="fas fa-sign-in-alt"></i>
            {{ loading ? '登录中...' : '立即登录' }}
          </button>
        </form>

        <!-- 其他登录方式 -->
        <div class="divider">
          <span>或者</span>
        </div>

        <div class="social-login">
          <button class="social-btn wechat">
            <i class="fab fa-weixin"></i>
            微信登录
          </button>
          <button class="social-btn qq">
            <i class="fab fa-qq"></i>
            QQ登录
          </button>
        </div>

        <!-- 注册链接 -->
        <div class="register-link">
          <span>还没有账号？</span>
          <a href="#">立即注册</a>
        </div>
      </div>
    </div>

    <!-- 成功提示 -->
    <div v-if="showSuccessToast" class="success-toast">
      <div class="toast-content">
        <i class="fas fa-check-circle"></i>
        <span>{{ successMessage }}</span>
      </div>
    </div>

    <!-- 错误提示 -->
    <div v-if="showErrorToast" class="error-toast">
      <div class="toast-content">
        <i class="fas fa-exclamation-circle"></i>
        <span>{{ errorMessage }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// 响应式数据
const loading = ref(false)
const showPassword = ref(false)
const showSuccessToast = ref(false)
const showErrorToast = ref(false)
const successMessage = ref('')
const errorMessage = ref('')

// 登录表单
const loginForm = reactive({
  username: '',
  password: '',
  rememberMe: false
})

// 切换密码显示
const togglePassword = () => {
  showPassword.value = !showPassword.value
}

// 显示成功提示
const showSuccess = (message) => {
  successMessage.value = message
  showSuccessToast.value = true
  setTimeout(() => {
    showSuccessToast.value = false
    successMessage.value = ''
  }, 3000)
}

// 显示错误提示
const showError = (message) => {
  errorMessage.value = message
  showErrorToast.value = true
  setTimeout(() => {
    showErrorToast.value = false
    errorMessage.value = ''
  }, 3000)
}

// 处理登录
const handleLogin = async () => {
  if (!loginForm.username || !loginForm.password) {
    showError('请填写完整的登录信息')
    return
  }

  loading.value = true

  try {
    // 模拟登录API调用
    await new Promise(resolve => setTimeout(resolve, 1500))

    // 模拟登录成功
    if (loginForm.username === 'admin' && loginForm.password === '123456') {
      showSuccess('登录成功，正在跳转...')
      setTimeout(() => {
        router.push('/all-videos')
      }, 1500)
    } else {
      showError('用户名或密码错误')
    }
  } catch (error) {
    showError('登录失败，请稍后重试')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #1a2980 0%, #26d0ce 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  position: relative;
  overflow: hidden;
}

/* 背景装饰 */
.background-decoration {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  animation: float 6s ease-in-out infinite;
}

.circle-1 {
  width: 200px;
  height: 200px;
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.circle-2 {
  width: 150px;
  height: 150px;
  top: 60%;
  right: 15%;
  animation-delay: 2s;
}

.circle-3 {
  width: 100px;
  height: 100px;
  bottom: 20%;
  left: 20%;
  animation-delay: 4s;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px) rotate(0deg);
  }
  50% {
    transform: translateY(-20px) rotate(180deg);
  }
}

/* 登录卡片 */
.login-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  width: 100%;
  max-width: 450px;
  overflow: hidden;
  position: relative;
  z-index: 2;
}

/* 头部Logo */
.login-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 40px 30px;
  text-align: center;
}

.logo i {
  color: #fff;
  margin-bottom: 15px;
}

.logo h1 {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 10px 0;
}

.logo p {
  font-size: 16px;
  opacity: 0.9;
  margin: 0;
}

/* 登录表单 */
.login-form {
  padding: 40px 30px;
}

.login-form h2 {
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin: 0 0 30px 0;
  text-align: center;
}

.form-group {
  margin-bottom: 25px;
}

.form-group label {
  display: block;
  font-size: 14px;
  font-weight: 500;
  color: #555;
  margin-bottom: 8px;
}

.form-group label i {
  margin-right: 8px;
  color: #667eea;
}

.form-group input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #e1e5e9;
  border-radius: 10px;
  font-size: 16px;
  transition: all 0.3s ease;
  background: #f8f9fa;
}

.form-group input:focus {
  outline: none;
  border-color: #667eea;
  background: white;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.password-input {
  position: relative;
}

.password-toggle {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  color: #999;
  cursor: pointer;
  padding: 4px;
  transition: color 0.3s ease;
}

.password-toggle:hover {
  color: #667eea;
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.remember-me {
  display: flex;
  align-items: center;
  cursor: pointer;
  font-size: 14px;
  color: #666;
}

.remember-me input {
  display: none;
}

.checkmark {
  width: 18px;
  height: 18px;
  border: 2px solid #ddd;
  border-radius: 4px;
  margin-right: 8px;
  position: relative;
  transition: all 0.3s ease;
}

.remember-me input:checked + .checkmark {
  background: #667eea;
  border-color: #667eea;
}

.remember-me input:checked + .checkmark::after {
  content: '✓';
  position: absolute;
  top: -2px;
  left: 2px;
  color: white;
  font-size: 12px;
}

.forgot-password {
  color: #667eea;
  text-decoration: none;
  font-size: 14px;
  transition: color 0.3s ease;
}

.forgot-password:hover {
  color: #5a67d8;
}

.login-btn {
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-bottom: 25px;
}

.login-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
}

.login-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.login-btn i {
  margin-right: 8px;
}

.divider {
  text-align: center;
  margin: 25px 0;
  position: relative;
}

.divider::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 0;
  right: 0;
  height: 1px;
  background: #e1e5e9;
}

.divider span {
  background: white;
  padding: 0 15px;
  color: #999;
  font-size: 14px;
}

.social-login {
  display: flex;
  gap: 15px;
  margin-bottom: 25px;
}

.social-btn {
  flex: 1;
  padding: 12px;
  border: 2px solid #e1e5e9;
  border-radius: 10px;
  background: white;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 14px;
  font-weight: 500;
}

.social-btn.wechat {
  color: #1aad19;
  border-color: #1aad19;
}

.social-btn.wechat:hover {
  background: #1aad19;
  color: white;
}

.social-btn.qq {
  color: #12b7f5;
  border-color: #12b7f5;
}

.social-btn.qq:hover {
  background: #12b7f5;
  color: white;
}

.social-btn i {
  margin-right: 6px;
}

.register-link {
  text-align: center;
  font-size: 14px;
  color: #666;
}

.register-link a {
  color: #667eea;
  text-decoration: none;
  font-weight: 500;
  margin-left: 5px;
}

.register-link a:hover {
  color: #5a67d8;
}

/* 提示框样式 */
.success-toast, .error-toast {
  position: fixed;
  top: 20px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 3000;
  animation: slideDown 0.3s ease-out;
}

.success-toast .toast-content {
  background: linear-gradient(135deg, #34d399 0%, #10b981 100%);
  color: white;
  padding: 16px 24px;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(52, 211, 153, 0.25);
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 16px;
  font-weight: 500;
  min-width: 300px;
}

.error-toast .toast-content {
  background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
  color: white;
  padding: 16px 24px;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(239, 68, 68, 0.25);
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 16px;
  font-weight: 500;
  min-width: 300px;
}

.toast-content i {
  font-size: 20px;
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateX(-50%) translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
  }
}

/* 响应式设计 */
@media (max-width: 480px) {
  .login-container {
    padding: 10px;
  }

  .login-card {
    max-width: 100%;
  }

  .login-header {
    padding: 30px 20px;
  }

  .login-form {
    padding: 30px 20px;
  }

  .logo h1 {
    font-size: 24px;
  }

  .social-login {
    flex-direction: column;
  }

  .success-toast, .error-toast {
    left: 10px;
    right: 10px;
    transform: none;
  }

  .toast-content {
    min-width: auto;
    width: 100%;
  }
}
</style>
