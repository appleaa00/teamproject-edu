<script lang="ts" setup>
import type { EchartsUIType } from '@vben/plugins/echarts';

import { onMounted, ref } from 'vue';

import { EchartsUI, useEcharts } from '@vben/plugins/echarts';

const chartRef = ref<EchartsUIType>();
const { renderEcharts } = useEcharts(chartRef);
import dayjs from 'dayjs';

onMounted(() => {
  renderEcharts({
    grid: {
      bottom: 0,
      containLabel: true,
      left: '1%',
      right: '1%',
      top: '2 %',
    },
    series: [
      {
        barMaxWidth: 80,
        color: '#4FD1C5',
        data: [120, 160, 125, 135, 132, 154, 12, 1],
        type: 'bar',
        itemStyle: {
          borderRadius: [0, 20, 20, 0],
        },
      },
      // {
      //   barMaxWidth: 80,
      //   // color: '#4f69fd',
      //   data: [136, 178, 136, 148, 145, 164, 18, 1],
      //   type: 'bar',
      // },
    ],
    tooltip: {
      axisPointer: {
        lineStyle: {
          // color: '#4f69fd',
          width: 1,
        },
      },
      trigger: 'axis',
    },
    xAxis: {
      max: 200,
      splitNumber: 4,
      type: 'value',
    },
    yAxis: {
      type: 'category',
      data: [
        '操作系统',
        '机器学习',
        '大模型开发',
        '人工智能',
        '自然语言处理',
        '语音识别',
      ],
    },
  });
});
</script>

<template>
  <EchartsUI ref="chartRef" />
</template>
