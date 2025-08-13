// 导入题目数据
import { topicChoice as pythonTopicChoice, topicCode as pythonTopicCode } from './python-data';
import { topicChoice as javaTopicChoice, topicCode as javaTopicCode } from './java-data';

/**
 * 从给定题目数组中随机获取指定数量的题目
 * @param topicArray 题目数组
 * @param count 需要获取的题目数量
 * @returns 随机获取的题目数组
 */
export function getRandomTopics(topicArray: any[], count: number): any[] {
  // 参数验证
  if (!Array.isArray(topicArray) || topicArray.length === 0) {
    console.warn('题目数组为空或不是有效数组');
    return [];
  }

  if (count <= 0) {
    console.warn('获取数量必须大于0');
    return [];
  }

  if (count >= topicArray.length) {
    console.warn('获取数量大于等于题目总数，返回所有题目的随机排序');
    return shuffleArray([...topicArray]);
  }

  // 创建题目数组的副本，避免修改原数组
  const topicsCopy = [...topicArray];
  const result: any[] = [];

  // 使用Fisher-Yates洗牌算法随机选择题目
  for (let i = 0; i < count; i++) {
    const randomIndex = Math.floor(Math.random() * topicsCopy.length);
    result.push(topicsCopy[randomIndex]);
    // 移除已选择的题目，避免重复
    topicsCopy.splice(randomIndex, 1);
  }

  return result;
}

/**
 * 数组洗牌函数（Fisher-Yates算法）
 * @param array 需要洗牌的数组
 * @returns 洗牌后的数组
 */
function shuffleArray(array: any[]): any[] {
  const shuffled = [...array];
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
  }
  return shuffled;
}

/**
 * 按题目类型随机获取题目
 * @param topicArray 题目数组
 * @param count 需要获取的题目数量
 * @param topicType 题目类型（可选）
 * @returns 随机获取的题目数组
 */
export function getRandomTopicsByType(
  topicArray: any[],
  count: number,
  topicType?: string,
): any[] {
  let filteredTopics = topicArray;

  // 如果指定了题目类型，先过滤
  if (topicType) {
    filteredTopics = topicArray.filter(
      (topic) => topic.topicType === topicType,
    );
    if (filteredTopics.length === 0) {
      console.warn(`没有找到类型为 "${topicType}" 的题目`);
      return [];
    }
  }

  return getRandomTopics(filteredTopics, count);
}

/**
 * 根据语言类型随机获取题目
 * @param language 编程语言类型，支持 'java' 和 'python'
 * @returns 随机获取的题目数组
 */
export function randomTopics(language: 'java' | 'python' = 'python') {
  let choiceTopics, codeTopics;

  // 根据传入的语言参数选择对应的题目数据
  if (language === 'java') {
    choiceTopics = javaTopicChoice;
    codeTopics = javaTopicCode;
  } else {
    choiceTopics = pythonTopicChoice;
    codeTopics = pythonTopicCode;
  }

  // 从选择题数组中随机获取4道题
  const agr = getRandomTopics(choiceTopics, 4);
  // 从编程题数组中随机获取1道题
  const bgr = getRandomTopics(codeTopics, 1);
  return [...agr, ...bgr];
}
