<script setup lang="ts">
import { ref } from 'vue';

import { streamAsyncIterable } from './api/stream-async-iterable';

import { createParser } from 'eventsource-parser';
// 添加message导入
import { message } from 'ant-design-vue';

const jaObj = {
    "jxfa": {
        "lt": "90分钟",
        "lljj": "40分钟",
        "sjcz": "40分钟",
        "hdhj": "10分钟"
    },
    "zsd": [
        {
            "zt": "进程生命周期管理",
            "nr": [
                "进程创建机制：fork()系统调用原理",
                "进程终止方式：正常退出与异常终止",
                "进程状态转换：运行、就绪、阻塞状态",
                "进程控制：exec系列函数功能",
                "孤儿进程与僵尸进程处理",
                "进程组与会话管理"
            ],
            "sc": "15分钟"
        },
        {
            "zt": "调度算法实现原理",
            "nr": [
                "CFS公平调度器核心机制",
                "实时调度策略：SCHED_FIFO与SCHED_RR",
                "调度优先级计算方式",
                "负载均衡在多核系统中的实现",
                "Nice值与CPU亲和性的关系",
                "调度类切换条件分析"
            ],
            "sc": "15分钟"
        },
        {
            "zt": "资源竞争与优先级调整",
            "nr": [
                "CPU时间片分配策略",
                "内存管理中的优先级影响",
                "I/O优先级设置方法",
                "实时优先级与普通进程的交互",
                "调度延迟优化技巧",
                "公平性调整参数解析"
            ],
            "sc": "10分钟"
        }
    ],
    "sxal": [
        {
            "zt": "Web服务器压力测试",
            "gs": "通过模拟高并发访问场景，测试Nginx服务器性能",
            "mb": [
                "掌握ab压力测试工具使用",
                "理解进程调度对Web服务的影响",
                "学会分析top命令输出结果"
            ],
            "gc": [
                "安装ab测试工具",
                "编写简单的PHP测试页面",
                "设置不同并发参数进行测试",
                "分析top命令输出中的进程状态",
                "比较不同调度策略下的性能差异",
                "优化Nginx配置提升并发处理能力"
            ]
        },
        {
            "zt": "数据库批量导入优化",
            "gs": "通过调整导入进程参数，优化MySQL大数据量导入效率",
            "mb": [
                "了解导入进程的资源消耗特点",
                "掌握strace工具的使用方法",
                "学会分析进程调度瓶颈"
            ],
            "gc": [
                "创建测试数据库表",
                "准备百万级数据文件",
                "使用默认参数导入数据",
                "通过调整导入线程数进行优化",
                "分析iozone测试结果",
                "编写自动化导入脚本"
            ]
        },
        {
            "zt": "实时音频处理系统",
            "gs": "构建低延迟音频处理系统，测试实时调度策略效果",
            "mb": [
                "理解实时进程的特殊需求",
                "掌握进程优先级调整方法",
                "学会使用rt-tests工具",
                "分析系统延迟产生原因"
            ],
            "gc": [
                "安装alsa-lib开发包",
                "编写音频处理程序",
                "设置不同优先级进行测试",
                "使用cgroups限制资源",
                "分析音频延迟数据",
                "优化系统配置减少抖动"
            ]
        }
    ],
    "hdnr": {
        "课堂问答挑战": [
            "进程控制块(PCB)包含哪些关键信息？",
            "如何理解CFS调度器的红黑树实现？",
            "为什么实时进程需要使用SCHED_RR策略？",
            "僵尸进程对系统有什么影响？如何避免？"
        ],
        "小组讨论": [
            "讨论：为什么Linux采用多级反馈队列调度算法？",
            "思考：进程优先级调整与实时调度的区别",
            "探讨：如何平衡系统响应性和公平性"
        ],
        "实践竞赛": [
            "优化一个Python脚本的CPU占用率",
            "设计一个高效的后台服务进程",
            "实现一个简单的CPU负载测试工具"
        ],
        "概念建模": [
            "绘制进程生命周期转换图",
            "设计进程调度算法的流程图",
            "构建进程优先级计算的数学模型"
        ]
    }
}

// 添加响应式变量
const courseTopic = ref('Linux进程管理与调度机制深度解析');
const selectedSubject = ref('计算机科学与技术');
const selectedDifficulty = ref('中级');

// 学科选项
const subjectOptions = ref([
  '计算机科学与技术',
  '软件工程',
  '计算机系统结构',
  '操作系统',
  '计算机网络',
  '人工智能与机器学习',
  '数据科学与大数据',
  '网络安全与信息安全',
  '物联网工程',
  '云计算与分布式系统',
  '人机交互与用户体验',
]);

// 难度选项
const difficultyOptions = ref(['初级', '中级', '高级']);

const content = ref(`
根据要求生成教案
要求1：课程主题为${courseTopic.value}
要求2：难度为${selectedDifficulty.value}
生成内容1：教学方案概览，总时长90分钟，包括理论讲解，实践操作和互动环节，自己根据实际课程类型去合理分配时间
生成内容2：知识点结构，知识点最少3个，每个知识点都由主题、内容分点组成，指定合理的讲解时间，每个主题的内容分点大概列4-6个即可。
生成内容3：实训案例设计，给出3个实训案例，实训案例有主题、概述、实训目标和实训过程组成，每个主题分点大概4-6个即可。
生成内容4：互动内容设计，互动内容必须是四个，主题固定，分别为：课堂问答挑战、小组讨论、实践竞赛、概念建模，其中：课堂问答挑战列出3个问题，小组讨论列出3个讨论任务、实践竞赛给出3个竞赛主题，概念建模列出3个建模任务。
最终结果以JSON格式返回，jxfa为教学方案概览，其中：lt为总时长，lljj为理论讲解，sjcz为实践操作，hdhj为互动环节；zsd为知识点结构其中：zt为主题，nr为内容，sc为讲解时间；sxal为实训案例，其中zt为主题，gs为概述，mb为实训目标，gc为实训过程；hdnr为互动内容，其中：zt为主题，nr为表示问题、任务或竞赛主题。
`);
const textRz = ref<string[]>([]);
// 添加loading状态
const isLoading = ref(false);

function onMessage(data: string) {
  if (data === '[DONE]') {
    textRz.value.push('');
    // 完成时关闭loading
    isLoading.value = false;
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

async function generateTeachingPlan() {
  console.log('thinking...');
  // 开始loading
  isLoading.value = true;
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
      messages: [{ content: content.value, role: 'user' }],
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
        isLoading.value = false; // 错误时关闭loading
      },
      body: JSON.stringify(body),
    };

    let res;
    try {
      res = await fetch(apiUrl, { ...fetchOptions });
      console.log('resbody==========', res.body);
    } catch (e: any) {
      isLoading.value = false; // 错误时关闭loading
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
      isLoading.value = false; // 错误时关闭loading
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
    console.log(processArrayAfterThink(textRz.value));
    console.log(JSON.parse(processArrayAfterThink(textRz.value)));
    isLoading.value = false;

    // 添加成功提示
    message.success({
      content: '🎉 教学方案生成成功！',
      duration: 3,
    });
  } catch (error) {
    console.error('生成教学方案失败:', error);
    isLoading.value = false;

    // 添加错误提示
    message.error({
      content: '❌ 教学方案生成失败，请重试',
      duration: 3,
    });
  }
}

function processArrayAfterThink(textArray) {
  // 找到第一个包含 </think> 的元素的索引
  const thinkIndex = textArray.findIndex((item: any) => item.includes('</think>'));
  // 截取 </think> 元素之后的所有内容
  const contentAfterThink = textArray.slice(thinkIndex + 1);
  // 将截取的内容拼接成字符串
  const result = contentAfterThink.join('');
  // 移除所有换行符
  return result.replace(/\n/g, '').replace(/\s/g, '').replace(/```/g, '').replace('json', '');
}
</script>
<template>
  <div class="main-content">
    <!-- Loading遮罩层 -->
    <div v-if="isLoading" class="loading-overlay">
      <div class="loading-container">
        <div class="loading-spinner">
          <div class="spinner-ring"></div>
          <div class="spinner-ring"></div>
          <div class="spinner-ring"></div>
        </div>
        <div class="loading-text">
          <i class="fas fa-brain"></i>
          AI正在生成教学方案...
        </div>
        <div class="loading-progress">
          <div class="progress-bar">
            <div class="progress-fill"></div>
          </div>
          <div class="progress-text">请稍候，这可能需要几秒钟</div>
        </div>
      </div>
    </div>

    <div class="page-header">
      <h1 class="page-title">智能教学方案</h1>
      <div>
        <button class="btn btn-success">
          <i class="fas fa-download"></i>
          导出方案
        </button>
      </div>
    </div>

    <div class="section-title">
      <i class="fas fa-cogs"></i>
      课程设置
    </div>

    <!-- 课程设置区域 -->
    <div class="config-container">
      <div class="config-form">
        <div class="form-group">
          <label for="course-topic"><i class="fas fa-book"></i> 课程主题</label>
          <input
            type="text"
            id="course-topic"
            v-model="courseTopic"
          />
        </div>

        <div class="form-group">
          <label for="subject"
            ><i class="fas fa-graduation-cap"></i> 学科选择</label
          >
          <select id="subject" v-model="selectedSubject">
            <option v-for="subject in subjectOptions" :key="subject" :value="subject">
              {{ subject }}
            </option>
          </select>
        </div>

        <div class="form-group">
          <label for="difficulty"
            ><i class="fas fa-chart-line"></i> 难度级别</label
          >
          <select id="difficulty" v-model="selectedDifficulty">
            <option v-for="difficulty in difficultyOptions" :key="difficulty" :value="difficulty">
              {{ difficulty }}
            </option>
          </select>
        </div>
      </div>

      <div style="display: flex; justify-content: flex-end; margin-top: 20px">
        <button
          class="btn btn-primary"
          @click="generateTeachingPlan"
          :disabled="isLoading"
        >
          <i class="fas fa-redo" :class="{ 'fa-spin': isLoading }"></i>
          {{ isLoading ? '生成中...' : '重新生成方案' }}
        </button>
      </div>
    </div>

    <div class="section-title">
      <i class="fas fa-chalkboard-teacher"></i>
      教学方案概览
    </div>

    <!-- 教学方案概览 -->
    <div class="teaching-plan-container">
      <div class="plan-summary">
        <div class="summary-card">
          <div class="summary-icon">
            <i class="fas fa-clock"></i>
          </div>
          <div class="summary-title">总时长</div>
          <div class="summary-value">{{ jaObj.jxfa.lt }}</div>
        </div>

        <div class="summary-card theory">
          <div class="summary-icon">
            <i class="fas fa-book"></i>
          </div>
          <div class="summary-title">理论讲解</div>
          <div class="summary-value">{{ jaObj.jxfa.lljj }}</div>
          <div class="summary-subtitle">系统知识讲解与概念分析</div>
        </div>

        <div class="summary-card practice">
          <div class="summary-icon">
            <i class="fas fa-laptop-code"></i>
          </div>
          <div class="summary-title">实践操作</div>
          <div class="summary-value">{{ jaObj.jxfa.sjcz }}</div>
          <div class="summary-subtitle">案例实现与任务训练</div>
        </div>

        <div class="summary-card interaction">
          <div class="summary-icon">
            <i class="fas fa-users"></i>
          </div>
          <div class="summary-title">互动环节</div>
          <div class="summary-value">{{ jaObj.jxfa.hdhj }}</div>
          <div class="summary-subtitle">融入在各环节中</div>
        </div>
      </div>

      <div class="section-title" style="margin-top: 30px">
        <i class="fas fa-sitemap"></i>
        知识点结构
      </div>

      <!-- 知识点结构 -->
      <div class="knowledge-structure">
        <div class="timeline">
          <div class="timeline-item" v-for="item in jaObj.zsd">
            <div class="timeline-content">
              <h3 class="timeline-title">
                <i class="fas fa-play-circle"></i>
                {{ item.zt }}
              </h3>
              <div class="timeline-duration">
                <i class="fas fa-clock"></i> {{ item.sc }}
              </div>
              <ul>
                <li v-for="item1 in item.nr">{{ item1 }}</li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <div class="section-title" style="margin-top: 30px">
        <i class="fas fa-laptop-code"></i>
        实训案例设计
      </div>

      <!-- 实训案例 -->
      <div class="practice-container">
        <div class="case-cards">
          <div class="case-card" v-for="item in jaObj.sxal">
            <div class="case-header">
              <i class="fas fa-bug"></i>
              <div class="case-title">{{ item.zt }}</div>
            </div>
            <div class="case-body">
              <p class="case-desc">
                {{ item.gs }}
              </p>
              <div class="case-goal">
                <strong>实践目标：</strong>{{ item.mb.join('，') }}
              </div>
              <ol class="case-steps">
                <li v-for="item1 in item.gc">{{ item1 }}</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <div class="section-title" style="margin-top: 30px">
        <i class="fas fa-comments"></i>
        互动内容设计
      </div>

      <!-- 互动内容 -->
      <div class="interaction-container">
        <div class="interaction-grid">
          <div class="interaction-card">
            <div class="interaction-icon">
              <i class="fas fa-question-circle"></i>
            </div>
            <h3 class="interaction-title">课堂问答挑战</h3>
            <p class="interaction-content">
              在理论讲解过程中设置关键问题提问：
              <br /><br />
              <div v-for="(item, index) in jaObj.hdnr.课堂问答挑战">
                <strong>Q{{ index + 1 }}:</strong>
                "{{ item }}"
                <br />
              </div>
            </p>
            <div class="interaction-duration">
              <i class="fas fa-clock"></i> 每问题3-5分钟讨论
            </div>
          </div>

          <div class="interaction-card">
            <div class="interaction-icon">
              <i class="fas fa-users"></i>
            </div>
            <h3 class="interaction-title">小组讨论</h3>
            <p class="interaction-content">
              分组讨论进程通信机制的实际应用场景：
              <br /><br />
              <div v-for="(item, index) in jaObj.hdnr.小组讨论">
                <strong>任务{{ index + 1 }}:</strong>
                "{{ item }}"
                <br />
              </div>
            </p>
            <div class="interaction-duration">
              <i class="fas fa-clock"></i> 15分钟分组讨论
            </div>
          </div>

          <div class="interaction-card">
            <div class="interaction-icon">
              <i class="fas fa-trophy"></i>
            </div>
            <h3 class="interaction-title">实践竞赛</h3>
            <p class="interaction-content">
              实训环节开展小组竞赛：
              <br /><br />
              <div v-for="(item, index) in jaObj.hdnr.实践竞赛">
                <strong>竞赛{{ index + 1 }}:</strong>
                "{{ item }}"
                <br />
              </div>
            </p>
            <div class="interaction-duration">
              <i class="fas fa-clock"></i> 每竞赛7-10分钟
            </div>
          </div>

          <div class="interaction-card">
            <div class="interaction-icon">
              <i class="fas fa-brain"></i>
            </div>
            <h3 class="interaction-title">概念建模</h3>
            <p class="interaction-content">
              利用白板进行概念可视化：
              <br /><br />
              <div v-for="(item, index) in jaObj.hdnr.概念建模">
                <strong>任务{{ index + 1 }}:</strong>
                "{{ item }}"
                <br />
              </div>
            </p>
            <div class="interaction-duration">
              <i class="fas fa-clock"></i> 每组8分钟展示
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
/* 主内容区域 */
.main-content {
  flex: 1;
  /* margin-left: 260px; */
  padding: 30px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.page-title {
  font-size: 28px;
  color: #1a237e;
  font-weight: 700;
}

.section-title {
  display: flex;
  align-items: center;
  font-size: 24px;
  color: #1a237e;
  margin-bottom: 25px;
  border-left: 4px solid #3a8cff;
  padding-left: 15px;
}

.section-title i {
  margin-right: 12px;
  color: #3a8cff;
}

/* 课程设置区域 */
.config-container {
  background: white;
  border-radius: 12px;
  padding: 30px;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
  margin-bottom: 30px;
}

.config-form {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 25px;
}

.form-group {
  display: flex;
  flex-direction: column;
}

.form-group label {
  font-weight: 500;
  margin-bottom: 12px;
  color: #455a64;
  font-size: 18px;
}

.form-group select,
.form-group input {
  padding: 14px 15px;
  border: 1px solid #e0e7ed;
  border-radius: 8px;
  font-size: 16px;
  background: white;
  transition: all 0.3s;
}

.form-group select:focus,
.form-group input:focus {
  border-color: #3a8cff;
  outline: none;
  box-shadow: 0 0 0 3px rgba(58, 140, 255, 0.2);
}

.btn {
  padding: 12px 25px;
  border-radius: 8px;
  font-weight: 500;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s;
  border: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.btn-primary {
  background: linear-gradient(135deg, #1e62d0, #3a8cff);
  color: white;
}

.btn-primary:hover {
  background: linear-gradient(135deg, #154bb0, #2971df);
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(58, 140, 255, 0.4);
}

.btn-success {
  background: linear-gradient(135deg, #2e7d32, #4caf50);
  color: white;
}

.btn-success:hover {
  background: linear-gradient(135deg, #1b5e20, #388e3c);
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
}

/* 教学方案卡片 */
.teaching-plan-container {
  background: white;
  border-radius: 12px;
  padding: 30px;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
  margin-bottom: 30px;
}

.plan-summary {
  display: flex;
  gap: 25px;
  margin-bottom: 30px;
  flex-wrap: wrap;
}

.summary-card {
  flex: 1;
  min-width: 250px;
  padding: 20px;
  border-radius: 10px;
  background: linear-gradient(135deg, #e6f7ff, #d1edff);
  box-shadow: 0 3px 8px rgba(58, 140, 255, 0.15);
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.summary-card.theory {
  background: linear-gradient(135deg, #e1f5fe, #b3e5fc);
}

.summary-card.practice {
  background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
}

.summary-card.interaction {
  background: linear-gradient(135deg, #fff8e1, #ffecb3);
}

.summary-icon {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 15px;
  font-size: 28px;
  color: #1a237e;
}

.summary-title {
  font-size: 18px;
  font-weight: 600;
  color: #1a237e;
  margin-bottom: 5px;
}

.summary-value {
  font-size: 28px;
  font-weight: 700;
  color: #3a8cff;
  margin-bottom: 5px;
}

.summary-subtitle {
  font-size: 15px;
  color: #78909c;
}

/* 知识点结构 */
.knowledge-structure {
  margin-bottom: 35px;
}

.timeline {
  position: relative;
  padding-left: 30px;
  max-width: 800px;
  margin-left: 10px;
}

.timeline::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 4px;
  background: linear-gradient(to bottom, #3a8cff, #26d0ce);
}

.timeline-item {
  position: relative;
  margin-bottom: 30px;
  padding-left: 25px;
}

.timeline-item:last-child {
  margin-bottom: 0;
}

.timeline-item::before {
  content: '';
  position: absolute;
  left: -38px;
  top: 5px;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: #3a8cff;
  border: 3px solid white;
  box-shadow: 0 0 0 3px #3a8cff;
}

.timeline-content {
  background: #f0f8ff;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
}

.timeline-title {
  font-size: 20px;
  color: #1a237e;
  margin-bottom: 15px;
  display: flex;
  align-items: center;
}

.timeline-title i {
  margin-right: 10px;
  color: #3a8cff;
}

.timeline-duration {
  background: #e3f2fd;
  padding: 3px 10px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
  color: #1e62d0;
  display: inline-block;
  margin-bottom: 15px;
}

.timeline-content ul {
  padding-left: 20px;
}

.timeline-content li {
  margin-bottom: 10px;
  line-height: 1.6;
}

/* 实训案例 */
.practice-container {
  margin-bottom: 35px;
}

.case-cards {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  margin-top: 20px;
}

.case-card {
  flex: 1;
  min-width: 300px;
  background: #f8fafc;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #eef5ff;
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.03);
  transition: all 0.3s;
}

.case-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

.case-header {
  background: linear-gradient(135deg, #3a8cff, #26d0ce);
  color: white;
  padding: 15px 20px;
  display: flex;
  align-items: center;
}

.case-header i {
  font-size: 20px;
  margin-right: 10px;
}

.case-title {
  font-weight: 600;
  font-size: 18px;
}

.case-body {
  padding: 20px;
}

.case-desc {
  margin-bottom: 15px;
  line-height: 1.6;
  color: #455a64;
}

.case-goal {
  padding: 10px;
  background: #e3f2fd;
  border-left: 4px solid #3a8cff;
  margin-bottom: 15px;
  border-radius: 0 8px 8px 0;
}

.case-steps {
  padding-left: 20px;
}

.case-steps li {
  margin-bottom: 10px;
  line-height: 1.6;
  color: #455a64;
}

/* 互动内容 */
.interaction-container {
  margin-bottom: 35px;
}

.interaction-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 25px;
  margin-top: 20px;
}

.interaction-card {
  background: #f8fafc;
  border-radius: 12px;
  padding: 25px;
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.03);
  border: 1px solid #eef5ff;
  transition: all 0.3s;
}

.interaction-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

.interaction-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: linear-gradient(135deg, #e3f2fd, #bbdefb);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  color: #3a8cff;
  margin-bottom: 20px;
}

.interaction-title {
  font-size: 18px;
  font-weight: 600;
  color: #1a237e;
  margin-bottom: 15px;
}

.interaction-content {
  line-height: 1.6;
  color: #455a64;
  margin-bottom: 20px;
}

.interaction-duration {
  background: #e3f2fd;
  padding: 3px 10px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
  color: #1e62d0;
  display: inline-flex;
  align-items: center;
}

.interaction-duration i {
  margin-right: 5px;
}

/* 响应式设计 */
@media (max-width: 992px) {
  .sidebar {
    width: 70px;
    overflow: visible;
  }

  .logo span,
  .nav-title,
  .nav-links a span {
    display: none;
  }

  .logo {
    justify-content: center;
    padding: 0;
  }

  .logo i {
    margin-right: 0;
  }

  .main-content {
    margin-left: 70px;
  }
}

@media (max-width: 768px) {
  .config-form {
    grid-template-columns: 1fr;
  }

  .case-cards,
  .interaction-grid {
    grid-template-columns: 1fr;
  }
}

/* Loading样式 */
.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(5px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
  animation: fadeIn 0.3s ease-in-out;
}

.loading-container {
  background: white;
  border-radius: 20px;
  padding: 40px;
  text-align: center;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  max-width: 400px;
  width: 90%;
  animation: slideUp 0.4s ease-out;
}

.loading-spinner {
  position: relative;
  width: 80px;
  height: 80px;
  margin: 0 auto 30px;
}

.spinner-ring {
  position: absolute;
  width: 100%;
  height: 100%;
  border: 3px solid transparent;
  border-radius: 50%;
  animation: spin 2s linear infinite;
}

.spinner-ring:nth-child(1) {
  border-top-color: #667eea;
  animation-delay: 0s;
}

.spinner-ring:nth-child(2) {
  border-top-color: #764ba2;
  animation-delay: 0.3s;
  width: 70%;
  height: 70%;
  top: 15%;
  left: 15%;
}

.spinner-ring:nth-child(3) {
  border-top-color: #f093fb;
  animation-delay: 0.6s;
  width: 40%;
  height: 40%;
  top: 30%;
  left: 30%;
}

.loading-text {
  font-size: 18px;
  color: #1a237e;
  font-weight: 600;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}

.loading-text i {
  color: #667eea;
  animation: pulse 1.5s ease-in-out infinite;
}

.loading-progress {
  margin-top: 20px;
}

.progress-bar {
  width: 100%;
  height: 6px;
  background: #f0f0f0;
  border-radius: 3px;
  overflow: hidden;
  margin-bottom: 10px;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 3px;
  animation: progressMove 2s ease-in-out infinite;
}

.progress-text {
  font-size: 14px;
  color: #666;
  font-style: italic;
}

/* 按钮禁用状态 */
.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  pointer-events: none;
}

/* 动画定义 */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideUp {
  from {
    transform: translateY(30px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

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
  }
  50% {
    transform: scale(1.1);
  }
}

@keyframes progressMove {
  0% {
    transform: translateX(-100%);
  }
  50% {
    transform: translateX(0%);
  }
  100% {
    transform: translateX(100%);
  }
}
</style>
