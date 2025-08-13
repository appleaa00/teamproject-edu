<script lang="ts" setup>
import { computed } from 'vue';
import { useRoute } from 'vue-router';

import { useContentMaximize, useTabs } from '@vben/hooks';
import { preferences } from '@vben/preferences';
import { useTabbarStore } from '@vben/stores';

import { TabsToolMore, TabsToolScreen, TabsView } from '@vben-core/tabs-ui';

import { useTabbar } from './use-tabbar';

defineOptions({
  name: 'LayoutTabbar',
});

defineProps<{ showIcon?: boolean; theme?: string }>(); // 接收的 props：showIcon（是否显示图标）和 theme（主题样式）

const route = useRoute(); // 获取当前路由
const tabbarStore = useTabbarStore(); // 获取标签页状态管理
const { contentIsMaximize, toggleMaximize } = useContentMaximize(); // 处理内容区域最大化
const { unpinTab } = useTabs(); // 提供标签页操作工具

const {
  createContextMenus,
  currentActive,
  currentTabs,
  handleClick,
  handleClose,
} = useTabbar(); // 自定义组合式函数，提供标签页核心逻辑

const menus = computed(() => {
  const tab = tabbarStore.getTabByPath(currentActive.value); // // 1. 找到当前激活的标签页
  const menus = createContextMenus(tab); // 生成右键菜单项
  return menus.map((item) => {
    return {
      ...item,
      label: item.text,
      value: item.key,
    };
  });
});

// 刷新后如果不保持tab状态，关闭其他tab
if (!preferences.tabbar.persist) {
  tabbarStore.closeOtherTabs(route);
}
</script>

<template>
  <TabsView
    :active="currentActive"
    :class="theme"
    :context-menus="createContextMenus"
    :draggable="preferences.tabbar.draggable"
    :show-icon="showIcon"
    :style-type="preferences.tabbar.styleType"
    :tabs="currentTabs"
    :wheelable="preferences.tabbar.wheelable"
    :middle-click-to-close="preferences.tabbar.middleClickToClose"
    @close="handleClose"
    @sort-tabs="tabbarStore.sortTabs"
    @unpin="unpinTab"
    @update:active="handleClick"
  />
  <div class="flex-center h-full">
    <TabsToolMore v-if="preferences.tabbar.showMore" :menus="menus" />
    <TabsToolScreen
      v-if="preferences.tabbar.showMaximize"
      :screen="contentIsMaximize"
      @change="toggleMaximize"
      @update:screen="toggleMaximize"
    />
  </div>
</template>
