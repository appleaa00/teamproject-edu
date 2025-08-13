import type { FormSchemaGetter } from '#/adapter/form';
import type { VxeGridProps } from '#/adapter/vxe-table';

import { DictEnum } from '@vben/constants';
import { getPopupContainer } from '@vben/utils';

import { z } from '#/adapter/form';
import { getDictOptions } from '#/utils/dict';

export const querySchema: FormSchemaGetter = () => [
  {
    component: 'Input',
    fieldName: 'topicName',
    label: '题目',
  },
  {
    component: 'Select',
    componentProps: {
      allowClear: true,
      getPopupContainer,
      options: [
        { label: '基础', value: '基础' },
        { label: '中等', value: '中等' },
        { label: '挑战', value: '挑战' },
      ],
    },
    fieldName: 'topicDifficulty',
    label: '题目难度',
  },
  {
    component: 'Select',
    componentProps: {
      allowClear: true,
      getPopupContainer,
      options: [
        { label: '选择题', value: '选择题' },
        { label: '编程题', value: '编程题' },
      ],
    },
    fieldName: 'topicType',
    label: '题目类型',
  },
  {
    component: 'RangePicker',
    fieldName: 'createTime',
    label: '创建时间',
  },
];

export const columns: VxeGridProps['columns'] = [
  { type: 'checkbox', width: 60 },
  {
    field: 'topicName',
    title: '题目',
  },
  {
    field: 'topicDifficulty',
    title: '题型难度',
  },
  {
    field: 'topicType',
    title: '题目类型',
  },
  // {
  //   field: 'avatar',
  //   title: '头像',
  //   slots: { default: 'avatar' },
  //   width: 80,
  // },
  {
    field: 'createTime',
    title: '创建时间',
  },
  {
    field: 'action',
    fixed: 'right',
    slots: { default: 'action' },
    title: '操作',
    width: 180,
  },
];

export const drawerSchema: FormSchemaGetter = () => [
  {
    component: 'Input',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    fieldName: 'id',
  },
  {
    component: 'Input',
    fieldName: 'topicName',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '题目',
  },
  {
    component: 'Input',
    fieldName: 'topicAnswer',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '答案解析',
  },
  {
    component: 'Input',
    fieldName: 'topicDifficulty',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '题型难度',
  },
  {
    component: 'Input',
    fieldName: 'topicType',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '题目类型',
  },
  {
    component: 'Input',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    fieldName: 'topicOptions',
  },
];
