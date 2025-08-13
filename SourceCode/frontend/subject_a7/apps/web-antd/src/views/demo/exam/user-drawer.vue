<script setup lang="ts">
import { computed, watch, ref, onMounted, reactive } from 'vue';

import { useVbenDrawer } from '@vben/common-ui';
import { $t } from '@vben/locales';
import { cloneDeep } from '@vben/utils';

import { Tag } from 'ant-design-vue';

import { findModel, saveAnswer } from '#/api/a7/paper';

import Codemirror from 'codemirror-editor-vue3';
// language
import 'codemirror/mode/markdown/markdown.js';
// placeholder
import 'codemirror/addon/display/placeholder.js';
// theme
import 'codemirror/theme/dracula.css';

// 添加message导入
import { message } from 'ant-design-vue';

const emit = defineEmits<{ reload: [] }>();

const isAnswer = ref(false);
const title = computed(() => {
  return isAnswer.value ? $t('pages.common.answer') : $t('pages.common.info');
});

// form 表单
const paperForm = reactive({
  id: '',
  paperName: '',
  paperType: '全部题型',
  paperDifficulty: '中等',
  paperSubject: '',
  answerTime: '',
  topics: [],
});

// 添加选中答案的状态管理
const selectedAnswers = ref({});

// 选择答案的处理函数
function selectOption(topicId, optionSorted) {
  selectedAnswers.value[topicId] = optionSorted;
}

// 检查选项是否被选中
function isOptionSelected(topicId, optionSorted) {
  return selectedAnswers.value[topicId] === optionSorted;
}

const mirrorOptions = { mode: 'markdown', theme: 'dracula', lineNumbers: true };
const [BasicDrawer, drawerApi] = useVbenDrawer({
  confirmText: '提交',
  cancelText: '关闭',
  onCancel: handleCancel,
  onConfirm: handleConfirm,
  async onOpenChange(isOpen) {
    if (!isOpen) {
      return null;
    }
    drawerApi.drawerLoading(true);
    // 更新 && 赋值
    await loadPaperInfo();
    drawerApi.drawerLoading(false);
  },
});

async function loadPaperInfo() {
  const { id } = drawerApi.getData() as { id?: number | string };
  isAnswer.value = true;
  // 更新 && 赋值
  const paper = await findModel(id);
  if (paper) {
    isAnswer.value = !paper.finished;
    Object.assign(paperForm, paper);
    if (!isAnswer.value) {
      // 初始化选中答案
      paperForm.topics.forEach((topic) => {
        selectedAnswers.value[topic.id] = topic.topicWrite;
      });
    }
  }
}

// 判断题目答案是否正确
function getTopicAnswerStatus(topic) {
  const userAnswer = selectedAnswers.value[topic.id];
  if (!userAnswer) return false;

  if (topic.topicType === '选择题') {
    const correctOption = topic.topicOptions.find(
      (option) => option.rightAnswer,
    );
    return correctOption && correctOption.sorted === userAnswer;
  } else if (topic.topicType === '编程题') {
    // 编程题暂时返回false，需要人工评阅
    return true;
  }

  return false;
}

async function handleConfirm() {
  try {
    drawerApi.drawerLoading(true);
    // 参数校验
    const data = cloneDeep(selectedAnswers.value);
    const answers = Object.entries(data).map(([topicId, topicWrite]) => {
      // 找到对应的题目
      const topic = paperForm.topics.find((t) => t.id === topicId);
      let rightAnswer = false;

      if (topic) {
        if (topic.topicType === '选择题') {
          // 选择题：比对选中答案与正确答案
          const correctOption = topic.topicOptions.find(
            (option) => option.rightAnswer,
          );
          rightAnswer = correctOption && correctOption.sorted === topicWrite;
        } else if (topic.topicType === '编程题') {
          // 编程题：可以根据需要实现比对逻辑，这里暂时设为false
          // 或者可以通过其他方式判断编程题的正确性
          rightAnswer = true;
        }
      }

      return {
        topicId,
        topicWrite,
        rightAnswer,
      };
    });

    console.log(answers);
    await saveAnswer(paperForm.id, answers);
    emit('reload');
    message.success({
      content: '🎉 作答成功！',
      duration: 3,
    });

    isAnswer.value = true;
    await loadPaperInfo();
  } catch (error) {
    console.error(error);
  } finally {
    drawerApi.drawerLoading(false);
  }
}

async function handleCancel() {
  drawerApi.close();
  Object.assign(paperForm, {
    id: '',
    paperName: '',
    paperType: '全部题型',
    paperDifficulty: '中等',
    paperSubject: '',
    paperTime: '',
    answerTime: '',
    topics: [],
  });
  // 清空选中答案
  selectedAnswers.value = {};
}

// 题型选择交互
async function selectType(type) {
  document.querySelectorAll('.type-card').forEach((card) => {
    card.classList.remove('active');
  });
  event.currentTarget.classList.add('active');

  paperForm.paperType = type;
}

// 在 script setup 部分添加计算属性
// 计算题目总数
const totalTopics = computed(() => {
  return paperForm.topics.length;
});

// 计算正确答案数量（仅在非作答状态下显示）
const correctAnswers = computed(() => {
  if (isAnswer.value) return 0;

  return paperForm.topics.filter((topic) => {
    return getTopicAnswerStatus(topic);
  }).length;
});

// 计算统计文本
const statisticsText = computed(() => {
  if (isAnswer.value) {
    return `题目总量：${totalTopics.value} 题`;
  } else {
    return `题目总量：${totalTopics.value} 题，正确：${correctAnswers.value} 题`;
  }
});

// 初始化代码高亮
onMounted(async () => {
  setTimeout(() => {
    // Prism.highlightAll();
  }, 100);
});
</script>

<template>
  <BasicDrawer
    :close-on-click-modal="false"
    :title="title"
    class="w-[1200px]"
    :show-confirm-button="isAnswer"
  >
    <main class="main-content">
      <div class="question-card">
        <h2 style="color: var(--primary); margin-bottom: 1.5rem">
          <i class="fas fa-question-circle"></i> 题目作答
        </h2>

        <div class="form-grid">
          <div class="form-group">
            <label><i class="fas fa-file-alt"></i>试卷名称</label>
            <div class="form-value">{{ paperForm.paperName }}</div>
          </div>
          <div class="form-group">
            <label><i class="fas fa-book"></i>科目</label>
            <div class="form-value">{{ paperForm.paperSubject }}</div>
          </div>
          <div class="form-group">
            <label><i class="fas fa-signal"></i>题目难度</label>
            <div class="form-value difficulty-badge" :class="`difficulty-${paperForm.paperDifficulty}`">
              {{ paperForm.paperDifficulty }}
            </div>
          </div>
          <div class="form-group">
            <label><i class="fas fa-clock"></i>作答时间</label>
            <div class="form-value time-badge">{{ paperForm.answerTime }}分钟</div>
          </div>
          <div class="form-group">
            <label><i class="fas fa-chart-bar"></i>作答统计</label>
            <div class="form-value statistics-text" :class="{ 'has-correct': !isAnswer && correctAnswers > 0 }">
              {{ statisticsText }}
            </div>
          </div>
        </div>

        <div class="question-list" id="questionList">
          <!-- 示例题目1 -->
          <div class="question-item" v-for="(topic, index) in paperForm.topics">
            <div class="question-header">
              <div style="line-height: 2">
                <span class="badge badge-primary">{{ topic.topicType }}</span>
                <span class="badge badge-success"
                  >难度：{{ paperForm.paperDifficulty }}</span
                >
                <span style="margin-left: 1rem">{{ topic.topicName }}</span>
                <!-- 统一的答题状态显示 -->
                <span
                  v-if="!isAnswer && selectedAnswers[topic.id]"
                  class="answer-status-badge"
                  :class="{
                    'status-correct': getTopicAnswerStatus(topic),
                    'status-wrong': !getTopicAnswerStatus(topic),
                  }"
                >
                  <i
                    :class="{
                      'fas fa-check': getTopicAnswerStatus(topic),
                      'fas fa-times': !getTopicAnswerStatus(topic),
                    }"
                  ></i>
                  {{ getTopicAnswerStatus(topic) ? '正确' : '错误' }}
                </span>
              </div>
            </div>
            <div class="question-content" v-if="topic.topicType === '选择题'">
              <p><strong>选项：</strong></p>
              <div class="options-container">
                <div
                  v-for="(item, optionIndex) in topic.topicOptions"
                  :key="optionIndex"
                  class="option-item"
                  :class="{
                    selected: isOptionSelected(
                      topic.id || topic.topicName,
                      item.sorted,
                    ),
                  }"
                  @click="
                    selectOption(topic.id || topic.topicName, item.sorted)
                  "
                >
                  <div class="option-label">{{ item.sorted }}</div>
                  <div class="option-content">{{ item.optionContent }}</div>
                  <div
                    class="option-check"
                    v-if="
                      isOptionSelected(topic.id || topic.topicName, item.sorted)
                    "
                  >
                    <i class="fas fa-check"></i>
                  </div>
                </div>
              </div>

              <p
                v-if="selectedAnswers[topic.id]"
                style="padding-top: 1rem"
              >
                <strong>您的答案：</strong>{{ selectedAnswers[topic.id] }}
              </p>

              <!-- 选择题正确答案显示 -->
              <p
                v-if="!isAnswer && selectedAnswers[topic.id]"
                style="padding-top: 1rem"
              >
                <strong>正确答案：</strong
                >{{ topic.topicOptions.find((opt) => opt.rightAnswer)?.sorted }}
              </p>
            </div>
            <div class="question-content" v-if="topic.topicType === '编程题'">
              <div>要求：{{ topic.topicContent }}</div>
              <p style="padding-top: 1rem"><strong>程序作答：</strong></p>
              <ul style="padding-top: 1rem">
                <Codemirror
                  v-model:value="selectedAnswers[topic.id]"
                  :options="mirrorOptions"
                  border
                  placeholder="Write it into your program."
                  :height="200"
                />
              </ul>
              <p style="padding-top: 1rem" v-if="!isAnswer">
                <strong>参考答案：</strong>
              </p>
              <ul style="padding-top: 1rem" v-if="!isAnswer">
                <Codemirror
                  v-model:value="topic.topicAnswer"
                  :options="mirrorOptions"
                  border
                  placeholder="Write it into your program."
                  :height="200"
                />
              </ul>
            </div>
          </div>
        </div>
      </div>
    </main>
  </BasicDrawer>
</template>
<style scoped>
/* 主内容区 */
.main-content {
  --primary: #4361ee;
  --secondary: #06b6d4;
  --accent: #f59e0b;
  --background: #f8fafc;
  --text: #1e293b;

  padding: 2rem;
  background: var(--background);
}

/* 题目生成卡片 */
.question-card {
  background: white;
  border-radius: 16px;
  padding: 2rem;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(203, 213, 225, 0.3);
}

.question-type-selector {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 1rem;
  margin: 1.5rem 0;
}

.type-card {
  padding: 1rem;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.type-card.active {
  border-color: var(--primary);
  background: #f0f9ff;
}

.question-list {
  margin-top: 2rem;
  border-top: 1px solid #e2e8f0;
  padding-top: 1.5rem;
}

.question-item {
  background: #f8fafc;
  border-radius: 12px;
  padding: 1.5rem;
  margin: 1rem 0;
  border: 1px solid #e2e8f0;
}

.question-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
}

.question-content {
  margin-top: 1rem;
}
.question-content ol {
  padding-left: 1rem;
  padding-top: 12px;
  padding-bottom: 12px;
}
.question-content ol li {
  padding-top: 6px;
}

/* pre[class*='language-'] {
  border-radius: 8px;
  margin: 1rem 0;
} */

.action-buttons {
  display: flex;
  gap: 1rem;
  margin-top: 1.5rem;
}

.badge {
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.9em;
}

.badge-primary {
  background: #dbeafe;
  color: var(--primary);
}

.badge-success {
  background: #dcfce7;
  color: #16a34a;
}

/* 生成按钮 */
.generate-btn {
  background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
  color: white;
  padding: 14px 28px;
  border: none;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 0.8rem;
}

.generate-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
}

@media (max-width: 768px) {
  .dashboard {
    grid-template-columns: 1fr;
  }
  .sidebar {
    height: auto;
    position: relative;
  }
}

.form-group {
  display: flex;
  flex-direction: row;
  align-items: center;
}

.form-group label {
  font-weight: 500;
  color: #455a64;
  padding-right: 20px;
  line-height: 48px;
}

.form-group select,
.form-group input {
  padding: 6px 15px;
  border: 1px solid #e0e7ed;
  border-radius: 8px;
  font-size: 16px;
  background: white;
  transition: all 0.3s;
  width: 420px;
}

.form-group select:focus,
.form-group input:focus {
  border-color: #3a8cff;
  outline: none;
  box-shadow: 0 0 0 3px rgba(58, 140, 255, 0.2);
}

/* 空状态样式 */
.empty-state {
  text-align: center;
  padding: 3rem 2rem;
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  border-radius: 16px;
  border: 2px dashed #cbd5e1;
  margin: 1rem 0;
}

.empty-icon {
  font-size: 4rem;
  color: #94a3b8;
  margin-bottom: 1.5rem;
}

.empty-title {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--text);
  margin-bottom: 0.8rem;
}

.empty-description {
  font-size: 1rem;
  color: #64748b;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.empty-features {
  display: flex;
  justify-content: center;
  gap: 2rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.feature-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  min-width: 120px;
}

.feature-item i {
  font-size: 1.5rem;
  color: var(--primary);
}

.feature-item span {
  font-size: 0.9rem;
  color: #475569;
  font-weight: 500;
}

.empty-tips {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  background: #fef3c7;
  border-radius: 8px;
  border: 1px solid #fbbf24;
  font-size: 0.9rem;
  color: #92400e;
}

.empty-tips i {
  color: #f59e0b;
}

@media (max-width: 768px) {
  .empty-features {
    flex-direction: column;
    gap: 1rem;
  }

  .feature-item {
    flex-direction: row;
    min-width: auto;
    width: 100%;
  }
}

/* 选项容器 */
.options-container {
  margin: 1rem 0;
}

/* 选项项目 */
.option-item {
  display: flex;
  align-items: center;
  padding: 1rem;
  margin: 0.5rem 0;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  background: white;
  position: relative;
}

.option-item:hover {
  border-color: #cbd5e1;
  background: #f8fafc;
  transform: translateX(4px);
}

/* 选中状态 */
.option-item.selected {
  border-color: var(--primary);
  background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
  box-shadow: 0 4px 12px rgba(67, 97, 238, 0.15);
}

.option-item.selected:hover {
  transform: translateX(2px);
}

/* 选项标签 (A, B, C, D) */
.option-label {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  background: #f1f5f9;
  border-radius: 50%;
  font-weight: 600;
  color: #475569;
  margin-right: 1rem;
  flex-shrink: 0;
  transition: all 0.3s ease;
}

.option-item.selected .option-label {
  background: var(--primary);
  color: white;
}

/* 选项内容 */
.option-content {
  flex: 1;
  font-size: 1rem;
  color: var(--text);
  line-height: 1.5;
}

/* 选中标记 */
.option-check {
  position: absolute;
  top: 8px;
  right: 12px;
  width: 24px;
  height: 24px;
  background: var(--primary);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 0.8rem;
  animation: checkmark 0.3s ease;
}

@keyframes checkmark {
  0% {
    transform: scale(0);
    opacity: 0;
  }
  50% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .option-item {
    padding: 0.8rem;
  }

  .option-label {
    width: 28px;
    height: 28px;
    margin-right: 0.8rem;
  }

  .option-content {
    font-size: 0.9rem;
  }
}

/* 正确答案样式 */
.option-item.option-correct {
  border-color: #22c55e;
  background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
  box-shadow: 0 4px 12px rgba(34, 197, 94, 0.15);
}

.option-item.option-correct .option-label {
  background: #22c55e;
  color: white;
}

/* 错误答案样式 */
.option-item.option-wrong {
  border-color: #ef4444;
  background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
  box-shadow: 0 4px 12px rgba(239, 68, 68, 0.15);
}

.option-item.option-wrong .option-label {
  background: #ef4444;
  color: white;
}

/* 答案状态标记 */
.answer-status {
  position: absolute;
  top: 8px;
  right: 50px;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
  animation: statusAppear 0.5s ease;
}

.answer-status.correct {
  background: #22c55e;
  color: white;
}

.answer-status.wrong {
  background: #ef4444;
  color: white;
}

@keyframes statusAppear {
  0% {
    transform: scale(0) rotate(180deg);
    opacity: 0;
  }
  50% {
    transform: scale(1.2) rotate(90deg);
  }
  100% {
    transform: scale(1) rotate(0deg);
    opacity: 1;
  }
}

/* 答案结果显示 */
.answer-result {
  margin-top: 1.5rem;
  padding: 1rem;
  border-radius: 12px;
  border: 2px solid;
  animation: resultSlideIn 0.6s ease;
}

.result-badge {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  font-weight: 600;
  font-size: 1rem;
}

.result-badge.result-correct {
  color: #22c55e;
  border-color: #22c55e;
  background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
}

.result-badge.result-wrong {
  color: #ef4444;
  border-color: #ef4444;
  background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
}

.result-badge i {
  font-size: 1.2rem;
}

@keyframes resultSlideIn {
  0% {
    transform: translateY(20px);
    opacity: 0;
  }
  100% {
    transform: translateY(0);
    opacity: 1;
  }
}

/* 题目整体状态样式 */
.question-item.question-correct {
  border-left: 4px solid #22c55e;
  background: linear-gradient(135deg, #f0fdf4 0%, #f8fafc 100%);
}

.question-item.question-wrong {
  border-left: 4px solid #ef4444;
  background: linear-gradient(135deg, #fef2f2 0%, #f8fafc 100%);
}

/* 编程题答案状态 */
.programming-result {
  margin-top: 1rem;
  padding: 1rem;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 0.8rem;
  font-weight: 500;
}

.programming-result.correct {
  background: #f0fdf4;
  color: #22c55e;
  border: 1px solid #22c55e;
}

.programming-result.pending {
  background: #fef3c7;
  color: #f59e0b;
  border: 1px solid #f59e0b;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .answer-status {
    width: 24px;
    height: 24px;
    right: 40px;
    font-size: 0.9rem;
  }

  .result-badge {
    font-size: 0.9rem;
    gap: 0.6rem;
  }
}

/* 统一的答题状态徽章 */
.answer-status-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.3rem 0.8rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
  margin-left: 1rem;
  animation: statusFadeIn 0.5s ease;
}

.answer-status-badge.status-correct {
  background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
  color: #16a34a;
  border: 1px solid #22c55e;
}

.answer-status-badge.status-wrong {
  background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
  color: #dc2626;
  border: 1px solid #ef4444;
}

.answer-status-badge i {
  font-size: 0.9rem;
}

@keyframes statusFadeIn {
  0% {
    opacity: 0;
    transform: scale(0.8);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}

/* 响应式调整 */
@media (max-width: 768px) {
  .answer-status-badge {
    font-size: 0.75rem;
    padding: 0.2rem 0.6rem;
    margin-left: 0.5rem;
  }
}

/* 在 style 部分添加统计文本样式 */
.statistics-text {
  font-weight: 500;
  color: #64748b;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.statistics-text.has-correct {
  color: #16a34a;
}

.statistics-text.has-correct::before {
  content: "📊";
  font-size: 1.1rem;
}

/* 美化 form-grid 样式 */
.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
  margin: 2rem 0;
  padding: 1.5rem;
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.8rem;
  padding: 1.2rem;
  background: white;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.form-group::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 4px;
  height: 100%;
  background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.form-group:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  border-color: #cbd5e1;
}

.form-group:hover::before {
  opacity: 1;
}

.form-group label {
  font-weight: 600;
  color: #475569;
  font-size: 0.9rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin: 0;
  padding: 0;
  line-height: 1.2;
}

.form-group label i {
  color: var(--primary);
  font-size: 1rem;
}

.form-value {
  font-size: 1.1rem;
  font-weight: 500;
  color: #1e293b;
  line-height: 1.4;
}

/* 难度徽章样式 */
.difficulty-badge {
  display: inline-flex;
  align-items: center;
  padding: 0.4rem 1rem;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  text-align: center;
  min-width: fit-content;
}

.difficulty-简单 {
  background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
  color: #16a34a;
  border: 1px solid #22c55e;
}

.difficulty-中等 {
  background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
  color: #d97706;
  border: 1px solid #f59e0b;
}

.difficulty-困难 {
  background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
  color: #dc2626;
  border: 1px solid #ef4444;
}

/* 时间徽章样式 */
.time-badge {
  display: inline-flex;
  align-items: center;
  padding: 0.4rem 1rem;
  background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
  color: #0369a1;
  border: 1px solid #0ea5e9;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  min-width: fit-content;
}

/* 统计文本样式增强 */
.statistics-text {
  font-weight: 600;
  color: #64748b;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.4rem 1rem;
  background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
  border-radius: 20px;
  border: 1px solid #cbd5e1;
  font-size: 0.9rem;
}

.statistics-text.has-correct {
  background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
  color: #16a34a;
  border-color: #22c55e;
}

.statistics-text.has-correct::before {
  content: "📊";
  font-size: 1.1rem;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .form-grid {
    grid-template-columns: 1fr;
    gap: 1rem;
    padding: 1rem;
  }

  .form-group {
    padding: 1rem;
  }

  .form-group label {
    font-size: 0.8rem;
  }

  .form-value {
    font-size: 1rem;
  }
}

/* 动画效果 */
@keyframes slideInUp {
  0% {
    opacity: 0;
    transform: translateY(20px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

.form-grid {
  animation: slideInUp 0.6s ease-out;
}

.form-group {
  animation: slideInUp 0.6s ease-out;
  animation-delay: calc(var(--index, 0) * 0.1s);
}
</style>
