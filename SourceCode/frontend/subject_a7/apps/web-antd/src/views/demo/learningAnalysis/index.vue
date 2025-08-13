<script lang="ts" setup>
import type { AnalysisOverviewItem } from '@vben/common-ui';
import type { TabOption } from '@vben/types';

import {
  AnalysisChartCard,
  AnalysisChartsTabs,
  AnalysisOverview,
} from '@vben/common-ui';
import {
  SvgBellIcon,
  SvgCakeIcon,
  SvgCardIcon,
  SvgDownloadIcon,
} from '@vben/icons';

import AnalyticsTrends from '../analytics/analytics-trends.vue';
import AnalyticsTrends2 from '../analytics/analytics-trends2.vue';
import AnalyticsVisits from '../analytics/analytics-visits.vue';
import AnalyticsVisitsSource from '../analytics/analytics-visits-source.vue';

const overviewItems: AnalysisOverviewItem[] = [
  {
    icon: SvgCardIcon,
    title: '今日使用次数（教师）',
    totalTitle: '较昨日',
    totalValue: 15,
    value: 12,
  },
  {
    icon: SvgCakeIcon,
    title: '本周使用次数（教师）',
    totalTitle: '较上周',
    totalValue: 18,
    value: 18,
  },
  {
    icon: SvgDownloadIcon,
    title: '今日使用次数（学生）',
    totalTitle: '较昨日',
    totalValue: 16,
    value: 55,
  },
  {
    icon: SvgBellIcon,
    title: '本周使用次数（学生）',
    totalTitle: '较上周',
    totalValue: 21,
    value: 128,
  },
];

const chartTabs1: TabOption[] = [
  {
    label: '教学效率指数详情',
    value: 'visits',
  },
];
const chartTabs2: TabOption[] = [
  {
    label: '学生正确率',
    value: 'trends',
  },
];
const chartTabs3: TabOption[] = [
  {
    label: '高频知识错误点TOP排行',
    value: 'trends',
  },
];
</script>

<template>
  <div class="p-5">
    <AnalysisOverview :items="overviewItems" />

    <div class="mt-5 w-full md:flex">
      <AnalysisChartCard class="mt-5 md:mr-4 md:mt-0 md:w-1/2" title="教学效率指标详情">
        <AnalysisChartsTabs :tabs="chartTabs1" class="mt-5">
          <template #visits>
            <AnalyticsVisits />
          </template>
        </AnalysisChartsTabs>
      </AnalysisChartCard>
      <AnalysisChartCard class="mt-5 md:mr-4 md:mt-0 md:w-1/2" title="学生正确率">
        <AnalysisChartsTabs :tabs="chartTabs2" class="mt-5">
          <template #trends>
            <AnalyticsTrends />
          </template>
        </AnalysisChartsTabs>
      </AnalysisChartCard>
    </div>

    <div class="mt-5 w-full md:flex">
      <AnalysisChartCard class="mt-5 md:mr-4 md:mt-0 md:w-1/2" title="科目出题排行">
        <AnalyticsVisitsSource />
      </AnalysisChartCard>
      <AnalysisChartCard class="mt-5 md:mr-4 md:mt-0 md:w-1/2" title="高频知识错误点TOP排行">
        <AnalysisChartsTabs :tabs="chartTabs3" class="mt-5">
          <template #trends>
            <AnalyticsTrends2 />
          </template>
        </AnalysisChartsTabs>
      </AnalysisChartCard>
    </div>
  </div>
</template>
