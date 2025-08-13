import type { FormSchemaGetter } from '#/adapter/form';
import type { VxeGridProps } from '#/adapter/vxe-table';

import { DictEnum } from '@vben/constants';
import { getPopupContainer } from '@vben/utils';

import { z } from '#/adapter/form';
import { getDictOptions } from '#/utils/dict';

export const querySchema: FormSchemaGetter = () => [
  {
    component: 'Input',
    fieldName: 'paperName',
    label: '试卷',
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
    label: '难度',
  },
  {
    component: 'Input',
    fieldName: 'createName',
    label: '提卷人',
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
    field: 'paperName',
    title: '试卷',
  },
  {
    field: 'paperSubject',
    title: '科目',
  },
  {
    field: 'paperDifficulty',
    title: '难度',
  },
  {
    field: 'createName',
    title: '提卷人',
  },
  {
    field: 'topicNumber',
    title: '题目数量',
  },
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
    fieldName: 'paperName',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '试卷',
  },
  {
    component: 'Input',
    fieldName: 'paperSubject',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '科目',
  },
  {
    component: 'Input',
    fieldName: 'answerTime',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '答题时间',
  },
  {
    component: 'Input',
    fieldName: 'paperDifficulty',
    dependencies: {
      show: () => false,
      triggerFields: [''],
    },
    label: '题型难度',
  },
  {
    component: 'Input',
    fieldName: 'paperType',
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
    fieldName: 'topics',
  },
];
