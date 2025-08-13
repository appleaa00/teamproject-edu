<script setup lang="ts">
import type { Role } from '#/api/system/user/model';

import { computed, watch, ref, onMounted } from 'vue';

import { useVbenDrawer } from '@vben/common-ui';
import { $t } from '@vben/locales';
import { cloneDeep } from '@vben/utils';

import { Tag } from 'ant-design-vue';

const topicDifficulty = ref('中等');
const topicPoint = ref('');
const topicType = ref('选择题');

import { useVbenForm } from '#/adapter/form';
import { findTopic, topicAdd, userUpdate } from '#/api/a7/topic';
import { authScopeOptions } from '#/views/system/role/data';

import { drawerSchema } from './data';

console.log('drawerSchema = ', drawerSchema);

import Prism from 'prismjs';
import 'prismjs/plugins/line-numbers/prism-line-numbers.min.js'; //行号插件
import 'prismjs/themes/prism-okaidia.min.css'; //高亮主题
import 'prismjs/components/prism-python.min.js'; //高亮主题
import 'prismjs/plugins/line-numbers/prism-line-numbers.min.css'; //行号插件的样式

import { streamAsyncIterable } from './api/stream-async-iterable';
import { createParser } from 'eventsource-parser';
// 添加message导入
import { message } from 'ant-design-vue';

const emit = defineEmits<{ reload: [] }>();

const isUpdate = ref(false);
const title = computed(() => {
  return isUpdate.value ? $t('pages.common.edit') : $t('pages.common.add');
});

const jsonStr1 = ref({
  topicName: 'Python变量类型转换选择题',
  topicAnswer:
    '在Python中，int()函数可以将字符串转换为整数，前提是字符串表示一个数字。选项A正确。选项B的str()函数用于将其他类型转换为字符串，但这里是将整数转换为字符串，不符合题目要求。选项C的float()函数可以将字符串转换为浮点数，但题目要求整数。选项D的bool()函数将字符串转换为布尔值，非空字符串为True，但这不是正确的转换。',
  topicOptions: [
    {
      sorted: 'A',
      optionContent: 'int("123")',
      rightAnswer: true,
    },
    {
      sorted: 'B',
      optionContent: 'str(123)',
      rightAnswer: false,
    },
    {
      sorted: 'C',
      optionContent: 'float("123")',
      rightAnswer: false,
    },
    {
      sorted: 'D',
      optionContent: 'bool("123")',
      rightAnswer: false,
    },
  ],
});
const jsonStr2 = ref({
  topicName: '实现多进程计算的Python程序',
  topicAnswer: "正确使用multiprocessing模块，实现进程池管理，正确处理主模块判断",
  topicContent: `import multiprocessing

def square(n):
    return n ** 2

if __name__ == "__main__":
    with multiprocessing.Pool() as pool:
        results = pool.map(square, range(10))
        print(results)`,
});

const [BasicForm, formApi] = useVbenForm({
  commonConfig: {
    formItemClass: 'col-span-2',
    componentProps: {
      class: 'w-full',
    },
    labelWidth: 80,
  },
  schema: drawerSchema(),
  showDefaultActions: false,
  wrapperClass: 'grid-cols-2',
});

watch(
  () => topicDifficulty.value,
  async (n, v) => {
    await formApi.setFieldValue('topicDifficulty', n);
  },
);

const [BasicDrawer, drawerApi] = useVbenDrawer({
  onCancel: handleCancel,
  onConfirm: handleConfirm,
  async onOpenChange(isOpen) {
    if (!isOpen) {
      return null;
    }
    drawerApi.drawerLoading(true);
    const { id } = drawerApi.getData() as { id?: number | string };
    isUpdate.value = !!id;
    /** update时 禁用用户名修改 不显示密码框 */
    formApi.updateSchema([
      { componentProps: { disabled: isUpdate.value }, fieldName: 'userName' },
      {
        dependencies: { show: () => !isUpdate.value, triggerFields: ['id'] },
        fieldName: 'password',
      },
    ]);
    // 更新 && 赋值
    const { topic } = await findTopic(id);
    if (topic) {
      await formApi.setValues(topic);
    }
    drawerApi.drawerLoading(false);
  },
});

async function handleConfirm() {
  try {
    drawerApi.drawerLoading(true);
    const { valid } = await formApi.validate();
    if (!valid) {
      return;
    }

    await formApi.setFieldValue('topicType', topicType.value);
    await formApi.setFieldValue('topicDifficulty', topicDifficulty.value);
    await formApi.setFieldValue('topicName', jsonStr1.value.topicName);
    await formApi.setFieldValue('topicAnswer', jsonStr1.value.topicAnswer);
    if (topicType.value === '选择题') {
      await formApi.setFieldValue('topicOptions', jsonStr1.value.topicOptions);
    }
    if (topicType.value === '编程题') {
      await formApi.setFieldValue('topicContent', jsonStr2.value.topicContent);
    }

    const data = cloneDeep(await formApi.getValues());
    await (isUpdate.value ? userUpdate(data) : topicAdd(data));
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
  await formApi.resetForm();
}

// 题型选择交互
async function selectType(type) {
  document.querySelectorAll('.type-card').forEach((card) => {
    card.classList.remove('active');
  });
  event.currentTarget.classList.add('active');

  topicType.value = type;
  await formApi.setFieldValue('topicType', type);
}

const content1 = computed(
  () =>
    `按照知识点生成一道选择题题目，关联知识点是${topicPoint.value}，题目难度为${topicDifficulty.value}，固定四个选项，并给出参考答案选项，以json格式返回，topicName为题目名称，topicAnswer为答案解析，topicOptions为题目选项，在题目选项中，sorted为选项值，设定必须为A、B、C、D，optionContent为选项内容，rightAnswer是否为正确答案`,
);
const content2 = computed(
  () =>
    `按照知识点生成一道选择题题目，关联知识点是${topicPoint.value}，题目难度为${topicDifficulty.value}，固定四个选项，并给出参考答案选项，以json格式返回，topicName为题目名称，topicAnswer为答案解析，topicOptions为题目选项，在题目选项中，sorted为选项值，设定必须为A、B、C、D，optionContent为选项内容，rightAnswer是否为正确答案`,
);

function processArrayAfterThink(textArray) {
  // 找到第一个包含 </think> 的元素的索引
  const thinkIndex = textArray.findIndex((item: any) =>
    item.includes('</think>'),
  );
  // 截取 </think> 元素之后的所有内容
  const contentAfterThink = textArray.slice(thinkIndex + 1);
  // 将截取的内容拼接成字符串
  const result = contentAfterThink.join('');
  // 移除所有换行符
  return result
    .replace(/\n/g, '')
    .replace(/\s/g, '')
    .replace(/```/g, '')
    .replace('json', '');
}
function onMessage(data: string) {
  if (data === '[DONE]') {
    textRz.value.push('');
    // 完成时关闭loading
    drawerApi.drawerLoading(false);
  } else {
    try {
      // TODO 思考处理，DeepSeek  API 字段reasoning_content ，本地部署标签<think>
      const obj = JSON.parse(data);
      const text =
        obj.choices[0].delta?.content ??
        obj.choices[0].delta?.reasoning_content ??
        '';
      textRz.value.push(text);
    } catch {
      textRz.value.push(data);
    }
  }
}
const textRz = ref<string[]>([]);
// 生成题目
async function generateQuestions() {
  console.log('thinking...');
  // const { topicType } = await formApi.getValues();
  // 开始loading
  drawerApi.drawerLoading(true);
  textRz.value = []; // 清空之前的结果

  try {
    const apiUrl = '/api/chat/send';
    const body = {
      max_tokens: 1024,
      model: 'deepseek/deepseek-r1-0528-qwen3-8b',
      temperature: 0.5,
      top_p: 1,
      presence_penalty: 0,
      frequency_penalty: 0,
      messages: [
        {
          content: topicType.value === '编程题' ? content2.value : content1.value,
          role: 'user',
        },
      ],
      stream: true,
      kid: '',
      chat_type: 0,
      appId: '',
      userId: 1002,
    };

    const headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      Accept: 'text/event-stream ',
    };

    const fetchOptions = {
      method: 'POST',
      headers,
      onMessage,
      onError(e: any) {
        console.log(e);
        drawerApi.drawerLoading(false); // 错误时关闭loading
      },
      body: JSON.stringify(body),
    };

    let res;
    try {
      res = await fetch(apiUrl, { ...fetchOptions });
      console.log('resbody==========', res.body);
    } catch (e: any) {
      drawerApi.drawerLoading(false); // 错误时关闭loading
      throw {
        reason: JSON.stringify({
          message: 'fetch error, pleace check url',
          url: apiUrl,
          code: 'fetch_error',
        }),
      };
    }

    console.log('res', res);
    if (!res.ok) {
      let reason: string;
      try {
        reason = await res.text();
      } catch (err) {
        reason = res.statusText;
      }
      drawerApi.drawerLoading(false); // 错误时关闭loading
      return;
    }

    const parser = createParser((event) => {
      if (event.type === 'event') {
        onMessage(event.data);
      }
    });

    const feed = (chunk: string) => {
      parser.feed(chunk);
    };

    if (!res.body.getReader) {
      const body: NodeJS.ReadableStream = res.body as any;
      body.on('readable', () => {
        let chunk: string | Buffer;
        while (null !== (chunk = body.read())) {
          feed(chunk.toString());
        }
      });
    } else {
      for await (const chunk of streamAsyncIterable(res.body)) {
        const str = new TextDecoder().decode(chunk);
        feed(str);
      }
    }
    console.log('生成完成了...');
    console.log(textRz.value);
    console.log(JSON.parse(processArrayAfterThink(textRz.value)));
    if (topicType.value === '选择题') {
      jsonStr1.value = JSON.parse(processArrayAfterThink(textRz.value));
    }
    drawerApi.drawerLoading(false);

    // 添加成功提示
    message.success({
      content: '🎉 题目生成成功！',
      duration: 3,
    });
  } catch (error) {
    console.error('题目生成失败:', error);
    drawerApi.drawerLoading(false);

    // 添加错误提示
    message.error({
      content: '❌ 题目生成失败，请重试',
      duration: 3,
    });
  }
}

// 初始化代码高亮
onMounted(async () => {
  await formApi.setFieldValue('topicType', '选择题');
  await formApi.setFieldValue('topicDifficulty', '中等');
  console.log(await formApi.getValues());

  setTimeout(() => {
    Prism.highlightAll();
  }, 100);
});
</script>

<template>
  <BasicDrawer :close-on-click-modal="false" :title="title" class="w-[800px]">
    <BasicForm />
    <main class="main-content">
      <div class="question-card">
        <h2 style="color: var(--primary); margin-bottom: 1.5rem">
          <i class="fas fa-question-circle"></i> 智能题目生成
        </h2>

        <div class="form-grid">
          <div class="form-group">
            <label>关联知识点</label>
            <input
              type="text"
              class="input-control"
              placeholder="输入知识点（如：进程调度算法）"
              v-model="topicPoint"
            />
          </div>
          <div class="form-group">
            <label>题目难度</label>
            <select id="difficulty" v-model="topicDifficulty">
              <option>基础</option>
              <option>中等</option>
              <option>挑战</option>
            </select>
          </div>
        </div>

        <div class="question-type-selector">
          <!-- <div class="type-card " @click="selectType('all')">
            <i class="fas fa-layer-group" style="color: var(--primary)"></i>
            <div>全部题型</div>
          </div> -->
          <div class="type-card active" @click="selectType('选择题')">
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
          <!-- 示例题目1 -->
          <div class="question-item" v-if="topicType === '选择题'">
            <div class="question-header">
              <div style="line-height: 2">
                <span class="badge badge-primary">选择题</span>
                <span class="badge badge-success">难度：{{ topicDifficulty }}</span>
                <span style="margin-left: 1rem"
                  >{{ jsonStr1.topicName }}</span
                >
              </div>
            </div>
            <div class="question-content">
              <p><strong>选项：</strong></p>
              <ol type="A">
                <li v-for="item in jsonStr1.topicOptions">{{ item.sorted }}. {{ item.optionContent }}</li>
              </ol>
              <p><strong>参考答案：</strong>{{ jsonStr1.topicOptions.find(v => v.rightAnswer)?.sorted }}</p>
              <div class="action-buttons">
                <!-- <button class="generate-btn" style="padding: 8px 16px">
                  <i class="fas fa-edit"></i> 编辑
                </button>
                <button
                  class="generate-btn"
                  style="background: #ef4444; padding: 8px 16px"
                >
                  <i class="fas fa-trash"></i> 删除
                </button> -->
              </div>
            </div>
          </div>

          <!-- 示例题目2 -->
          <div class="question-item" v-if="topicType === '编程题'">
            <div class="question-header">
              <div>
                <span class="badge badge-primary">编程题</span>
                <span class="badge badge-success">难度：{{ topicDifficulty }}</span>
                <span style="margin-left: 1rem"
                  >{{ jsonStr2.topicName }}</span
                >
              </div>
            </div>
            <div class="question-content">
              <pre class="language-python"><code class="language-python">{{ jsonStr2.topicContent }}</code></pre>
              <p style="padding-top: 1rem"><strong>评分要点：</strong></p>
              <ul style="padding-top: 1rem">
                <li style="padding-top: 6px">{{ jsonStr2.topicAnswer }}</li>
              </ul>
              <div class="action-buttons">
                <!-- <button class="generate-btn" style="padding: 8px 16px">
                  <i class="fas fa-download"></i> 导出
                </button> -->
              </div>
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
  margin-bottom: 12px;
  color: #455a64;
  font-size: 18px;
  padding-right: 20px;
  line-height: 37px;
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
</style>
