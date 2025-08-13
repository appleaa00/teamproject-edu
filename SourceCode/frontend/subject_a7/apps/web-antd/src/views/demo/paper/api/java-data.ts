export const topicChoice = [
  {
    topicType: '选择题',
    topicName: '以下哪个不是 Java 的基本数据类型？',
    topicAnswer:
      "Java 的基本数据类型包括 byte、short、int、long、float、double、char 和 boolean。\n" +
      "而 String 是封装类（引用类型），并非基本数据类型，用于表示字符串对象。",
    topicOptions: [
      { sorted: 'A', optionContent: 'int', rightAnswer: false },
      { sorted: 'B', optionContent: 'boolean', rightAnswer: false },
      { sorted: 'C', optionContent: 'String', rightAnswer: true },
      { sorted: 'D', optionContent: 'char', rightAnswer: false }
    ]
  },
  {
    topicType: '选择题',
    topicName:
      '执行以下代码的输出结果是？\n```java\nint x = 5;\nint y = x++;\nSystem.out.println(x + \",\" + y);\n```',
    topicAnswer:
      "`x++` 是后增量操作：先将 x 的值（5）赋给 y，再对 x 自增 1。\n" +
      "因此，y 的值为 5，x 自增后变为 6，最终输出 `6,5`。",
    topicOptions: [
      { sorted: 'A', optionContent: '5,5', rightAnswer: false },
      { sorted: 'B', optionContent: '6,5', rightAnswer: true },
      { sorted: 'C', optionContent: '5,6', rightAnswer: false },
      { sorted: 'D', optionContent: '6,6', rightAnswer: false }
    ]
  },
  {
    topicType: '选择题',
    topicName: '以下哪个集合类是线程安全的？',
    topicAnswer:
      "Vector 和 Hashtable 是 Java 早期提供的线程安全集合类，通过 synchronized 实现同步。\n" +
      "而 ArrayList、HashMap 是非线程安全的；ConcurrentHashMap 是 Java 1.5 后提供的高性能线程安全 Map。",
    topicOptions: [
      { sorted: 'A', optionContent: 'ArrayList', rightAnswer: false },
      { sorted: 'B', optionContent: 'Vector', rightAnswer: true },
      { sorted: 'C', optionContent: 'HashMap', rightAnswer: false },
      { sorted: 'D', optionContent: 'LinkedList', rightAnswer: false }
    ]
  },
  {
    topicType: '选择题',
    topicName:
      '以下代码的输出结果是？\n```java\nclass Parent {\n    void method() { System.out.println(\"Parent\"); }\n}\nclass Child extends Parent {\n    void method() { System.out.println(\"Child\"); }\n}\npublic class Test {\n    public static void main(String[] args) {\n        Parent p = new Child();\n        p.method();\n    }\n}\n```',
    topicAnswer:
      "这是 Java 多态的典型应用：父类引用指向子类对象时，调用的是子类重写后的方法。\n" +
      "Child 类重写了 Parent 的 method() 方法，因此输出 `Child`。",
    topicOptions: [
      { sorted: 'A', optionContent: 'Parent', rightAnswer: false },
      { sorted: 'B', optionContent: 'Child', rightAnswer: true },
      { sorted: 'C', optionContent: '编译错误', rightAnswer: false },
      { sorted: 'D', optionContent: '运行时异常', rightAnswer: false }
    ]
  },
  {
    topicType: '选择题',
    topicName: 'Java 中访问修饰符的作用范围由大到小排序正确的是？',
    topicAnswer:
      "Java 访问修饰符的作用范围：\n" +
      "1. public：所有类可见\n" +
      "2. protected：同包或子类可见\n" +
      "3. 默认（无修饰符）：同包可见\n" +
      "4. private：仅当前类可见",
    topicOptions: [
      { sorted: 'A', optionContent: 'public > protected > private > 默认', rightAnswer: false },
      { sorted: 'B', optionContent: 'public > 默认 > protected > private', rightAnswer: false },
      { sorted: 'C', optionContent: 'public > protected > 默认 > private', rightAnswer: true },
      { sorted: 'D', optionContent: 'protected > public > 默认 > private', rightAnswer: false }
    ]
  },
  {
    topicType: '选择题',
    topicName:
      '以下关于 Java 异常处理的说法正确的是？',
    topicAnswer:
      "Checked 异常（如 IOException）必须显式处理（try-catch 或 throws），否则编译错误；\n" +
      "Unchecked 异常（如 NullPointerException）无需显式处理；\n" +
      "`finally` 块中的代码无论是否发生异常都会执行（除非 JVM 退出）。",
    topicOptions: [
      { sorted: 'A', optionContent: '所有异常都必须使用 try-catch 处理', rightAnswer: false },
      { sorted: 'B', optionContent: 'finally 块中的代码不一定会执行', rightAnswer: false },
      { sorted: 'C', optionContent: 'RuntimeException 是 Unchecked 异常', rightAnswer: true },
      { sorted: 'D', optionContent: 'Error 可以通过 try-catch 捕获', rightAnswer: false }
    ]
  },
  {
    topicType: '选择题',
    topicName:
      '执行以下代码的输出结果是？\n```java\nString s1 = \"abc\";\nString s2 = new String(\"abc\");\nSystem.out.println(s1 == s2);\nSystem.out.println(s1.equals(s2));\n```',
    topicAnswer:
      "`s1` 使用字符串字面量创建，存储在常量池；`s2` 使用 new 关键字创建，存储在堆内存。\n" +
      "`==` 比较的是引用地址（不同），`equals()` 比较的是字符串内容（相同），因此输出 `false` 和 `true`。",
    topicOptions: [
      { sorted: 'A', optionContent: 'true\ntrue', rightAnswer: false },
      { sorted: 'B', optionContent: 'false\nfalse', rightAnswer: false },
      { sorted: 'C', optionContent: 'true\nfalse', rightAnswer: false },
      { sorted: 'D', optionContent: 'false\ntrue', rightAnswer: true }
    ]
  },
  {
    topicType: '选择题',
    topicName: '以下哪个关键字用于跳出多层循环？',
    topicAnswer:
      "`break` 只能跳出当前一层循环；`continue` 跳过当前循环的剩余步骤；\n" +
      "`return` 用于方法返回；而 **标签 + break** 可以跳出多层循环，例如：\n" +
      "`outer: for(...) { inner: for(...) { break outer; } }`。",
    topicOptions: [
      { sorted: 'A', optionContent: 'break', rightAnswer: false },
      { sorted: 'B', optionContent: 'continue', rightAnswer: false },
      { sorted: 'C', optionContent: 'return', rightAnswer: false },
      { sorted: 'D', optionContent: '标签 + break', rightAnswer: true }
    ]
  },
  {
    topicType: '选择题',
    topicName:
      '以下代码的输出结果是？\n```java\nint[] arr = {1, 2, 3, 4};\nfor (int i = 0; i < arr.length; i++) {\n    if (i == 2) break;\n    System.out.print(arr[i] + \" \");\n}\n```',
    topicAnswer:
      "循环从 i=0 开始，当 i=2 时执行 `break` 跳出循环。\n" +
      "因此，i=0 输出 1，i=1 输出 2，i=2 时跳出，最终输出 `1 2`。",
    topicOptions: [
      { sorted: 'A', optionContent: '1 2 3', rightAnswer: false },
      { sorted: 'B', optionContent: '1 2', rightAnswer: true },
      { sorted: 'C', optionContent: '1 2 3 4', rightAnswer: false },
      { sorted: 'D', optionContent: '1', rightAnswer: false }
    ]
  },
  {
    topicType: '选择题',
    topicName: 'Java 中接口和抽象类的区别正确的是？',
    topicAnswer:
      "接口（interface）只能包含抽象方法和常量（默认 public static final），不能有构造方法；\n" +
      "抽象类（abstract class）可以包含抽象方法和具体方法，也可以有构造方法；\n" +
      "类可以实现多个接口，但只能继承一个抽象类。",
    topicOptions: [
      { sorted: 'A', optionContent: '接口可以有构造方法，抽象类不能', rightAnswer: false },
      { sorted: 'B', optionContent: '抽象类可以有具体方法，接口不能', rightAnswer: true },
      { sorted: 'C', optionContent: '类只能实现一个接口，抽象类可以继承多个', rightAnswer: false },
      { sorted: 'D', optionContent: '接口中的变量可以是实例变量', rightAnswer: false }
    ]
  }
];

export const topicCode = [
  // {
  //   topicType: '编程题',
  //   topicName: '数组元素反转',
  //   topicContent:
  //     "编写一个 Java 方法，将整型数组的元素顺序反转。例如，输入数组 [1, 2, 3, 4, 5]，应返回 [5, 4, 3, 2, 1]。要求原地反转，不使用额外数组空间。",
  //   topicAnswer:
  //     "这道题需要我们在不创建新数组的情况下，通过交换首尾元素实现数组反转。\n\n以下是实现代码：\n```java\npublic class ArrayReverse {\n    public static int[] reverseArray(int[] nums) {\n        // 边界条件：数组为空或长度≤1时直接返回\n        if (nums == null || nums.length <= 1) {\n            return nums;\n        }\n        \n        int left = 0;       // 左指针指向数组起始位置\n        int right = nums.length - 1;  // 右指针指向数组末尾\n        \n        // 首尾元素交换直到左右指针相遇\n        while (left < right) {\n            int temp = nums[left];\n            nums[left] = nums[right];\n            nums[right] = temp;\n            left++;\n            right--;\n        }\n        \n        return nums;\n    }\n    \n    // 测试示例\n    public static void main(String[] args) {\n        int[] arr = {1, 2, 3, 4, 5};\n        int[] reversed = reverseArray(arr);\n        System.out.println(Arrays.toString(reversed));  // 输出: [5, 4, 3, 2, 1]\n    }\n}\n```\n\n**解析**：\n1. **边界处理**：先判断数组是否为空或长度≤1，直接返回避免无效操作。\n2. **双指针法**：使用左指针`left`和右指针`right`分别指向数组首尾，通过交换元素并向中间移动指针实现反转。\n3. **原地操作**：仅使用常数级额外空间（临时变量`temp`），时间复杂度为 O(n)，空间复杂度为 O(1)。\n\n**拓展**：若要反转字符串，可先转换为字符数组，使用相同逻辑处理后再转为字符串。",
  // },
  // {
  //   topicType: '编程题',
  //   topicName: '字符串字母统计',
  //   topicContent:
  //     "编写一个 Java 方法，统计字符串中每个字母（a-z，不区分大小写）出现的次数。例如，输入字符串 \"Hello World!\"，应返回 'h':1, 'e':1, 'l':3, 'o':2, 'w':1, 'r':1, 'd':1。",
  //   topicAnswer:
  //     "这道题需要我们遍历字符串，使用哈希表统计字母出现次数，同时忽略大小写和非字母字符。\n\n以下是实现代码：\n```java\nimport java.util.HashMap;\nimport java.util.Map;\nimport java.util.Map.Entry;\n\npublic class LetterCounter {\n    public static Map<Character, Integer> countLetters(String str) {\n        Map<Character, Integer> letterCount = new HashMap<>();\n        \n        // 边界条件：空字符串直接返回空Map\n        if (str == null || str.isEmpty()) {\n            return letterCount;\n        }\n        \n        // 转换为小写并遍历每个字符\n        for (char c : str.toLowerCase().toCharArray()) {\n            // 检查是否为字母（a-z）\n            if (c >= 'a' && c <= 'z') {\n                // 存在则计数+1，不存在则初始化为1\n                letterCount.put(c, letterCount.getOrDefault(c, 0) + 1);\n            }\n        }\n        \n        return letterCount;\n    }\n    \n    // 测试示例\n    public static void main(String[] args) {\n        String input = \"Hello World!\";\n        Map<Character, Integer> result = countLetters(input);\n        result.forEach((k, v) -> System.out.println(k + \":\" + v));\n        // 输出: h:1, e:1, l:3, o:2, w:1, r:1, d:1\n    }\n}\n```\n\n**解析**：\n1. **数据结构选择**：使用`HashMap<Character, Integer>`存储字母及其计数，键为字符，值为出现次数。\n2. **预处理**：将字符串转为小写（`toLowerCase()`），确保不区分大小写。\n3. **字符过滤**：通过`c >= 'a' && c <= 'z'`判断是否为字母，忽略标点和空格。\n4. **统计逻辑**：使用`getOrDefault(key, defaultValue)`简化代码，避免重复判断键是否存在。\n\n**时间复杂度**：O(n)，n为字符串长度，仅需遍历一次。\n**空间复杂度**：O(26)≈O(1)，最多存储26个字母的计数。",
  // },
  // {
  //   topicType: '编程题',
  //   topicName: '学生成绩统计',
  //   topicContent:
  //     "编写一个 Java 程序，统计学生成绩信息。要求：\n1. 定义学生类（Student），包含姓名和成绩属性；\n2. 计算班级平均分、最高分和最低分；\n3. 找出成绩高于平均分的学生。",
  //   topicAnswer:
  //     "这道题需要我们定义类、使用数组存储学生信息，并实现统计计算逻辑。\n\n以下是实现代码：\n```java\nimport java.util.ArrayList;\nimport java.util.List;\n\npublic class StudentGrades {\n    // 学生类定义\n    static class Student {\n        private String name;\n        private double score;\n        \n        public Student(String name, double score) {\n            this.name = name;\n            this.score = score;\n        }\n        \n        public String getName() { return name; }\n        public double getScore() { return score; }\n        \n        @Override\n        public String toString() {\n            return name + \": \" + score;\n        }\n    }\n    \n    // 统计班级成绩\n    public static void analyzeGrades(Student[] students) {\n        if (students == null || students.length == 0) {\n            System.out.println(\"没有学生数据\");\n            return;\n        }\n        \n        double sum = 0;\n        double max = students[0].getScore();\n        double min = students[0].getScore();\n        \n        // 计算总分、最高分、最低分\n        for (Student s : students) {\n            sum += s.getScore();\n            max = Math.max(max, s.getScore());\n            min = Math.min(min, s.getScore());\n        }\n        \n        double average = sum / students.length;\n        \n        // 收集高于平均分的学生\n        List<Student> aboveAverage = new ArrayList<>();\n        for (Student s : students) {\n            if (s.getScore() > average) {\n                aboveAverage.add(s);\n            }\n        }\n        \n        // 输出统计结果\n        System.out.println(\"班级平均分: \" + average);\n        System.out.println(\"最高分: \" + max);\n        System.out.println(\"最低分: \" + min);\n        System.out.println(\"高于平均分的学生:\");\n        for (Student s : aboveAverage) {\n            System.out.println(\"  \" + s);\n        }\n    }\n    \n    // 测试示例\n    public static void main(String[] args) {\n        Student[] class1 = {\n            new Student(\"张三\", 85),\n            new Student(\"李四\", 92),\n            new Student(\"王五\", 78),\n            new Student(\"赵六\", 95),\n            new Student(\"钱七\", 81)\n        };\n        \n        analyzeGrades(class1);\n    }\n}\n```\n\n**解析**：\n1. **类设计**：内部类`Student`封装姓名和成绩，提供 getter 和 toString 方法。\n2. **统计逻辑**：\n   - 遍历学生数组计算总分、最高分、最低分；\n   - 计算平均分后，再次遍历收集高于平均分的学生。\n3. **数据结构**：使用`ArrayList`存储结果，便于动态添加元素。\n\n**拓展**：若学生数量庞大，可优化为一次遍历完成所有统计，避免重复遍历。",
  // },
  {
    topicType: '编程题',
    topicName: '文件行数统计',
    topicContent:
      "编写一个 Java 方法，统计文本文件的行数。要求：\n1. 处理文件不存在或读取错误的情况；\n2. 支持大文件读取（避免一次性加载全部内容）；\n3. 返回文件的总行数。",
    topicAnswer:
      "这道题需要我们使用 Java IO 流逐行读取文件，统计行数并处理异常。\n\n以下是实现代码：\n```java\nimport java.io.BufferedReader;\nimport java.io.FileReader;\nimport java.io.IOException;\n\npublic class LineCounter {\n    public static int countLines(String filePath) {\n        int lineCount = 0;\n        BufferedReader reader = null;\n        \n        try {\n            // 打开文件并创建缓冲读取器\n            reader = new BufferedReader(new FileReader(filePath));\n            \n            // 逐行读取，不为null时行数+1\n            while (reader.readLine() != null) {\n                lineCount++;\n            }\n        } catch (IOException e) {\n            System.err.println(\"读取文件时出错: \" + e.getMessage());\n        } finally {\n            // 确保关闭流，释放资源\n            if (reader != null) {\n                try {\n                    reader.close();\n                } catch (IOException e) {\n                    System.err.println(\"关闭文件时出错: \" + e.getMessage());\n                }\n            }\n        }\n        \n        return lineCount;\n    }\n    \n    // 测试示例\n    public static void main(String[] args) {\n        String filePath = \"test.txt\";\n        int lines = countLines(filePath);\n        System.out.println(\"文件 \" + filePath + \" 共有 \" + lines + \" 行\");\n    }\n}\n```\n\n**解析**：\n1. **IO 流使用**：\n   - `BufferedReader` 包装 `FileReader`，提供高效的逐行读取能力；\n   - `readLine()` 方法读取一行内容，返回 null 时表示文件末尾。\n2. **异常处理**：\n   - 使用 try-catch 捕获文件不存在（FileNotFoundException）和读取错误（IOException）；\n   - finally 块确保无论是否异常都关闭流，避免资源泄漏。\n3. **大文件支持**：逐行读取而非一次性加载，内存占用为常数级。\n\n**时间复杂度**：O(n)，n为文件行数，每个行读取操作时间固定。\n**空间复杂度**：O(1)，仅使用固定大小的变量。",
  }
];
