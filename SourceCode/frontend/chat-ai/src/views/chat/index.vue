//「聊天交互核心组件」 消息发送、AI 回复、历史管理、导出分享

<script setup lang='ts'>
import type { Ref } from "vue"
import { computed, onMounted, onUnmounted, ref, watch} from "vue"
import { useRoute } from "vue-router"
import { storeToRefs } from "pinia"
import {
  NAutoComplete,
  NButton,
  NInput,
  useDialog,
  useMessage
} from "naive-ui"
import html2canvas from "html2canvas"
import { Message } from "./components"
import { useScroll } from "./hooks/useScroll"
import { useChat } from "./hooks/useChat"
import { SvgIcon } from "@/components/common"
import { useBasicLayout } from "@/hooks/useBasicLayout"
import {
  gptConfigStore,
  gptsUlistStore,
  homeStore,
  useChatStore,
  usePromptStore,
  useAppStore
} from "@/store"
import {
  fetchChatAPIProcess,
  gptsType,
  mlog,
} from "@/api"
import { t } from "@/locales"
import drawListVue from "../mj/drawList.vue"
import aiGPT from "../mj/aiGpt.vue"
import AiSiderInput from "../mj/aiSiderInput.vue"
import aiGptInput from "../mj/aiGptInput.vue"
// 引入Monaco Editor
//import * as monaco from 'monaco-editor';
//import type {IStandaloneCodeEditor} from 'monaco-editor';


let controller = new AbortController() // 浏览器原生提供的 API，用于中止一个或多个正在进行的异步操作

const openLongReply = import.meta.env.VITE_GLOB_OPEN_LONG_REPLY === "true"

const route = useRoute()
const dialog = useDialog()
const ms = useMessage()

const chatStore = useChatStore()
const appStore = useAppStore()

const { isMobile } = useBasicLayout()

// 侧边栏控制
const collapsed = computed(() => appStore.siderCollapsed)
const {  updateChat, updateChatSome} = useChat()
const { scrollRef, scrollToBottom, scrollToBottomIfAtBottom } = useScroll()

const { uuid } = route.params as { uuid: string }

const dataSources = computed(() => chatStore.getChatByUuid(+uuid))

const prompt = ref<string>("")
const loading = ref<boolean>(false)
const inputRef = ref<Ref | null>(null)
const mainInputRef = ref<Ref | null>(null)

// AI建议数据
const aiSuggestions = ref([
  { id: 1, text: '给营销团队写一封邮件', featured: false },
  { id: 2, text: '总结要点', featured: true },
  { id: 3, text: '创建后续检查清单', featured: false },
  { id: 4, text: '分析数据并生成报告', featured: false },
  { id: 5, text: '制定学习计划', featured: false }
])

// 快速功能数据
const quickFeatures = ref([
  {
    id: 1,
    icon: '📝',
    title: '写作助手',
    description: '帮助您撰写各类文档和内容',
    action: 'writing'
  },
  {
    id: 2,
    icon: '📊',
    title: '数据分析',
    description: '智能分析数据并生成见解',
    action: 'analysis'
  },
  {
    id: 3,
    icon: '🎓',
    title: '学习辅导',
    description: '个性化学习指导和答疑',
    action: 'learning'
  }
])

// 添加PromptStore
const promptStore = usePromptStore()

// 使用storeToRefs，保证store修改后，联想部分能够重新渲染
const { promptList: promptTemplate } = storeToRefs<any>(promptStore)

// 未知原因刷新页面，loading 状态不会重置，手动重置
dataSources.value.forEach((item, index) => {
  if (item.loading) updateChatSome(+uuid, index, { loading: false })
})

function handleSubmit() {
  //onConversation() //把这个放到aiGpt
  let message = prompt.value
  if (!message || message.trim() === "") return // 消息为空 不发送
  if (loading.value) return
  loading.value = true
  homeStore.setMyData({
    act: "gpt.submit",
    actData: { prompt: prompt.value, uuid },
  })
  prompt.value = ""
}

async function onRegenerate(index: number) {
  if (loading.value) return

  controller = new AbortController()

  const { requestOptions } = dataSources.value[index]

  let message = requestOptions?.prompt ?? ""

  let options: Chat.ConversationRequest = {}

  if (requestOptions.options) options = { ...requestOptions.options }

  loading.value = true

  updateChat(+uuid, index, {
    dateTime: new Date().toLocaleString(),
    text: "",
    inversion: false,
    error: false,
    loading: true,
    conversationOptions: null,
    requestOptions: { prompt: message, options: { ...options } },
  })

  try {
    let lastText = ""
    const fetchChatAPIOnce = async () => {
      await fetchChatAPIProcess<Chat.ConversationResponse>({
        prompt: message,
        options,
        signal: controller.signal,
        onDownloadProgress: ({ event }) => {
          const xhr = event.target
          const { responseText } = xhr
          // Always process the final line
          const lastIndex = responseText.lastIndexOf(
            "\n",
            responseText.length - 2
          )
          let chunk = responseText
          if (lastIndex !== -1) chunk = responseText.substring(lastIndex)
          try {
            const data = JSON.parse(chunk)
            updateChat(+uuid, index, {
              dateTime: new Date().toLocaleString(),
              text: lastText + (data.text ?? ""),
              inversion: false,
              error: false,
              loading: true,
              conversationOptions: {
                conversationId: data.conversationId,
                parentMessageId: data.id,
              },
              requestOptions: { prompt: message, options: { ...options } },
            })

            if (
              openLongReply &&
              data.detail.choices[0].finish_reason === "length"
            ) {
              options.parentMessageId = data.id
              lastText = data.text
              message = ""
              return fetchChatAPIOnce()
            }
          } catch (error) {
            //
          }
        },
      })
      updateChatSome(+uuid, index, { loading: false })
    }
    await fetchChatAPIOnce()
  } catch (error: any) {
    if (error.message === "canceled") {
      updateChatSome(+uuid, index, {
        loading: false,
      })
      return
    }

    const errorMessage = error?.message ?? t("common.wrong")

    updateChat(+uuid, index, {
      dateTime: new Date().toLocaleString(),
      text: errorMessage,
      inversion: false,
      error: true,
      loading: false,
      conversationOptions: null,
      requestOptions: { prompt: message, options: { ...options } },
    })
  } finally {
    loading.value = false
  }
}

function handleExport() {
  if (loading.value) return

  const d = dialog.warning({ // dialog.warning 是 UI 组件库提供的弹窗方法
    title: t("chat.exportImage"), // t(...) 是国际化函数，根据当前语言显示对应的文本
    content: t("chat.exportImageConfirm"),
    positiveText: t("common.yes"),
    negativeText: t("common.no"),
    onPositiveClick: async () => {
      try {
        d.loading = true
        const ele = document.getElementById("image-wrapper") // image-wrapper 是 HTML 中聊天记录区域的容器 ID
        const canvas = await html2canvas(ele as HTMLDivElement, { // html2canvas 是一个第三方库，作用是将网页上的 DOM 元素 “截图” 并转换为 Canvas 对象
          useCORS: true, // 解决跨域图片的加载问题（如果聊天中有来自其他域名的图片，不开启可能导致图片无法显示在导出的图片中）
        })
        const imgUrl = canvas.toDataURL("image/png") // 将Canvas转换为图片URL
        const tempLink = document.createElement("a") // 创建链接
        tempLink.style.display = "none" // 隐藏链接
        tempLink.href = imgUrl // 将图片url赋值给链接
        tempLink.setAttribute("download", "chat-shot.png") // 下载的文件名
        if (typeof tempLink.download === "undefined")
          tempLink.setAttribute("target", "_blank")

        document.body.appendChild(tempLink) // 将链接添加到页面
        tempLink.click()
        document.body.removeChild(tempLink) // 删除链接
        window.URL.revokeObjectURL(imgUrl) // 释放内存
        d.loading = false
        ms.success(t("chat.exportSuccess"))
        Promise.resolve()
      } catch (error: any) {
        ms.error(t("chat.exportFailed"))
      } finally {
        d.loading = false
      }
    },
  })
}

function handleDelete(index: number) { // 删除单条信息
  if (loading.value) return

  dialog.warning({
    title: t("chat.deleteMessage"),
    content: t("chat.deleteMessageConfirm"),
    positiveText: t("common.yes"),
    negativeText: t("common.no"),
    onPositiveClick: () => {
      chatStore.deleteChatByUuid(+uuid, index)
    },
  })
}

function handleClear() { // 清空整个聊天
  if (loading.value) return

  dialog.warning({
    title: t("chat.clearChat"),
    content: t("chat.clearChatConfirm"),
    positiveText: t("common.yes"),
    negativeText: t("common.no"),
    onPositiveClick: () => {
      chatStore.clearChatByUuid(+uuid)
    },
  })
}

function handleEnter(event: KeyboardEvent) { // 键盘发送消息
  if (!isMobile.value) { // 非移动端
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault() // 阻止默认键盘操作（换行）
      handleSubmit()
    }
  } else {
    if (event.key === "Enter" && event.ctrlKey) { // 移动端按ctrl+enter发送
      event.preventDefault()
      handleSubmit()
    }
  }
}

function handleStop() { // 停止 AI 生成回复
  if (loading.value) {
    homeStore.setMyData({ act: "abort" })
    controller.abort() // controller 是之前创建的 AbortController 实例
    loading.value = false
  }
}

// 处理AI建议点击
function handleSuggestionClick(suggestion: string) {
  prompt.value = suggestion
  // 可以选择立即发送或者让用户编辑
  // handleSubmit() // 如果要立即发送，取消注释这行
}

// 处理快速功能点击
function handleFeatureClick(feature: any) {
  switch (feature.action) {
    case 'writing':
      prompt.value = '请帮我写一篇关于教育的文章，包含以下要点：'
      break
    case 'analysis':
      prompt.value = '请帮我分析以下数据：'
      break
    case 'learning':
      prompt.value = '我想学习关于以下主题的知识：'
      break
    default:
      prompt.value = `请帮我处理关于${feature.title}的任务`
  }
  
  // 聚焦到输入框
  if (mainInputRef.value) {
    mainInputRef.value.focus()
  }
}

// 切换侧边栏
function handleToggleSidebar() {
  appStore.setSiderCollapsed(!collapsed.value)
}

// 可优化部分
// 搜索选项计算，这里使用value作为索引项，所以当出现重复value时渲染异常(多项同时出现选中效果)
// 理想状态下其实应该是key作为索引项,但官方的renderOption会出现问题，所以就需要value反renderLabel实现
const searchOptions = computed(() => {
  if (prompt.value.startsWith("/")) {
    const abc = promptTemplate.value
      .filter((item: { key: string }) =>
        item.key.toLowerCase().includes(prompt.value.substring(1).toLowerCase())
      )
			.map((obj) => {
				return {
					label: obj.value,               // 显示给用户的文本
					value: `cmd-${obj.key}`,        // 生成唯一值（如"cmd-/help"）
					original: obj                   // 保留原始对象，方便后续使用
				};
			});
    mlog("搜索选项", abc)
    return abc
  } else if (prompt.value == "@") {
    const abc = gptsUlistStore.myData.slice(0, 10).map((v: gptsType) => { // gptsUlistStore.myData 是用户列表  只取前十
      return {
        label: v.info,
        gpts: v,
        value: v.gid,
      }
    })
    return abc
  } else {
    return []
  }
})


const placeholder = computed(() => {
  if (isMobile.value) return t("chat.placeholderMobile")
  return t("chat.placeholder")
})

const buttonDisabled = computed(() => { // 控制发送按钮是否禁用
  return loading.value || !prompt.value || prompt.value.trim() === ""
})

const footerClass = computed(() => { // 根据是否为移动端设置底部边距
  let classes = ["p-4"]
  if (isMobile.value)
    classes = ["sticky", "left-0", "bottom-0", "right-0", "p-2", "pr-3"] //, 'overflow-hidden'
  return classes
})

onMounted(() => {
	// 原有逻辑：滚动到底部 + 输入框聚焦
	scrollToBottom()
	if (inputRef.value && !isMobile.value) inputRef.value?.focus()

	/*// 新增：初始化编辑器
	const container = document.getElementById('mini-ide-container');
	if (container) {
		// 创建Monaco编辑器实例（指定类型，避免TS报错）
		editor.value = monaco.editor.create(container, {
			value: '// Java代码会自动显示在这里\npublic class Example {\n    public static void main(String[] args) {\n        System.out.println("Hello, World!");\n    }\n}',
			language: 'java',
			minimap: { enabled: false },
			fontSize: 12,
			scrollBeyondLastLine: false
		});
	}*/
});

onUnmounted(() => {
  if (loading.value) controller.abort()
  homeStore.setMyData({ isLoader: false })
})

const local = computed(() => homeStore.myData.local)
watch(
  () => homeStore.myData.act, // 监听全局状态中 homeStore.myData.act 的变化，根据不同的 act 值执行对应的操作
  (n) => {
    if (n == "draw") scrollToBottom()
    if (n == "scrollToBottom") scrollToBottom()
    if (n == "scrollToBottomIfAtBottom") scrollToBottomIfAtBottom()
    if (n == "gpt.submit" || n == "gpt.resubmit") {
      loading.value = true
    }
    if (n == "stopLoading") {
      loading.value = false
    }
  }
)
const st = ref({ inputme: true })

watch(
  () => loading.value,  // 监听本地的 loading 状态
  (n) => homeStore.setMyData({ isLoader: n }) // 同步到全局
)

const ychat = computed(() => {
  let text = prompt.value
  if (loading.value) text = ""
  else {
    scrollToBottomIfAtBottom()
  }
  return { text, dateTime: t("chat.preview") } as Chat.Chat
})


/*
//编辑器
const editor = ref<IStandaloneCodeEditor | null>(null);
const codeResult = ref('');  // 代码运行结果
const codeError = ref('');  // 代码错误信息


// 2. 模拟运行代码（实际项目中会调用后端沙箱，这里先模拟）
const runCode = () => {
	codeResult.value = '';
	codeError.value = '';
	try {
		const code = editor.value?.getValue() || ''; // 处理editor为null的情况
		if (code.includes('System.out.println')) {
			const match = code.match(/System\.out\.println\("(.*?)"\)/);
			if (match) {
				codeResult.value = `输出: ${match[1]}`;
			} else {
				codeResult.value = '代码运行成功，但未找到输出内容';
			}
		} else {
			codeResult.value = '代码运行成功（无输出）';
		}
	} catch (err) {
		// 断言err为Error类型
		codeError.value = `错误: ${(err as Error).message}`;
	}
};

// 3. 监听用户输入，如果包含"java"关键词，自动更新编辑器代码
watch(prompt, (newVal) => {
	// 新增：判断newVal不为空再处理
	if (newVal && newVal.toLowerCase().includes('java')) {
		const javaCode = `// 自动生成的Java示例\npublic class Example {\n    public static void main(String[] args) {\n        // 请根据问题修改代码\n        System.out.println("处理Java问题：${newVal}");\n    }\n}`;
		// 使用可选链（?.）避免editor.value为null时报错
		editor.value?.setValue(javaCode);
	}
});
*/

</script>

<template>


  <div class="flex flex-col w-full h-full chat-content relative" 
       :class="[isMobile ? '' : 'chat-content-noMobile']">
    
    <!-- 背景渐变 -->
    <div class="absolute inset-0 bg-gradient-to-br from-blue-50/50 via-white to-purple-50/30 
                dark:from-gray-900 dark:via-gray-800 dark:to-blue-900/20"></div>

    <main class="flex-1 overflow-hidden relative z-10">
      <!-- 侧边栏切换按钮 -->
      <div v-if="collapsed" class="fixed top-4 left-4 z-50">
        <button 
          @click="handleToggleSidebar"
          class="sidebar-toggle-btn card-glass rounded-xl p-3 
                 hover:shadow-soft-lg hover:scale-105 active:scale-95
                 transition-all duration-300 flex items-center justify-center
                 text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                  d="M4 6h16M4 12h16M4 18h16"/>
          </svg>
        </button>
      </div>

      <div id="scrollRef" ref="scrollRef" class="h-full overflow-hidden overflow-y-auto">

        <div id="image-wrapper" class="w-full max-w-[1100px] m-auto animate-fade-in"
          :class="[isMobile ? 'p-2' : 'p-4']">
          <template v-if="!dataSources.length">
            <div v-if="homeStore.myData.session.notify" v-html="homeStore.myData.session.notify"
              class="text-neutral-300 mt-4">

            </div>

            <div class="gpts-box" v-else>
              <div v-if="local !== 'draw'" class="flex flex-col items-center justify-center min-h-[calc(100vh-120px)] px-4">
                <!-- 欢迎语 -->
                <div class="text-center mb-8 animate-fade-in">
                  <h1 class="text-3xl font-semibold text-gray-800 dark:text-gray-200 mb-8 whitespace-nowrap">
                    有什么我可以帮您的吗？
                  </h1>
                </div>

                <!-- 主要聊天卡片 -->
                <div class="card-glass rounded-3xl p-6 w-full max-w-2xl mx-auto animate-scale-in shadow-soft-lg">
                  <!-- AI建议标签 -->
                  <div class="flex flex-wrap gap-2 mb-6">
                    <button v-for="suggestion in aiSuggestions" 
                            :key="suggestion.id"
                            @click="handleSuggestionClick(suggestion.text)"
                            class="suggestion-tag px-4 py-2 rounded-full text-sm font-medium
                                   transition-all duration-300 hover:scale-105"
                            :class="suggestion.featured ? 'bg-gradient-to-r from-blue-500 to-purple-600 text-white shadow-md' : 
                                   'bg-gray-100 hover:bg-gray-200 dark:bg-gray-700 dark:hover:bg-gray-600 text-gray-700 dark:text-gray-300'">
                      {{ suggestion.text }}
                    </button>
                  </div>

                  <!-- 主输入区域 -->
                  <div class="relative">
                    <NInput
                      ref="mainInputRef"
                      v-model:value="prompt"
                      type="textarea"
                      :placeholder="'Ask, write or search for anything...'"
                      :autosize="{ minRows: 1, maxRows: 4 }"
                      @keypress="handleEnter"
                      class="main-input rounded-2xl border-0 shadow-inner text-base
                             placeholder-gray-400 dark:placeholder-gray-500
                             bg-gray-50 dark:bg-gray-800/50 
                             focus:bg-white dark:focus:bg-gray-700/50
                             transition-all duration-300"
                      style="padding: 16px 60px 16px 20px; font-size: 16px;"
                    />
                    
                    <!-- 发送按钮 -->
                    <button 
                      @click="handleSubmit"
                      :disabled="buttonDisabled || !prompt.trim()"
                      class="absolute right-3 top-1/2 transform -translate-y-1/2
                             w-10 h-10 rounded-full bg-gradient-to-r from-blue-500 to-purple-600
                             flex items-center justify-center text-white shadow-lg
                             hover:shadow-xl hover:scale-110 active:scale-95
                             disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:scale-100
                             transition-all duration-300">
                      <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10.894 2.553a1 1 0 00-1.788 0l-7 14a1 1 0 001.169 1.409l5-1.429A1 1 0 009 15.571V11a1 1 0 112 0v4.571a1 1 0 00.725.962l5 1.429a1 1 0 001.17-1.409l-7-14z"/>
                      </svg>
                    </button>
                  </div>

                  <!-- 底部提示 -->
                  <div class="mt-4 text-center">
                    <p class="text-xs text-gray-500 dark:text-gray-400">
                      Press Enter to send, Shift + Enter for new line
                    </p>
                  </div>
                </div>

                <!-- 快速功能区域 -->
                <div class="mt-8 grid grid-cols-1 md:grid-cols-3 gap-4 w-full max-w-4xl mx-auto">
                  <div v-for="feature in quickFeatures" 
                       :key="feature.id"
                       @click="handleFeatureClick(feature)"
                       class="feature-card card-glass rounded-2xl p-4 cursor-pointer
                              hover:shadow-soft-lg hover:-translate-y-1 transition-all duration-300
                              animate-fade-in"
                       :style="{ animationDelay: `${feature.id * 100}ms` }">
                    <div class="flex items-center space-x-3">
                      <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-blue-100 to-purple-100 
                                  dark:from-blue-900/50 dark:to-purple-900/50
                                  flex items-center justify-center">
                        <span class="text-xl">{{ feature.icon }}</span>
                      </div>
                      <div>
                        <h3 class="font-medium text-gray-800 dark:text-gray-200">{{ feature.title }}</h3>
                        <p class="text-sm text-gray-500 dark:text-gray-400">{{ feature.description }}</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

          </template>

          <template v-else>
            <div class="message-list space-y-6 pb-4">
              <TransitionGroup name="message" appear>
                <div v-for="(item, index) of dataSources" 
                     :key="`msg-${index}`" 
                     class="message-container"
                     :class="item.inversion ? 'flex justify-end' : 'flex justify-start'">
                  <Message 
                    :date-time="item.dateTime" 
                    :text="item.text"
                    :inversion="item.inversion" 
                    :error="item.error" 
                    :loading="item.loading"
                    @regenerate="onRegenerate(index)" 
                    @delete="handleDelete(index)" 
                    :chat="item" 
                    :index="index" 
                    class="animate-slide-up"
                    :style="{ animationDelay: `${index * 50}ms` }"
                  />
                </div>
                
                <div v-if="ychat.text && !homeStore.myData.session.isCloseMdPreview" 
                     :key="`typing-${dataSources.length}`"
                     class="message-container flex justify-end">
                  <Message 
                    :inversion="true" 
                    :date-time="$t('mj.typing')" 
                    :chat="ychat" 
                    :text="ychat.text"
                    :index="dataSources.length" 
                    class="animate-slide-up typing-indicator"
                  />
                </div>
              </TransitionGroup>
              
              <div class="sticky bottom-0 left-0 flex justify-center pt-4">
                <Transition name="fade">
                  <button v-if="loading" 
                          @click="handleStop"
                          class="btn-glass rounded-2xl px-6 py-3 text-orange-600 dark:text-orange-400 
                                 font-medium shadow-soft hover:shadow-soft-lg transition-all duration-300
                                 flex items-center gap-2 animate-pulse-glow">
                    <SvgIcon icon="ri:stop-circle-line" class="w-5 h-5" />
                  {{ t('common.stopResponding') }}
                  </button>
                </Transition>
              </div>
            </div>
          </template>
        </div>
      </div>
    </main>

			<footer :class="footerClass" class="footer-content relative z-20" v-if="local !== 'draw' && dataSources.length > 0">
		<!-- 玻璃拟态输入区域 -->
		<div class="input-glass rounded-t-4xl border-t border-white/20 dark:border-white/10 shadow-soft-lg">
			<div class="w-full max-w-[1100px] m-auto p-4">
				<aiGptInput @handle-clear="handleClear" @export="handleExport"
										v-if="['gpt-4o-mini', 'gpt-3.5-turbo-16k'].indexOf(gptConfigStore.myData.model) > -1 || st.inputme"
										v-model:modelValue="prompt" :disabled="buttonDisabled" :searchOptions="searchOptions" 
										class="animate-slide-up" />
				<div class="flex items-end space-x-3 animate-slide-up" v-else>
					<div class="flex-1">
					<NAutoComplete v-model:value="prompt" :options="searchOptions">
						<template #default="{ handleInput, handleBlur, handleFocus }">
								<NInput ref="inputRef" 
												v-model:value="prompt" 
												type="textarea" 
												:placeholder="placeholder"
												:autosize="{ minRows: 1, maxRows: isMobile ? 4 : 8 }" 
												@input="handleInput" 
												@focus="handleFocus"
												@blur="handleBlur" 
												@keypress="handleEnter"
												class="input-glass rounded-2xl border-0 shadow-inner-glow 
															 resize-none transition-all duration-300
															 focus:shadow-glow focus:scale-[1.02]" 
												style="background: rgba(255, 255, 255, 0.8); 
															 backdrop-filter: blur(10px);" />
						</template>
					</NAutoComplete>
					</div>
					<button :disabled="buttonDisabled" 
									@click="handleSubmit"
									class="btn-glass rounded-2xl p-4 bg-gradient-primary text-white shadow-glow
												 hover:shadow-glow-lg hover:scale-105 active:scale-95
												 disabled:opacity-50 disabled:cursor-not-allowed
												 transition-all duration-300 flex items-center justify-center
												 min-w-[56px] h-[56px] animate-bounce-soft">
						<SvgIcon icon="ri:send-plane-fill" class="w-6 h-6" />
					</button>
				</div>
				</div>
			</div>
		</footer>
	</div>

	<drawListVue />
	<aiGPT @finished="loading = false" />
	<AiSiderInput v-if="isMobile" :button-disabled="false" />

</template>

<style scoped>
.new-chat-header {
  width: 100%;
  padding: 0 24px;
  height: 70px;
  line-height: 70px;
  max-width: 300px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-size: 16px;
  font-weight: 500;
}

/* 消息转场动画 */
.message-enter-active,
.message-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.message-enter-from {
  opacity: 0;
  transform: translateY(20px) scale(0.95);
}

.message-leave-to {
  opacity: 0;
  transform: translateY(-20px) scale(0.95);
}

.message-move {
  transition: transform 0.3s ease;
}

/* 淡入淡出动画 */
.fade-enter-active,
.fade-leave-active {
  transition: all 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(10px);
}

/* 输入框聚焦效果 */
.n-input.n-input--focus {
  box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2), 
              0 0 20px rgba(59, 130, 246, 0.1) !important;
}

/* 打字指示器动画 */
.typing-indicator {
  position: relative;
}

.typing-indicator::after {
  content: '';
  position: absolute;
  bottom: 8px;
  right: 12px;
  width: 4px;
  height: 20px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  animation: blink 1.2s infinite;
  border-radius: 2px;
}

/* 消息容器悬停效果 */
.message-container:hover .message-bubble {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

/* 发送按钮特殊效果 */
.btn-glass:hover {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  transform: scale(1.05) rotate(5deg);
}

.btn-glass:active {
  transform: scale(0.95) rotate(0deg);
}

/* 响应式调整 */
@media (max-width: 768px) {
  .message-list {
    padding: 0 8px;
  }
  
  .card-glass {
    padding: 24px 16px;
    margin: 0 8px;
  }
  
  .input-glass {
    border-radius: 24px 24px 0 0;
  }
}

/* 滚动条美化 */
#scrollRef::-webkit-scrollbar {
  width: 6px;
}

#scrollRef::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 3px;
}

#scrollRef::-webkit-scrollbar-thumb {
  background: rgba(102, 126, 234, 0.3);
  border-radius: 3px;
  backdrop-filter: blur(10px);
}

#scrollRef::-webkit-scrollbar-thumb:hover {
  background: rgba(102, 126, 234, 0.5);
}

/* 深色模式的滚动条 */
.dark #scrollRef::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.2);
}

.dark #scrollRef::-webkit-scrollbar-thumb {
  background: rgba(102, 126, 234, 0.4);
}

.dark #scrollRef::-webkit-scrollbar-thumb:hover {
  background: rgba(102, 126, 234, 0.6);
}

/* 建议标签样式 */
.suggestion-tag {
  border: 1px solid transparent;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

.suggestion-tag:hover {
  border-color: rgba(59, 130, 246, 0.3);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* 主输入框样式 */
.main-input {
  border: 2px solid transparent;
  backdrop-filter: blur(15px);
  -webkit-backdrop-filter: blur(15px);
}

.main-input:focus {
  border-color: rgba(59, 130, 246, 0.3);
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
}

/* 功能卡片样式 */
.feature-card {
  border: 1px solid rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(15px);
  -webkit-backdrop-filter: blur(15px);
}

.feature-card:hover {
  border-color: rgba(59, 130, 246, 0.3);
  background: rgba(255, 255, 255, 0.8);
}

.dark .feature-card:hover {
  background: rgba(31, 41, 55, 0.8);
  border-color: rgba(59, 130, 246, 0.4);
}

/* 圆形发送按钮样式 */
.main-input + button {
  background: linear-gradient(135deg, #3b82f6, #8b5cf6);
  box-shadow: 0 4px 15px rgba(59, 130, 246, 0.4);
}

.main-input + button:hover {
  background: linear-gradient(135deg, #2563eb, #7c3aed);
  box-shadow: 0 6px 20px rgba(59, 130, 246, 0.6);
}

.main-input + button:disabled {
  background: #9ca3af;
  box-shadow: none;
}

/* 新的动画效果 */
@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-slide-in-up {
  animation: slideInUp 0.6s ease-out;
}

/* 深色模式下的建议标签 */
.dark .suggestion-tag:hover {
  border-color: rgba(96, 165, 250, 0.4);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

/* 深色模式下的主输入框 */
.dark .main-input:focus {
  border-color: rgba(96, 165, 250, 0.5);
  box-shadow: 0 0 0 4px rgba(96, 165, 250, 0.2);
}

/* 侧边栏切换按钮样式 */
.sidebar-toggle-btn {
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.sidebar-toggle-btn:hover {
  background: rgba(255, 255, 255, 0.9);
  border-color: rgba(59, 130, 246, 0.3);
  box-shadow: 0 6px 20px rgba(59, 130, 246, 0.2);
}

.dark .sidebar-toggle-btn {
  background: rgba(31, 41, 55, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.dark .sidebar-toggle-btn:hover {
  background: rgba(31, 41, 55, 0.95);
  border-color: rgba(96, 165, 250, 0.4);
  box-shadow: 0 6px 20px rgba(96, 165, 250, 0.3);
}

/* 按钮的安全区域适配 */
@media (max-width: 768px) {
  .fixed .sidebar-toggle-btn {
    position: fixed;
    top: max(1rem, env(safe-area-inset-top, 16px)) !important;
    left: max(1rem, env(safe-area-inset-left, 16px)) !important;
  }
}
</style>
