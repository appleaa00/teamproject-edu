<script setup lang="ts">
import { ref, computed, watch } from "vue";
import { useBasicLayout } from "@/hooks/useBasicLayout";
import { t } from "@/locales";
import {
  NInput,
  NButton,
  useMessage,
  NImage,
  NTooltip,
  NAutoComplete,
  NTag,
  NPopover,
  NModal,
  NDropdown,
} from "naive-ui";

import { SvgIcon, PromptStore } from "@/components/common";
import {
  canVisionModel,
  mlog,
  upFile,
  getFileFromClipboard,
  isFileMp3,
  countTokens,
  checkDisableGpt4,
  Recognition,
  chatSetting,
  getFileTypeInfo,
  isSupportedDocument,
} from "@/api";
import { gptConfigStore, homeStore, useChatStore } from "@/store";
import { AutoCompleteOptions } from "naive-ui/es/auto-complete/src/interface";
import { RenderLabel } from "naive-ui/es/_internal/select-menu/src/interface";
import { useRoute } from "vue-router";
import aiModel from "@/views/mj/aiModel.vue";
import AiMic from "./aiMic.vue";
import { useIconRender } from "@/hooks/useIconRender";


const { iconRender } = useIconRender();

const route = useRoute();
const chatStore = useChatStore();
const emit = defineEmits([
  "update:modelValue",
  "update:chatType",
  "export",
  "handleClear",
]);
const props = defineProps<{
  modelValue: string;
  disabled?: boolean;
  searchOptions?: AutoCompleteOptions;
  renderOption?: RenderLabel;
}>();
// 文件对象接口定义
interface UploadedFile {
  url: string;
  fileName: string;
  originalName: string;
  ossId: number;
  fileSize: number;
  fileType: string;
  icon: string;
  extension: string;
  base64?: string; // 新增：图片的Base64编码
}

const fsRef = ref();
const st = ref<{
  fileBase64: string[];
  uploadedFiles: UploadedFile[];
  isLoad: number;
  isShow: boolean;
  showMic: boolean;
  micStart: boolean;
  chatType: boolean;
}>({
  fileBase64: [],
  uploadedFiles: [],
  isLoad: 0,
  isShow: false,
  showMic: false,
  micStart: false,
  chatType: false,
});
const { isMobile } = useBasicLayout();
const placeholder = computed(() => {
  if (isMobile.value) return t("chat.placeholderMobile");
  return t("chat.placeholder"); //可输入说点什么，也可贴截图或拖拽文件
});

const { uuid } = route.params as { uuid: string };
const uuid1 = chatStore.active;
const chatSet = new chatSetting(uuid1 == null ? 1002 : uuid1);
const nGptStore = ref(chatSet.getGptConfig());
const dataSources = computed(() => chatStore.getChatByUuid(+uuid));

watch(
  () => gptConfigStore.myData,
  () => (nGptStore.value = chatSet.getGptConfig()),
  { deep: true }
);
watch(
  () => homeStore.myData.act,
  (n) => n == "saveChat" && (nGptStore.value = chatSet.getGptConfig()),
  { deep: true }
);
const handleSubmit = () => {
  if (mvalue.value == "") return;
  if (checkDisableGpt4(gptConfigStore.myData.model)) {
    ms.error(t("mj.disableGpt4"));
    return false;
  }
  if (homeStore.myData.isLoader) {
    return;
  }
  let obj = {
    prompt: mvalue.value,
    fileBase64: st.value.fileBase64,
    uploadedFiles: st.value.uploadedFiles, // 添加新的文件列表
    chatType: st.value.chatType ? 1 : 0,
    appId: gptConfigStore.myData.gpts ? gptConfigStore.myData.gpts.id : "",
  };
  homeStore.setMyData({ act: "gpt.submit", actData: obj });
  mvalue.value = "";
  st.value.fileBase64 = [];
  st.value.uploadedFiles = []; // 清理新的文件列表
  return false;
};
const ms = useMessage();
const mvalue = computed({
  get() {
    return props.modelValue;
  },
  set(value) {
    emit("update:modelValue", value);
  },
});



const myToken = ref({ remain: 0, modelTokens: "4k" });
const funt = async () => {
  const d = await countTokens(
    dataSources.value,
    mvalue.value,
    chatStore.active ?? 1002
  );
  myToken.value = d;
  return d;
};
watch(() => mvalue.value, funt);
watch(() => dataSources.value, funt);
watch(() => gptConfigStore.myData, funt, { deep: true });
watch(() => homeStore.myData.isLoader, funt, { deep: true });
funt();

const upFileHandler = (file: any) => { // 文件上传入口
  console.log('🔍 开始文件上传，文件信息:', {
    name: file.name,
    size: file.size,
    type: file.type,
    上传限制: homeStore.myData.session.uploadImgSize + 'MB'
  });
  
  // 处理音频文件（语音转文字）
  if (isFileMp3(file.name)) {
    mlog("mp3", file);
    // 暂时禁用语音识别功能，因为没有配置有效的API Key
    ms.error("语音识别功能暂未配置，请联系管理员启用此功能");
    return;
  }
  
  // 处理所有类型的文件：使用通用文件上传系统
  console.log('📤 开始调用upFile函数');
  ms.info(t("mj.uploading"));
  st.value.isLoad = 1;
  
  upFile(file)
    .then((uploadResult) => {
      console.log('✅ 文件上传成功，结果:', uploadResult);
      fsRef.value.value = "";
      st.value.isLoad = 0;
      
      // 检查是否已经上传过相同的文件
      const existingFile = st.value.uploadedFiles.find(f => f.url === uploadResult.url);
      if (existingFile) {
        ms.error(t("mj.noReUpload")); //'不能重复上传'
        return;
      }
      
      // 添加到文件列表
      const fileObj: UploadedFile = {
        url: uploadResult.url,
        fileName: uploadResult.fileName,
        originalName: uploadResult.originalName,
        ossId: uploadResult.ossId,
        fileSize: uploadResult.fileSize,
        fileType: uploadResult.fileType,
        icon: uploadResult.icon,
        extension: uploadResult.extension
      };
      
      st.value.uploadedFiles.push(fileObj);
      
      // 🚨 图片特殊处理：转换为Base64以确保AI能访问
      if (fileObj.fileType === 'image') {
        console.log('🔄 开始将图片转换为Base64编码...');
        
        // 将原始文件转换为Base64
        const reader = new FileReader();
        reader.onload = function(e) {
          const base64String = e.target?.result as string;
          console.log('✅ 图片Base64转换成功，长度:', base64String.length);
          
          // 添加到原来的图片数组（Base64格式）
          st.value.fileBase64.push(base64String);
          
          // 同时保存Base64到uploadedFiles中
          fileObj.base64 = base64String;
          
          console.log('📋 Base64前缀:', base64String.substring(0, 50) + '...');
        };
        reader.onerror = function() {
          console.error('❌ Base64转换失败，使用URL作为备选');
          st.value.fileBase64.push(uploadResult.url);
        };
        reader.readAsDataURL(file);
      }
      
      ms.success(t("mj.uploadSuccess"));
    })
    .catch((e) => {
      console.error('❌ 文件上传失败，错误信息:', e);
      console.error('❌ 错误详情:', {
        error: e,
        fileName: file.name,
        fileSize: file.size,
        fileType: file.type
      });
      st.value.isLoad = 0;
      ms.error(t("mj.uploadFail") + ": " + e);
    });
};

function handleEnter(event: KeyboardEvent) {
  if (!isMobile.value) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      handleSubmit();
    }
  } else {
    if (event.key === "Enter" && event.ctrlKey) {
      event.preventDefault();
      handleSubmit();
    }
  }
}

const acceptData = computed(() => {
  // 支持更多文件类型
  return "*/*"; // 支持所有文件类型
  // 如果需要限制，可以使用：
  // return "image/*,audio/*,video/*,.pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.txt,.zip,.rar,.7z";
});

const drop = (e: DragEvent) => {
  e.preventDefault();
  e.stopPropagation();
  if (!e.dataTransfer || e.dataTransfer.files.length == 0) return;
  const files = e.dataTransfer.files;
  upFileHandler(files[0]);
  //mlog('drop', files);
};
const paste = (e: ClipboardEvent) => {
let rz = getFileFromClipboard(e);
  if (rz.length > 0) upFileHandler(rz[0]);
};

// 删除文件
const removeFile = (index: number) => {
  const removedFile = st.value.uploadedFiles[index];
  
  // 从文件列表中移除
  st.value.uploadedFiles.splice(index, 1);
  
  // 如果是图片，也从图片数组中移除
  if (removedFile.fileType === 'image') {
    const imgIndex = st.value.fileBase64.indexOf(removedFile.url);
    if (imgIndex > -1) {
      st.value.fileBase64.splice(imgIndex, 1);
    }
  }
  
  ms.success("文件已移除");
};

// 处理文件选择
const selectFile = (event: Event) => {
  const target = event.target as HTMLInputElement;
  if (target.files && target.files.length > 0) {
    upFileHandler(target.files[0]);
  }
};

const sendMic = (e: any) => {
  mlog("sendMic", e);
  st.value.showMic = false;
  let du = "whisper.wav"; // (e.stat && e.stat.duration)?(e.stat.duration.toFixed(2)+'s'):'whisper.wav';
  const file = new File([e.blob], du, { type: "audio/wav" });
  homeStore.setMyData({
    act: "gpt.whisper",
    actData: { file, prompt: "whisper", duration: e.stat?.duration },
  });
};

//语音识别ASR
const goASR = () => {
  console.log("触发语音识别");

  const olod = mvalue.value;
  const rec = new Recognition();
  console.log("🚀 ~ goASR ~ rec:", rec);
  let rz = "";
  rec
    .setListener((r: string) => {
      //mlog('result ', r  );
      rz = r;
      mvalue.value = r;
      console.log("mvalue.value1111", mvalue.value);
      st.value.micStart = true;
    })
    .setOnEnd(() => {
      //mlog('rec end');
      mvalue.value = olod + rz;
      console.log("mvalue.value", mvalue.value);

      ms.info(t("mj.micRecEnd"));
      st.value.micStart = false;
    })
    .setOpt({
      timeOut: 3000,
      onStart: () => {
        ms.info(t("mj.micRec"));
        st.value.micStart = true;
      },
    })
    .start();
};

const drOption = [
  {
    label: t("mj.micWhisper"),
    key: "whisper",
    icon: iconRender({ icon: "ri:openai-fill" }),
  },
  {
    label: t("mj.micAsr"),
    icon: iconRender({ icon: "ri:chrome-line" }),
    key: "asr",
  },
];
const handleSelectASR = (key: string | number) => {
  if (key == "asr") goASR();
  if (key == "whisper") st.value.showMic = true;
};
/**
 * 校验字符串的大小
 * @param inputStr 输入的字符
 * @param maxLength 字符串长度
 */
const truncateText = (inputStr: any, maxLength = 20) => {
  // 处理空值情况
  if (!inputStr) return "";
  // 类型安全校验
  const str = String(inputStr);
  // 判断并截断
  return str.length > maxLength ? `${str.slice(0, maxLength)}...` : str;
};

const show = ref(false);
function handleExport() {
  emit("export");
}
function handleClear() {
  emit("handleClear");
}


</script>

<template>
  <div v-if="st.showMic" class="myinputs flex justify-center items-center">
    <AiMic @cancel="st.showMic = false" @send="sendMic" />
  </div>
  <div v-else>
    <!-- 通用文件显示区域 -->
    <div
      class="flex items-start justify-start pb-2 flex-wrap"
      v-if="st.uploadedFiles.length > 0"
      style="margin: 0 40px"
    >
      <div
        class="mr-2 mt-1 relative group"
        v-for="(file, index) in st.uploadedFiles"
        :key="file.ossId"
      >
        <!-- 图片文件显示 -->
        <div v-if="file.fileType === 'image'" class="w-[60px] h-[60px] rounded-sm bg-slate-50 relative">
          <NImage :src="file.url" object-fit="cover" class="w-full h-full rounded-sm">
            <template #placeholder>
              <div class="w-full h-full flex items-center justify-center text-neutral-500">
                <SvgIcon :icon="file.icon" />
              </div>
            </template>
          </NImage>
        </div>
        
        <!-- 非图片文件显示 -->
        <div v-else class="flex items-center p-2 bg-slate-50 dark:bg-slate-700 rounded-sm min-w-[200px] max-w-[280px]">
          <div class="flex-shrink-0 mr-2">
            <SvgIcon 
              :icon="file.icon" 
              class="text-2xl"
              :style="{ color: getFileTypeInfo(file.originalName, file.fileSize).color }"
            />
          </div>
          <div class="flex-1 min-w-0">
            <div class="flex items-center gap-1">
              <span class="text-sm font-medium truncate dark:text-white" :title="file.originalName">
                {{ file.originalName }}
              </span>
              <!-- 支持内容解析的标识 -->
              <span 
                v-if="isSupportedDocument(file.extension)" 
                class="text-xs bg-green-100 text-green-700 px-1 py-0.5 rounded flex-shrink-0"
                title="支持内容解析"
              >
                📄AI
              </span>
            </div>
            <div class="text-xs text-gray-500 dark:text-gray-400">
              {{ getFileTypeInfo(file.originalName, file.fileSize).size }} • {{ file.extension.toUpperCase() }}
            </div>
          </div>
          <div class="flex-shrink-0 ml-2">
            <a :href="file.url" target="_blank" class="text-blue-500 hover:text-blue-700 mr-1">
              <SvgIcon icon="mdi:download" class="text-sm" />
            </a>
          </div>
        </div>
        
        <!-- 删除按钮 -->
        <SvgIcon
          icon="mdi:close"
          class="hidden group-hover:block absolute -top-1 -right-1 rounded-full bg-red-500 text-white cursor-pointer text-sm p-1"
          @click="removeFile(index)"
        />
      </div>
    </div>

    <!-- 原有图片显示区域（为了兼容性保留，但现在主要使用上面的通用显示） -->
    <div
      class="flex items-base justify-start pb-1 flex-wrap-reverse"
      v-if="st.fileBase64.length > 0 && st.uploadedFiles.length === 0"
      style="margin: 0 40px"
    >
      <div
        class="w-[60px] h-[60px] rounded-sm bg-slate-50 mr-1 mt-1 text-red-300 relative group"
        v-for="(v, ii) in st.fileBase64"
      >
        <NImage :src="v" object-fit="cover" class="w-full h-full">
          <template #placeholder>
            <a
              class="w-full h-full flex items-center justify-center text-neutral-500"
              :href="v"
              target="_blank"
            >
              <SvgIcon icon="mdi:download" />{{ $t("mj.attr1") }} {{ ii + 1 }}
            </a>
          </template>
        </NImage>
        <SvgIcon
          icon="mdi:close"
          class="hidden group-hover:block absolute top-[-5px] right-[-5px] rounded-full bg-red-300 text-white cursor-pointer"
          @click="st.fileBase64.splice(st.fileBase64.indexOf(v), 1)"
        ></SvgIcon>
      </div>
    </div>

    <div
      class="myinputs"
      :class="[!isMobile ? 'chat-footer' : '']"
      @drop="drop"
      @paste="paste"
    >
      <input
        type="file"
        id="fileInput"
        @change="selectFile"
        class="hidden"
        ref="fsRef"
        :accept="acceptData"
      />
      <!-- 手机端 -->
      <div class="w-full relative">
        <div class="absolute bottom-0 right-0 z-1" v-if="isMobile">
          <NPopover trigger="hover">
            <template #trigger>
              <NTag
                type="info"
                round
                size="small"
                style="cursor: pointer"
                :bordered="false"
              >
                <div class="opacity-60 flex">
                  <SvgIcon icon="material-symbols:token-outline" />
                  {{ $t("mj.remain") }}{{ myToken.remain }}/{{
                    myToken.modelTokens
                  }}
                </div>
              </NTag>
            </template>
            <div class="w-[300px]">
              {{ $t("mj.tokenInfo1") }}
              <p class="py-1" v-text="$t('mj.tokenInfo2')"></p>
              <p class="text-right">
                <NButton @click="st.isShow = true" type="info" size="small">{{
                  $t("setting.setting")
                }}</NButton>
              </p>
            </div>
          </NPopover>
        </div>
      </div>
      <NAutoComplete
        v-model:value="mvalue"
        :options="searchOptions"
        :render-label="renderOption"
        :class="[!isMobile ? 'chat-input' : '']"
      >
        <template #default="{ handleInput, handleBlur, handleFocus }">
          <NInput
            ref="inputRef"
            v-model:value="mvalue"
            type="textarea"
            :placeholder="placeholder"
            rows="3"
            :autosize="{ minRows: 3, maxRows: 5 }"
            :theme-overrides="
              !isMobile
                ? {
                    border: '0',
                    borderHover: '#FFF',
                    borderFocus: '#FFF',
                    boxShadowFocus: '#FFF',
                  }
                : {}
            "
            @input="handleInput"
            @focus="handleFocus"
            @blur="handleBlur"
            @keypress="handleEnter"
          >
            <template #prefix v-if="isMobile">
              <div class="relative; w-[22px]">
                <n-tooltip trigger="hover">
                  <template #trigger>
                    <SvgIcon
                      icon="line-md:uploading-loop"
                      class="absolute bottom-[10px] left-[8px] cursor-pointer"
                      v-if="st.isLoad == 1"
                    ></SvgIcon>
                    <SvgIcon
                      icon="ri:attachment-line"
                      class="absolute bottom-[10px] left-[8px] cursor-pointer"
                      @click="fsRef.click()"
                      v-else
                    ></SvgIcon>
                  </template>
                  <div
                    v-if="canVisionModel(gptConfigStore.myData.model)"
                    v-html="$t('mj.upPdf')"
                  ></div>
                  <div v-else v-html="$t('mj.upImg')"></div>
                </n-tooltip>
              </div>

              <n-dropdown
                trigger="hover"
                :options="drOption"
                @select="handleSelectASR"
              >
                <div class="relative; w-[22px]">
                  <div
                    class="absolute bottom-[14px] left-[31px]"
                    v-if="st.micStart"
                  >
                    <span class="relative flex h-3 w-3">
                      <span
                        class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-500 opacity-75"
                      ></span>
                      <span
                        class="relative inline-flex rounded-full h-3 w-3 bg-red-400"
                      ></span>
                    </span>
                  </div>

                  <SvgIcon
                    icon="bi:mic"
                    class="absolute bottom-[10px] left-[30px] cursor-pointer"
                  ></SvgIcon>
                </div>
              </n-dropdown>
            </template>
            <template #suffix v-if="isMobile">
              <div class="relative; w-[40px]">
                <div class="absolute bottom-[-3px] right-[0px]">
                  <NButton
                    type="primary"
                    :disabled="disabled || homeStore.myData.isLoader"
                    @click="handleSubmit"
                  >
                    <template #icon>
                      <span class="dark:text-black">
                        <SvgIcon
                          icon="ri:stop-circle-line"
                          v-if="homeStore.myData.isLoader"
                        />
                        <SvgIcon icon="ri:send-plane-fill" v-else />
                      </span>
                    </template>
                  </NButton>
                </div>
              </div>
            </template>
          </NInput>
        </template>
      </NAutoComplete>

      <!-- PC端 -->
      <div class="top-bar" v-if="!isMobile">
        <div class="left" v-if="st">
          <div
            v-if="homeStore.myData.local != 'draw'"
            class="chage-model-select"
            @click="st.isShow = true"
          >
            <template v-if="nGptStore.gpts">
              <SvgIcon icon="ri:apps-fill" />
              <span class="line-clamp-1 overflow-hidden">{{
                nGptStore.gpts.name
              }}</span>
            </template>
            <template v-else>
              <SvgIcon icon="heroicons:sparkles" />
              <span
                >模型:{{
                  nGptStore.modelLabel
                    ? truncateText(nGptStore.modelLabel, 20)
                    : "deepseek/deepseek-r1"
                }}
                {{
                  nGptStore.kid
                    ? "知识库:" + truncateText(nGptStore.kName, 10)
                    : ""
                }}</span
              >
            </template>
            <SvgIcon icon="icon-park-outline:right" />
          </div>
          <n-dropdown
            trigger="hover"
            :options="drOption"
            @select="handleSelectASR"
          >
            <div class="relative; w-[22px]" style="margin: 0 25px">
              <div
                class="absolute bottom-[14px] left-[31px]"
                v-if="st.micStart"
              >
                <span class="relative flex h-3 w-3">
                  <span
                    class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-500 opacity-75"
                  ></span>
                  <span
                    class="relative inline-flex rounded-full h-3 w-3 bg-red-400"
                  ></span>
                </span>
              </div>
              <IconSvg icon="voice" width="19px" height="19px"></IconSvg>
            </div>
          </n-dropdown>
          <n-tooltip trigger="hover">
            <template #trigger>
              <SvgIcon
                icon="line-md:uploading-loop"
                class="absolute bottom-[10px] left-[8px] cursor-pointer"
                v-if="st.isLoad == 1"
              />
              <IconSvg
                icon="upload"
                @click="fsRef.click()"
                v-else
                width="19px"
                height="19px"
              />
            </template>
            <div
              v-if="canVisionModel(gptConfigStore.myData.model)"
              v-html="$t('mj.upPdf')"
            />
            <div v-else v-html="$t('mj.upImg')" />
          </n-tooltip>
          <IconSvg
            @click="handleExport"
            icon="screenshot"
            width="19px"
            height="19px"/>
          <IconSvg
            @click="handleClear"
            class="right"
            icon="clear"
            width="19px"
            height="19px"/>
        </div>
        <div class="send" @click="handleSubmit">
          <IconSvg
            icon="send"
            style="margin-right: 0px !important"
            class="right"
            width="29px"
            height="19px"
          />
        </div>
      </div>
    </div>
  </div>

  <NModal
    v-model:show="st.isShow"
    preset="card"
    :title="$t('mjchat.modelChange')"
    class="!max-w-[620px]"
    @close="st.isShow = false"
  >
    <aiModel @close="st.isShow = false" />
  </NModal>

  <PromptStore v-model:visible="show"></PromptStore>

</template>

<style>

/* 明暗主题 */
.myinputs .n-input .n-input-wrapper {
  display: flex;
  align-items: stretch;
  background: var(--n-color) !important; /* 使用 Naive UI 的颜色变量 */
}

/* 暗黑模式 */
html.dark .myinputs .n-input .n-input-wrapper,
body.dark .myinputs .n-input .n-input-wrapper {
  background: #232627!important; /* 暗黑模式背景 */
}
</style>
