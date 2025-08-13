import type { MenuRecordRaw } from '@vben/types';

import { computed, onBeforeMount, ref, watch } from 'vue';
import { useRoute } from 'vue-router'; // 获取当前页面的 URL

import { preferences, usePreferences } from '@vben/preferences';
import { useAccessStore } from '@vben/stores'; // 获取用户有权限看到的菜单
import { findRootMenuByPath } from '@vben/utils'; // 根据 URL 找对应的菜单

import { useNavigation } from './use-navigation';

function useMixedMenu() {
  const { navigation } = useNavigation();
  const accessStore = useAccessStore();
  const route = useRoute();
  const splitSideMenus = ref<MenuRecordRaw[]>([]);
  const rootMenuPath = ref<string>('');
  const mixedRootMenuPath = ref<string>('');
  const mixExtraMenus = ref<MenuRecordRaw[]>([]);
  /** 记录当前顶级菜单下哪个子菜单最后激活 */
  const defaultSubMap = new Map<string, string>();
  const { isMixedNav, isHeaderMixedNav } = usePreferences();

  const needSplit = computed(
    // 判断是否需要分割菜单
    () =>
      (preferences.navigation.split && isMixedNav.value) || // 当启用分割导航且处于混合模式时
      isHeaderMixedNav.value, // 当启用头部混合导航时
  );

  const sidebarVisible = computed(() => {
    // 控制侧边栏显示
    const enableSidebar = preferences.sidebar.enable; // 获取 是否全局启用侧边栏
    if (needSplit.value) {
      return enableSidebar && splitSideMenus.value.length > 0; // 全局启用+当前有可用的子菜单
    }
    return enableSidebar;
  });
  const menus = computed(() => accessStore.accessMenus);

  /**
   * 头部菜单
   */
  const headerMenus = computed(() => {
    if (!needSplit.value) {
      return menus.value;
    }
    return menus.value.map((item) => {
      return {
        ...item,
        children: [], // 清空其 children 字段
      };
    });
  });

  /**
   * 侧边菜单
   */
  const sidebarMenus = computed(() => {
    return needSplit.value ? splitSideMenus.value : menus.value;
  });

  const mixHeaderMenus = computed(() => {
    return isHeaderMixedNav.value ? sidebarMenus.value : headerMenus.value;
  });

  /**
   * 侧边菜单激活路径
   */
  const sidebarActive = computed(() => {
    return (route?.meta?.activePath as string) ?? route.path;
  });

  /**
   * 头部菜单激活路径
   */
  const headerActive = computed(() => {
    if (!needSplit.value) {
      return route.path;
    }
    return rootMenuPath.value;
  });

  /**
   * 菜单点击事件处理
   * @param key 菜单路径
   * @param mode 菜单模式
   */
  const handleMenuSelect = (key: string, mode?: string) => {
    if (!needSplit.value || mode === 'vertical') {
      navigation(key);
      return;
    }

    const rootMenu = menus.value.find((item) => item.path === key);
    rootMenuPath.value = rootMenu?.path ?? ''; // 更新当前顶级菜单路径
    splitSideMenus.value = rootMenu?.children ?? []; // 更新侧边栏显示该顶级菜单的子菜单
    if (splitSideMenus.value.length === 0) {
      navigation(key); // 如果该顶级菜单无子菜单 → 直接导航
    } else if (rootMenu && preferences.sidebar.autoActivateChild) {
      navigation(
        defaultSubMap.has(rootMenu.path)
          ? (defaultSubMap.get(rootMenu.path) as string)
          : rootMenu.path,
        // 如果配置了 autoActivateChild（自动激活子菜单）：
        // 优先导航到该顶级菜单下上次激活的子菜单（从 defaultSubMap 读取）
        // 如果没有记录，则导航到顶级菜单路径本身
      );
    }
  };

  /**
   * 侧边菜单展开事件
   * @param key 路由路径
   * @param parentsPath 父级路径
   */
  const handleMenuOpen = (key: string, parentsPath: string[]) => {
    if (parentsPath.length <= 1 && preferences.sidebar.autoActivateChild) {
      navigation(
        defaultSubMap.has(key) ? (defaultSubMap.get(key) as string) : key,
      );
    }
  };

  /**
   * 计算侧边菜单
   * @param path 路由路径
   */
  function calcSideMenus(path: string = route.path) {
    // 根据当前路由路径计算侧边菜单内容
    let { rootMenu } = findRootMenuByPath(menus.value, path); // 在完整菜单树中查找当前路径对应的顶级菜单
    if (!rootMenu) {
      rootMenu = menus.value.find((item) => item.path === path); // 如果没找到（可能是顶级菜单本身），则直接用路径匹配
    }
    const result = findRootMenuByPath(rootMenu?.children || [], path, 1); // 再次调用 findRootMenuByPath，但这次在顶级菜单的子菜单中查找
    mixedRootMenuPath.value = result.rootMenuPath ?? '';
    mixExtraMenus.value = result.rootMenu?.children ?? [];
    rootMenuPath.value = rootMenu?.path ?? '';
    splitSideMenus.value = rootMenu?.children ?? []; // 设置侧边菜单内容为顶级菜单的子菜单
  }

  watch(
    () => route.path,
    (path) => {
      const currentPath = (route?.meta?.activePath as string) ?? path;
      calcSideMenus(currentPath);
      if (rootMenuPath.value)
        defaultSubMap.set(rootMenuPath.value, currentPath);
    }, // 将当前顶级菜单路径与激活的子路径关联起来
    // 存储到 defaultSubMap 中，用于下次快速定位
    { immediate: true },
  );

  // 初始化计算侧边菜单
  onBeforeMount(() => {
    calcSideMenus(route.meta?.activePath || route.path);
  });

  return {
    handleMenuSelect,
    handleMenuOpen,
    headerActive,
    headerMenus,
    sidebarActive,
    sidebarMenus,
    mixHeaderMenus,
    mixExtraMenus,
    sidebarVisible,
  };
}

export { useMixedMenu };
