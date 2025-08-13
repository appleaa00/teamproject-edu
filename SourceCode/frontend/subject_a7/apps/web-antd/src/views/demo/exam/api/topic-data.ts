export const topic_choice_1 = {
  topicName: '以下哪个不是Python的内置数据类型？',
  topicAnswer:
    "Python的内置数据类型包括整数(int)、浮点数(float)、字符串(str)、列表(list)、元组(tuple)、集合(set)、字典(dict)和布尔值(bool)等。'array'不是Python的内置数据类型，而是NumPy库中的数据结构。",
  topicOptions: [
    {
      sorted: 'A',
      optionContent: 'list',
      rightAnswer: false,
    },
    {
      sorted: 'B',
      optionContent: 'tuple',
      rightAnswer: false,
    },
    {
      sorted: 'C',
      optionContent: 'array',
      rightAnswer: true,
    },
    {
      sorted: 'D',
      optionContent: 'set',
      rightAnswer: false,
    },
  ],
};

export const topic_code_1 = {
  topicName: '字符串压缩',
  topicContent:
    "编写一个函数，实现字符串压缩功能。例如，输入字符串 'aabcccccaaa'，应返回 'a2b1c5a3'。如果压缩后的字符串长度不小于原始字符串，则返回原始字符串。",
  topicAnswer:
    "这道题需要我们遍历字符串并统计连续相同字符的出现次数，然后将结果拼接成新的字符串。\n\n以下是实现代码：\n```python\ndef string_compression(s):\n    if not s:\n        return s\n    \n    compressed = []\n    count = 1\n    \n    # 遍历字符串，统计连续相同字符的出现次数\n    for i in range(1, len(s)):\n        if s[i] == s[i-1]:\n            count += 1\n        else:\n            compressed.append(s[i-1] + str(count))\n            count = 1\n    \n    # 处理最后一组字符\n    compressed.append(s[-1] + str(count))\n    \n    # 将压缩后的字符串拼接起来\n    compressed_str = ''.join(compressed)\n    \n    # 如果压缩后的字符串长度不小于原始字符串，则返回原始字符串\n    return compressed_str if len(compressed_str) < len(s) else s\n```\n\n**解析**：\n1. 首先检查输入字符串是否为空，如果为空则直接返回。\n2. 创建一个空列表`compressed`用于存储压缩后的字符和计数。\n3. 遍历字符串，统计连续相同字符的出现次数。当遇到不同字符时，将前一个字符及其计数添加到`compressed`列表中，并重置计数为1。\n4. 处理完字符串后，需要将最后一组字符及其计数添加到`compressed`列表中。\n5. 将`compressed`列表中的元素拼接成字符串，并与原始字符串比较长度，返回较短的那个。\n\n**时间复杂度**：O(n)，其中n是字符串的长度。我们只需要遍历字符串一次。\n**空间复杂度**：O(n)，最坏情况下，压缩后的字符串长度可能与原始字符串相同。",
};
