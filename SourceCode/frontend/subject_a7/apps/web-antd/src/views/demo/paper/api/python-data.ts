export const topicChoice = [
  {
    topicType: '选择题',
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
  },
  {
    topicType: '选择题',
    topicName:
      '执行以下代码后，x的值是多少？\n```python\nx = [1, 2, 3]\ny = x\ny.append(4)\n```',
    topicAnswer:
      "在Python中，当使用'y = x'这样的语句时，实际上是将y指向了与x相同的对象，而不是创建了一个新的列表。因此，当通过y修改列表时，x也会反映这些变化。所以x最终的值是[1, 2, 3, 4]。",
    topicOptions: [
      {
        sorted: 'A',
        optionContent: '[1, 2, 3]',
        rightAnswer: false,
      },
      {
        sorted: 'B',
        optionContent: '[1, 2, 3, 4]',
        rightAnswer: true,
      },
      {
        sorted: 'C',
        optionContent: '[1, 2, 4]',
        rightAnswer: false,
      },
      {
        sorted: 'D',
        optionContent: '以上都不对',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName: '以下哪个函数可以用于将字符串转换为整数？',
    topicAnswer:
      'int()是Python的内置函数，用于将字符串或数字转换为整数。str()用于将对象转换为字符串，float()用于将对象转换为浮点数，chr()用于将Unicode码点转换为字符。',
    topicOptions: [
      {
        sorted: 'A',
        optionContent: 'str()',
        rightAnswer: false,
      },
      {
        sorted: 'B',
        optionContent: 'int()',
        rightAnswer: true,
      },
      {
        sorted: 'C',
        optionContent: 'float()',
        rightAnswer: false,
      },
      {
        sorted: 'D',
        optionContent: 'chr()',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName:
      '以下代码的输出结果是什么？\n```python\nx = 10\ndef func():\n    x = 20\n    print(x)\nfunc()\nprint(x)\n```',
    topicAnswer:
      "在Python中，函数内部定义的变量是局部变量，只在函数内部有效。所以当在函数内部执行'x = 20'时，它创建了一个新的局部变量x，而不会影响函数外部的全局变量x。因此，函数内部打印的是局部变量x的值20，函数外部打印的是全局变量x的值10。",
    topicOptions: [
      {
        sorted: 'A',
        optionContent: '20\n10',
        rightAnswer: true,
      },
      {
        sorted: 'B',
        optionContent: '10\n20',
        rightAnswer: false,
      },
      {
        sorted: 'C',
        optionContent: '20\n20',
        rightAnswer: false,
      },
      {
        sorted: 'D',
        optionContent: '10\n10',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName:
      '以下代码的输出结果是什么？\n```python\nx = [1, 2, 3]\ny = x.copy()\ny.append(4)\nprint(x)\n```',
    topicAnswer:
      '列表的copy()方法创建的是一个浅拷贝，它复制了列表本身，但不会递归地复制列表中的元素。在这个例子中，x和y是两个不同的列表对象，所以当通过y修改列表时，x不会受到影响。因此，x的值仍然是[1, 2, 3]。',
    topicOptions: [
      {
        sorted: 'A',
        optionContent: '[1, 2, 3]',
        rightAnswer: true,
      },
      {
        sorted: 'B',
        optionContent: '[1, 2, 3, 4]',
        rightAnswer: false,
      },
      {
        sorted: 'C',
        optionContent: '[1, 2, 4]',
        rightAnswer: false,
      },
      {
        sorted: 'D',
        optionContent: '以上都不对',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName: '以下哪个是Python的合法标识符？',
    topicAnswer:
      "Python标识符的规则是：只能包含字母、数字和下划线，不能以数字开头，不能是Python的关键字。'my_var'符合这些规则，是合法的标识符。'1var'以数字开头，'my-var'包含连字符，'if'是Python的关键字，它们都不是合法的标识符。",
    topicOptions: [
      {
        sorted: 'A',
        optionContent: '1var',
        rightAnswer: false,
      },
      {
        sorted: 'B',
        optionContent: 'my-var',
        rightAnswer: false,
      },
      {
        sorted: 'C',
        optionContent: 'my_var',
        rightAnswer: true,
      },
      {
        sorted: 'D',
        optionContent: 'if',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName:
      '以下代码的输出结果是什么？\n```python\nx = 5\ny = 2\nprint(x // y)\n```',
    topicAnswer:
      "在Python中，'//'是地板除法运算符，它返回除法的整数部分，向下取整。5除以2等于2.5，向下取整为2，所以输出结果是2。",
    topicOptions: [
      {
        sorted: 'A',
        optionContent: '2.5',
        rightAnswer: false,
      },
      {
        sorted: 'B',
        optionContent: '2',
        rightAnswer: true,
      },
      {
        sorted: 'C',
        optionContent: '3',
        rightAnswer: false,
      },
      {
        sorted: 'D',
        optionContent: '0',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName:
      '以下代码的输出结果是什么？\n```python\nx = [1, 2, 3]\nprint(x[-1])\n```',
    topicAnswer:
      '在Python中，负数索引表示从列表末尾开始计数。索引-1表示最后一个元素，索引-2表示倒数第二个元素，依此类推。所以x[-1]返回列表x的最后一个元素，即3。',
    topicOptions: [
      {
        sorted: 'A',
        optionContent: '1',
        rightAnswer: false,
      },
      {
        sorted: 'B',
        optionContent: '2',
        rightAnswer: false,
      },
      {
        sorted: 'C',
        optionContent: '3',
        rightAnswer: true,
      },
      {
        sorted: 'D',
        optionContent: '以上都不对',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName:
      '以下代码的输出结果是什么？\n```python\ndef func(a, b=2):\n    return a + b\nprint(func(3))\n```',
    topicAnswer:
      '在Python中，函数参数可以有默认值。当调用函数时，如果没有提供某个参数的值，则使用该参数的默认值。在这个例子中，函数func有两个参数a和b，其中b的默认值为2。当调用func(3)时，只提供了a的值3，b使用默认值2，所以返回3 + 2 = 5。',
    topicOptions: [
      {
        sorted: 'A',
        optionContent: '3',
        rightAnswer: false,
      },
      {
        sorted: 'B',
        optionContent: '5',
        rightAnswer: true,
      },
      {
        sorted: 'C',
        optionContent: '6',
        rightAnswer: false,
      },
      {
        sorted: 'D',
        optionContent: '错误',
        rightAnswer: false,
      },
    ],
  },
  {
    topicType: '选择题',
    topicName:
      "以下代码的输出结果是什么？\n```python\nx = {'a': 1, 'b': 2}\nprint('a' in x)\n```",
    topicAnswer:
      "在Python中，使用'in'运算符检查字典中是否包含某个键。如果字典包含指定的键，则返回True，否则返回False。在这个例子中，字典x包含键'a'，所以'a' in x返回True。",
    topicOptions: [
      {
        sorted: 'A',
        optionContent: 'True',
        rightAnswer: true,
      },
      {
        sorted: 'B',
        optionContent: 'False',
        rightAnswer: false,
      },
      {
        sorted: 'C',
        optionContent: '1',
        rightAnswer: false,
      },
      {
        sorted: 'D',
        optionContent: '错误',
        rightAnswer: false,
      },
    ],
  },
];

export const topicCode = [
  // {
  //   topicType: '编程题',
  //   topicName: '字符串压缩',
  //   topicContent:
  //     "编写一个函数，实现字符串压缩功能。例如，输入字符串 'aabcccccaaa'，应返回 'a2b1c5a3'。如果压缩后的字符串长度不小于原始字符串，则返回原始字符串。",
  //   topicAnswer:
  //     "这道题需要我们遍历字符串并统计连续相同字符的出现次数，然后将结果拼接成新的字符串。\n\n以下是实现代码：\n```python\ndef string_compression(s):\n    if not s:\n        return s\n    \n    compressed = []\n    count = 1\n    \n    # 遍历字符串，统计连续相同字符的出现次数\n    for i in range(1, len(s)):\n        if s[i] == s[i-1]:\n            count += 1\n        else:\n            compressed.append(s[i-1] + str(count))\n            count = 1\n    \n    # 处理最后一组字符\n    compressed.append(s[-1] + str(count))\n    \n    # 将压缩后的字符串拼接起来\n    compressed_str = ''.join(compressed)\n    \n    # 如果压缩后的字符串长度不小于原始字符串，则返回原始字符串\n    return compressed_str if len(compressed_str) < len(s) else s\n```\n\n**解析**：\n1. 首先检查输入字符串是否为空，如果为空则直接返回。\n2. 创建一个空列表`compressed`用于存储压缩后的字符和计数。\n3. 遍历字符串，统计连续相同字符的出现次数。当遇到不同字符时，将前一个字符及其计数添加到`compressed`列表中，并重置计数为1。\n4. 处理完字符串后，需要将最后一组字符及其计数添加到`compressed`列表中。\n5. 将`compressed`列表中的元素拼接成字符串，并与原始字符串比较长度，返回较短的那个。\n\n**时间复杂度**：O(n)，其中n是字符串的长度。我们只需要遍历字符串一次。\n**空间复杂度**：O(n)，最坏情况下，压缩后的字符串长度可能与原始字符串相同。",
  // },
  // {
  //   topicType: '编程题',
  //   topicName: '矩阵旋转',
  //   topicContent:
  //     '给定一个n×n的二维矩阵，表示一个图像。编写一个函数，将图像顺时针旋转90度。要求原地旋转，不能使用额外的矩阵空间。',
  //   topicAnswer:
  //     '这道题需要我们将一个n×n的矩阵顺时针旋转90度，且不能使用额外的矩阵空间。\n\n以下是实现代码：\n```python\ndef rotate(matrix):\n    n = len(matrix)\n    \n    # 先进行转置操作（行变列）\n    for i in range(n):\n        for j in range(i, n):\n            matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]\n    \n    # 再对每一行进行反转\n    for i in range(n):\n        matrix[i] = matrix[i][::-1]\n    \n    return matrix\n```\n\n**解析**：\n1. 首先获取矩阵的大小n。\n2. 进行转置操作：将矩阵的行和列互换。这里我们只需要遍历矩阵的上三角部分（j从i开始），因为下三角部分已经在之前的交换中处理过了。\n3. 对每一行进行反转：将转置后的矩阵的每一行逆序排列。\n4. 返回旋转后的矩阵。\n\n**时间复杂度**：O(n²)，其中n是矩阵的边长。我们需要遍历矩阵中的每个元素。\n**空间复杂度**：O(1)，只使用了常数级的额外空间。',
  // },
  // {
  //   topicType: '编程题',
  //   topicName: '括号匹配',
  //   topicContent:
  //     "给定一个只包含字符 '(', ')', '{', '}', '[' 和 ']' 的字符串，判断该字符串是否有效。有效字符串需满足：\n1. 左括号必须用相同类型的右括号闭合。\n2. 左括号必须以正确的顺序闭合。\n3. 空字符串被认为是有效的。",
  //   topicAnswer:
  //     '这道题可以使用栈（Stack）这种数据结构来解决。栈的特点是后进先出（LIFO），非常适合处理括号匹配问题。\n\n以下是实现代码：\n```python\ndef isValid(s):\n    # 创建一个映射，存储左右括号的对应关系\n    mapping = {")": "(", "}": "{", "]": "["}"\n    # 创建一个栈\n    stack = []\n    \n    # 遍历字符串中的每个字符\n    for char in s:\n        # 如果是右括号\n        if char in mapping:\n            # 从栈中弹出一个元素\n            top_element = stack.pop() if stack else \'#\'\n            # 检查弹出的元素是否与当前右括号匹配\n            if mapping[char] != top_element:\n                return False\n        else:\n            # 如果是左括号，直接入栈\n            stack.append(char)\n    \n    # 如果栈为空，说明所有括号都匹配成功\n    return not stack\n```\n\n**解析**：\n1. 创建一个映射（字典），存储右括号到左括号的对应关系，这样可以方便地查找与右括号匹配的左括号。\n2. 创建一个空栈，用于存储左括号。\n3. 遍历字符串中的每个字符：\n   - 如果是右括号，从栈中弹出一个元素（如果栈为空，则弹出一个特殊字符\'#\'），检查弹出的元素是否与当前右括号匹配。如果不匹配，则返回False。\n   - 如果是左括号，直接将其压入栈中。\n4. 遍历结束后，如果栈为空，说明所有括号都匹配成功，返回True；否则返回False。\n\n**时间复杂度**：O(n)，其中n是字符串的长度。我们只需要遍历字符串一次。\n**空间复杂度**：O(n)，最坏情况下，所有字符都是左括号，需要将它们全部压入栈中。',
  // },
  // {
  //   topicType: '编程题',
  //   topicName: '文件单词统计',
  //   topicContent:
  //     '编写一个函数，接受一个文本文件路径作为参数，统计文件中每个单词出现的次数，并返回出现次数最多的前10个单词及其出现次数。要求忽略大小写，且不统计标点符号。',
  //   topicAnswer:
  //     '这道题需要我们读取文件内容，对单词进行统计，并找出出现次数最多的前10个单词。\n\n以下是实现代码：\n```python\ndef top_10_words(file_path):\n    # 创建一个字典，用于存储单词及其出现次数\n    word_count = {}\n    \n    try:\n        # 打开文件\n        with open(file_path, \'r\', encoding=\'utf-8\') as file:\n            # 读取文件内容\n            content = file.read().lower()  # 转换为小写\n            \n            # 替换所有标点符号为空格\n            for char in "!?.,;:\\"\'()[]{}" + "-" + "—":\n                content = content.replace(char, \' \')\n            \n            # 分割单词\n            words = content.split()\n            \n            # 统计每个单词的出现次数\n            for word in words:\n                word_count[word] = word_count.get(word, 0) + 1\n    \n    except FileNotFoundError:\n        print(f"文件 \'{file_path}\' 不存在")\n        return []\n    except Exception as e:\n        print(f"读取文件时出错: {e}")\n        return []\n    \n    # 找出出现次数最多的前10个单词\n    top_words = sorted(word_count.items(), key=lambda x: x[1], reverse=True)[:10]\n    \n    return top_words\n```\n\n**解析**：\n1. 创建一个空字典`word_count`，用于存储单词及其出现次数。\n2. 使用`with`语句打开文件，确保文件操作完成后自动关闭。\n3. 读取文件内容并转换为小写，以便忽略大小写差异。\n4. 遍历所有标点符号，将它们替换为空格，这样可以避免标点符号影响单词的分割。\n5. 使用`split()`方法将文本分割成单词列表。\n6. 遍历单词列表，统计每个单词的出现次数，存储在`word_count`字典中。\n7. 使用`sorted()`函数对字典中的项按照值（出现次数）进行降序排序，并取前10个元素。\n8. 返回排序后的结果。\n\n**时间复杂度**：O(n + m log m)，其中n是文件中的单词数量，m是不同单词的数量。读取和处理文件需要O(n)的时间，排序需要O(m log m)的时间。\n**空间复杂度**：O(m)，需要存储不同单词及其出现次数。',
  // },
  {
    topicType: '编程题',
    topicName: '字典合并',
    topicContent:
      '编写一个函数，接受两个字典作为参数，返回一个合并后的字典。如果两个字典中有相同的键，则将对应的值相加（假设值都是数字）。',
    topicAnswer:
      '这道题需要我们合并两个字典，如果有相同的键，则将对应的值相加。\n\n以下是实现代码：\n```python\ndef merge_dicts(dict1, dict2):\n    # 创建一个新字典，初始化为dict1的副本\n    result = dict1.copy()\n    \n    # 遍历dict2中的每个键值对\n    for key, value in dict2.items():\n        # 如果key已经在result中，则将对应的值相加\n        if key in result:\n            result[key] += value\n        else:\n            # 否则，直接将键值对添加到result中\n            result[key] = value\n    \n    return result\n```\n\n**解析**：\n1. 创建一个新字典`result`，初始化为`dict1`的副本，这样可以保留`dict1`中的所有键值对。\n2. 遍历`dict2`中的每个键值对：\n   - 如果键已经存在于`result`中，则将对应的值相加。\n   - 如果键不存在于`result`中，则将该键值对直接添加到`result`中。\n3. 返回合并后的字典`result`。\n\n**时间复杂度**：O(n + m)，其中n是`dict1`中的键值对数量，m是`dict2`中的键值对数量。我们需要遍历两个字典中的所有键值对。\n**空间复杂度**：O(n + k)，其中k是`dict2`中独有的键的数量。合并后的字典最多包含`dict1`中的所有键和`dict2`中独有的键。',
  },
];
