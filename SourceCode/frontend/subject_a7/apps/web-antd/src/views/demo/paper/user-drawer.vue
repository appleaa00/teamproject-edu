<script setup lang="ts">
import { computed, ref, onMounted, reactive } from 'vue';

import { useVbenDrawer } from '@vben/common-ui';
import { $t } from '@vben/locales';
import { cloneDeep } from '@vben/utils';
import { findModel, paperAdd, userUpdate } from '#/api/a7/paper';
import { drawerSchema } from './data';

import Codemirror from 'codemirror-editor-vue3';
// language
import 'codemirror/mode/markdown/markdown.js';
// placeholder
import 'codemirror/addon/display/placeholder.js';
// theme
import 'codemirror/theme/dracula.css';

import * as _utils from './api/utils';


// 添加message导入
import { message } from 'ant-design-vue';

const emit = defineEmits<{ reload: [] }>();//通知外层页面刷新表格

const isUpdate = ref(false);//标记当前是添加还是编辑操作
const title = computed(() => {
  return isUpdate.value ? $t('pages.common.edit') : $t('pages.common.add');
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

// const topicList = ref(topicData.randomTopics);
// paperForm.topics = [...topicData.randomTopics];

const mirrorOptions = { mode: 'markdown', theme: 'dracula', lineNumbers: true };
const showTopic = ref(false);
const [BasicDrawer, drawerApi] = useVbenDrawer({
  onCancel: handleCancel,//点“取消”或关闭按钮时触发，绑定到 handleCancel 函数
  onConfirm: handleConfirm,//点“确认”按钮时触发，绑定到 handleConfirm 函数
  async onOpenChange(isOpen) {//打开抽屉时根据是否传 id 来区分“新增”还是“编辑”模式，并在编辑时加载原始数据
    if (!isOpen) {
      return null;
    }
    drawerApi.drawerLoading(true);
    const { id } = drawerApi.getData() as { id?: number | string };
    isUpdate.value = !!id;
    // 更新 && 赋值
    const paper = await findModel(id);
    if (id && paper) {
      Object.assign(paperForm, paper);
      showTopic.value = true;
    } else {
      showTopic.value = false;
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
    }
    drawerApi.drawerLoading(false);
  },
});

async function handleConfirm() {
  try {
    drawerApi.drawerLoading(true);
    // 参数校验
    paperForm.topics.forEach((topic) => {
      topic.topicDifficulty = paperForm.paperDifficulty;
    });
    const data = cloneDeep(paperForm);
    console.log(data);
    await (isUpdate.value ? userUpdate(data) : paperAdd(data));
    emit('reload');
    await handleCancel();
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
  showTopic.value = false;
}

// 题型选择交互
async function selectType(type) {
  document.querySelectorAll('.type-card').forEach((card) => {
    card.classList.remove('active');
  });
  event.currentTarget.classList.add('active');

  paperForm.paperType = type;
}

// 生成题目
async function generateQuestions() {
  console.log('thinking...');
  // 开始loading
  showTopic.value = false;
  drawerApi.drawerLoading(true);
  setTimeout(() => {
    let topicType = 'python';
    if (paperForm.paperSubject.toLocaleLowerCase().startsWith('java')) {
        topicType = 'java';
    }
    paperForm.topics = [..._utils.randomTopics(topicType)];
    showTopic.value = true;
    drawerApi.drawerLoading(false);
    message.success({
      content: '🎉 题目生成成功！',
      duration: 3,
    });
  }, 5000);
}

// 初始化代码高亮
onMounted(async () => {
  setTimeout(() => {
    // Prism.highlightAll();
  }, 100);
});
</script>

<template>
  <BasicDrawer :close-on-click-modal="false" :title="title" class="w-[1200px]">
    <main class="main-content">
      <div class="question-card">
        <h2 style="color: var(--primary); margin-bottom: 1.5rem">
          <i class="fas fa-question-circle"></i> 智能题目生成
        </h2>

        <div class="form-grid">
          <div class="form-group">
            <label>试卷名称</label>
            <input
              type="text"
              class="input-control"
              placeholder="输入试卷名称（如：暑期测验试卷）"
              v-model="paperForm.paperName"
            />
          </div>
          <div class="form-group">
            <label>关联知识点</label>
            <input
              type="text"
              class="input-control"
              placeholder="输入知识点（如：Python基础学习）"
              v-model="paperForm.paperSubject"
            />
          </div>
          <div class="form-group">
            <label>题目难度</label>
            <select id="difficulty" v-model="paperForm.paperDifficulty">
              <option>基础</option>
              <option>中等</option>
              <option>挑战</option>
            </select>
          </div>
          <div class="form-group">
            <label>作答时间</label>
            <input
              type="text"
              class="input-control"
              placeholder="请输入作答时间（单位：分钟）"
              v-model="paperForm.answerTime"
            />
          </div>
        </div>

        <div class="question-type-selector">
          <div class="type-card active" @click="selectType('全部题型')">
            <i class="fas fa-layer-group" style="color: var(--primary)"></i>
            <div>全部题型</div>
          </div>
          <div class="type-card" @click="selectType('选择题')">
            <i class="fas fa-list-ul" style="color: #10b981"></i>
            <div>选择题</div>
          </div>
          <div class="type-card" @click="selectType('编程题')">
            <i class="fas fa-code" style="color: #ef4444"></i>
            <div>编程题</div>
          </div>
        </div>

        <button class="generate-btn" @click="generateQuestions()">
          <i class="fas fa-sparkles"></i>
          立即生成题目
        </button>

        <div class="question-list" id="questionList">
          <!-- 空状态提示 -->
          <div class="empty-state" v-if="!showTopic">
            <div class="empty-icon">
              <i class="fas fa-clipboard-list"></i>
            </div>
            <h3 class="empty-title">暂无题目</h3>
            <p class="empty-description">
              点击上方"立即生成题目"按钮，AI将根据您的设置智能生成试题
            </p>
            <div class="empty-features">
              <div class="feature-item">
                <i class="fas fa-magic"></i>
                <span>AI智能生成</span>
              </div>
              <div class="feature-item">
                <i class="fas fa-cogs"></i>
                <span>多种题型支持</span>
              </div>
              <div class="feature-item">
                <i class="fas fa-chart-line"></i>
                <span>难度自定义</span>
              </div>
            </div>
            <div class="empty-tips">
              <i class="fas fa-lightbulb"></i>
              <span>提示：请先填写试卷信息，选择题型后再生成题目</span>
            </div>
          </div>

          <!-- 示例题目1 -->
          <div
            class="question-item"
            v-if="showTopic"
            v-for="(topic, index) in paperForm.topics"
          >
            <div class="question-header">
              <div style="line-height: 2">
                <span class="badge badge-primary">{{ topic.topicType }}</span>
                <span class="badge badge-success"
                  >难度：{{ paperForm.paperDifficulty }}</span
                >
                <span style="margin-left: 1rem">{{ topic.topicName }}</span>
              </div>
            </div>
            <div class="question-content" v-if="topic.topicType === '选择题'">
              <p><strong>选项：</strong></p>
              <ol type="A">
                <li v-for="item in topic.topicOptions">
                  {{ item.sorted }}. {{ item.optionContent }}
                </li>
              </ol>
              <p>
                <strong>参考答案：</strong
                >{{ topic.topicOptions.find((v) => v.rightAnswer)?.sorted }}
              </p>
            </div>
            <div class="question-content" v-if="topic.topicType === '编程题'">
              <div>要求：{{ topic.topicContent }}</div>
              <p style="padding-top: 1rem"><strong>要点解析：</strong></p>
              <ul style="padding-top: 1rem">
                <Codemirror
                  v-model:value="topic.topicAnswer"
                  :options="mirrorOptions"
                  border
                  placeholder="test placeholder"
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
</style>
