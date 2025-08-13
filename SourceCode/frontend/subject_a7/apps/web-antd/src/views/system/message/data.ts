import type { FormSchemaGetter } from '#/adapter/form';
import type { VxeGridProps } from '#/adapter/vxe-table';

export const querySchema: FormSchemaGetter = () => [
  {
    component: 'Input',
    fieldName: 'modelName',
    label: '模型名称',
  },
];

// 需要使用i18n注意这里要改成getter形式 否则切换语言不会刷新
// export const columns: () => VxeGridProps['columns'] = () => [
export const columns: VxeGridProps['columns'] = [
  { type: 'checkbox', width: 60 },
  {
    title: '主键',
    field: 'id',
  },
  {
    title: '用户id',
    field: 'userId',
  },
  {
    title: '消息内容',
    field: 'content',
  },
  {
    title: '对话角色',
    field: 'role',
  },
  {
    title: '扣除金额',
    field: 'deductCost',
  },
  {
    title: '累计 Tokens',
    field: 'totalTokens',
  },
  {
    title: '模型名称',
    field: 'modelName',
  },
  {
    title: '备注',
    field: 'remark',
  },
  {
    field: 'action',
    fixed: 'right',
    slots: { default: 'action' },
    title: '操作',
    width: 180,
  },
];
