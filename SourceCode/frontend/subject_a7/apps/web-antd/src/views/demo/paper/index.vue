<script setup lang="ts">
import type { VbenFormProps } from '@vben/common-ui';

import type { VxeGridProps } from '#/adapter/vxe-table';
import type { Paper } from '#/api/a7/paper';

import { ref } from 'vue';

import { useAccess } from '@vben/access';//权限控制函数
import { Page, useVbenDrawer, useVbenModal } from '@vben/common-ui';
import { $t } from '@vben/locales';
import { preferences } from '@vben/preferences';
import { getVxePopupContainer } from '@vben/utils';

import {
  Avatar,
  Dropdown,
  Menu,
  MenuItem,
  Modal,
  Popconfirm,
  Space,
} from 'ant-design-vue';

import { useVbenVxeGrid, vxeCheckboxChecked } from '#/adapter/vxe-table';
import {
  userExport,
  findList,
  userRemove,
  userStatusChange,
} from '#/api/a7/paper';
import { TableSwitch } from '#/components/table';
import { commonDownloadExcel } from '#/utils/file/download';

import { columns, querySchema } from './data';
import userDrawer from './user-drawer.vue';
import userImportModal from './user-import-modal.vue';
import userInfoModal from './user-info-modal.vue';
import userResetPwdModal from './user-reset-pwd-modal.vue';

/**
 * 导入
 */
const [UserImpotModal, userImportModalApi] = useVbenModal({//创建一个导入用户的模态框组件，并绑定控制它的 userImportModalApi
  connectedComponent: userImportModal,
});

// 左边部门用
const selectDeptId = ref<string[]>([]);

const formOptions: VbenFormProps = {
  schema: querySchema(),//有哪些输入框、下拉框
  commonConfig: {
    labelWidth: 80,//标签宽度
    componentProps: {
      allowClear: true,
    },
  },
  wrapperClass: 'grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4',
  handleReset: async () => {
    selectDeptId.value = [];

    const { formApi, reload } = tableApi;
    await formApi.resetForm();
    const formValues = formApi.form.values;
    formApi.setLatestSubmissionValues(formValues);
    await reload(formValues);
  },
  // 日期选择格式化
  fieldMappingTime: [
    [
      'createTime',
      ['params[beginTime]', 'params[endTime]'],
      ['YYYY-MM-DD 00:00:00', 'YYYY-MM-DD 23:59:59'],
    ],
  ],
};

const gridOptions: VxeGridProps = {//定义 “表格” 的配置
  checkboxConfig: {//复选框
    // 高亮
    highlight: true,
    // 翻页时保留选中状态
    reserve: true,
    // 点击行选中
    trigger: 'default',
    checkMethod: ({ row }) => row?.userId !== 1,
  },
  columns,
  height: 'auto',
  keepSource: true,
  pagerConfig: {},
  proxyConfig: {
    ajax: {
      query: async ({ page }, formValues = {}) => {
        return await findList({
          pageNum: page.currentPage,
          pageSize: page.pageSize,
          ...formValues,
        });
      },
    },
  },
  rowConfig: {
    keyField: 'id',
    height: 48,
  },
  id: 'a7-paper-index',
};
const [BasicTable, tableApi] = useVbenVxeGrid({//创建 “带搜索表单的表格组件”
  formOptions,
  gridOptions,
});

const [UserDrawer, userDrawerApi] = useVbenDrawer({//创建 “抽屉弹窗”
  connectedComponent: userDrawer,
});

function handleAdd() {//新增试卷
  userDrawerApi.setData({});//清空抽屉数据（确保是空白表单）
  userDrawerApi.open();//触发onOpenChange，id 为 undefined → 显示空表单
}

function handleEdit(row: Paper) {
  userDrawerApi.setData({ id: row.id });
  userDrawerApi.open();//触发onOpenChange
}

async function handleDelete(row: Paper) {
  await userRemove(row.id);//使用 await 确保删除成功后再刷新列表
  await tableApi.query();
}

const { hasAccessByCodes } = useAccess();
</script>

<template>
  <Page :auto-content-height="true">
    <div class="flex h-full gap-[8px]">
      <BasicTable class="flex-1 overflow-hidden" table-title="题目列表">
        <template #toolbar-tools>
          <Space>
            <a-button
              :disabled="!vxeCheckboxChecked(tableApi)"
              danger
              type="primary"
              @click="handleMultiDelete"
            >
              {{ $t('pages.common.delete') }}
            </a-button>
            <a-button
              type="primary"
              @click="handleAdd"
            >
              {{ $t('pages.common.add') }}
            </a-button>
          </Space>
        </template>
        <template #status="{ row }">
          <TableSwitch
            v-model="row.status"
            :api="() => userStatusChange(row)"
            :disabled="
              row.userId === 1 || !hasAccessByCodes(['system:user:edit'])
            "
            :reload="() => tableApi.query()"
          />
        </template>
        <template #action="{ row }">
          <template v-if="row.userId !== 1">
            <Space>
              <ghost-button
                @click.stop="handleEdit(row)"
              >
                {{ $t('pages.common.edit') }}
              </ghost-button>
              <Popconfirm
                :get-popup-container="getVxePopupContainer"
                placement="left"
                title="确认删除？"
                @confirm="handleDelete(row)"
              >
                <ghost-button
                  danger
                  @click.stop=""
                >
                  {{ $t('pages.common.delete') }}
                </ghost-button>
              </Popconfirm>
            </Space>
          </template>
        </template>
      </BasicTable>
    </div>
    <UserImpotModal @reload="tableApi.query()" />
    <UserDrawer @reload="tableApi.query()" />
    <UserInfoModal />
    <UserResetPwdModal />
  </Page>
</template>
