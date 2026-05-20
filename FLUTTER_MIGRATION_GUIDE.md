# WakeUp课程表 Flutter迁移指南

## 一、项目概述

这是一个Android课程表应用，支持从多个教务系统自动导入课表。原项目使用Kotlin + Jsoup + Retrofit + Room实现。

**核心功能**：通过WebView登录教务系统 → 抓取课表HTML → 解析课程数据 → 存入本地数据库

---

## 二、数据模型

### 2.1 课程基础表 (CourseBaseBean)
```dart
class CourseBase {
  final int id;           // 课程ID
  final String courseName; // 课程名称
  final String color;     // 显示颜色
  final int tableId;      // 课表ID（支持多课表）
}
```

### 2.2 课程详情表 (CourseDetailBean)
```dart
class CourseDetail {
  final int id;          // 关联CourseBase的id
  final int day;         // 星期几 (1=周一, 7=周日)
  final int startNode;   // 开始节次
  final int step;        // 持续节数
  final int startWeek;   // 开始周
  final int endWeek;     // 结束周
  final int type;        // 0=全周, 1=单周, 2=双周
  final String? teacher; // 教师
  final String? room;    // 教室
  final int tableId;     // 课表ID
}
```

### 2.3 导入临时模型 (ImportBean)
```dart
class ImportCourse {
  final String name;      // 课程名
  final String timeInfo;  // 时间信息字符串
  final String? teacher;
  final String? room;
  final int startNode;    // 开始节次
  final int startWeek;
  final int endWeek;
  final int type;         // 0=全周, 1=单周, 2=双周
}
```

---

## 三、支持的教务系统及解析逻辑

### 3.1 苏大正方系统 (type: "FZ")

**识别特征**：
- HTML包含 `id="Table1"`
- 包含"第X节"格式的节次标记

**HTML结构**：
```html
<table id="Table1">
  <tr>
    <td>第1节</td>
    <td>高等数学 {第1-16周} 张三 教学楼301</td>
    <td>英语 {第1-8周} 李四 教学楼502</td>
  </tr>
</table>
```

**解析逻辑**：
```dart
class FzParser {
  // 正则：匹配 {第2-16周} 或 {第2周}
  static final weekPattern = RegExp(r'\{第(\d{1,2})[-]*(\d*)周');
  
  List<ImportCourse> parse(String html) {
    // 1. 解析Table1
    // 2. 遍历tr，识别"第X节"获取当前节次
    // 3. 按空格分割课程信息
    // 4. 用正则提取周次
    // 5. 课程名在周次前，教师/教室在周次后
  }
}
```

**数据格式**：
- 课程名：周次标记前的词
- 周次：`{第1-16周}` → startWeek=1, endWeek=16
- 单双周：`{第1-16周单周}` → type=1
- 教师/教室：周次后的词（顺序不定，需启发式判断）

---

### 3.2 新方正系统 (type: "newFZ")

**识别特征**：
- HTML包含 `id="table1"`（小写）
- 包含 `class="festival"` 的节次元素

**HTML结构**：
```html
<table id="table1">
  <tr>
    <td class="festival">1</td>
    <td id="11">  <!-- id第一位=星期，第二位=节次区块 -->
      <div>
        <p class="title">高等数学</p>
        <p title="教师"><font>张三</font></p>
        <p title="上课地点"><font>教学楼301</font></p>
        <p title="节/周"><font>1-2节(周)1,3,5,7-16周</font></p>
      </div>
    </td>
  </tr>
</table>
```

**解析逻辑**：
```dart
class NewFzParser {
  List<ImportCourse> parse(String html) {
    // 1. 获取festival类元素得到节次
    // 2. 获取td的id属性，第一位为星期
    // 3. 遍历div内的p标签
    // 4. 通过p的title属性区分：教师/上课地点/节/周
    // 5. 解析"节/周"格式："1-2节(周)1,3,5,7-16周"
  }
}
```

**"节/周"格式解析**：
```
"1-2节(周)1,3,5,7-16周"
├── "1-2节" → step = 2 - startNode + 1
└── "1,3,5,7-16周" → 多个周次范围，逗号分隔
    ├── "1" → week 1
    ├── "3" → week 3
    ├── "5" → week 5
    └── "7-16" → weeks 7-16
```

---

### 3.3 强智系统 (type: "qz" / "bjld")

**识别特征**：
- HTML包含 `id="kbtable"`
- 包含 `class="kbcontent"`

**HTML结构**：
```html
<table id="kbtable">
  <tr>
    <td>
      <div class="kbcontent">
        高等数学<br>
        <span title="老师">张三</span><br>
        <span title="教室">教学楼301</span><br>
        <span title="周次(节次)">1-16周(周)</span>
      </div>
    </td>
    <td>
      <div class="kbcontent">
        课程A<br>...<br>...
        -----
        课程B<br>...<br>...  <!-- 同一格多门课用 ----- 分隔 -->
      </div>
    </td>
  </tr>
</table>
```

**解析逻辑**：
```dart
class QzParser {
  List<ImportCourse> parse(String html) {
    // 1. 解析kbtable
    // 2. 行号计算节次：前3行 node=row*2-1，之后 node=row*2-2
    // 3. 列号即星期
    // 4. 用"-----"分割同一格的多门课程
    // 5. 通过title属性提取：老师/教室/周次(节次)
  }
}
```

**节次计算规则**：
```
行1 → node=1 (1*2-1)
行2 → node=3 (2*2-1)
行3 → node=5 (3*2-1)
行4 → node=6 (4*2-2)
行5 → node=8 (5*2-2)
...
特殊：node=5或12时 step=1，其他 step=2
```

---

## 四、通用工具函数

### 4.1 中文数字转换
```dart
int getNodeInt(String nodeStr) {
  const map = {'一':1, '二':2, '三':3, '四':4, '五':5, '六':6, '七':7, '八':8, '九':9};
  return map[nodeStr] ?? 0;
}
```

### 4.2 课程去重判断
```dart
int findExistingCourse(List<CourseBase> list, String name) {
  for (var course in list) {
    if (course.courseName == name) return course.id;
  }
  return -1;
}
```

### 4.3 周次类型判断
```dart
int getWeekType(String weekStr) {
  if (weekStr.contains('单周')) return 1;
  if (weekStr.contains('双周')) return 2;
  return 0;
}
```

---

## 五、Flutter技术方案

### 5.1 依赖选择
```yaml
dependencies:
  webview_flutter: ^4.4.0   # WebView
  html: ^0.15.4             # HTML解析（替代Jsoup）
  dio: ^5.3.0               # HTTP请求
  sqflite: ^2.3.0           # SQLite数据库
  path: ^1.8.0              # 路径处理
```

### 5.2 解析器工厂
```dart
abstract class CourseParser {
  bool canParse(String html);
  List<ImportCourse> parse(String html);
}

class ParserFactory {
  static CourseParser getParser(String html) {
    if (html.contains('id="Table1"')) return FzParser();
    if (html.contains('id="table1"') && html.contains('festival')) return NewFzParser();
    if (html.contains('id="kbtable"')) return QzParser();
    throw UnsupportedError('无法识别的课表格式');
  }
}
```

### 5.3 WebView集成
```dart
// 注入JS获取页面HTML
Future<void> extractHtml(WebViewController controller) async {
  await controller.runJavaScript('''
    var iframes = document.getElementsByTagName("iframe");
    var iframeContent = "";
    for (var i = 0; i < iframes.length; i++) {
      iframeContent += iframes[i].contentDocument.body.parentElement.outerHTML;
    }
    FlutterBridge.postMessage(
      document.getElementsByTagName('html')[0].innerHTML + iframeContent
    );
  ''');
}

// 接收JS消息并解析
void onJsMessage(String html) {
  final parser = ParserFactory.getParser(html);
  if (parser.canParse(html)) {
    final courses = parser.parse(html);
    saveToDatabase(courses);
  }
}
```

---

## 六、关键注意事项

1. **编码问题**：部分教务系统使用GBK编码，需用`dart:convert`的`latin1`解码后再转UTF-8

2. **iframe处理**：课表可能在iframe中，需用JS获取iframe内容拼接

3. **Cookie管理**：登录后的Cookie需持久化，可用`dio`的CookieJar

4. **错误处理**：
   - 网络超时
   - 页面结构变化
   - 登录失效
   - 解析失败

5. **特殊格式**：
   - 多周课程：`"1,3,5,7-16周"` → 需拆分处理
   - 单双周：`"单周"/"双周"` → type=1或2
   - 连续节次：`"1-2节"` → step=2

---

## 七、解析流程图

```
用户操作
    ↓
WebView加载教务系统URL
    ↓
用户登录（账号密码+验证码）
    ↓
导航到课表页面
    ↓
点击"导入"按钮
    ↓
JS注入获取页面HTML（含iframe）
    ↓
ParserFactory自动选择解析器
    ↓
解析器识别HTML特征
    ↓
提取课程信息为ImportCourse列表
    ↓
转换为CourseBase + CourseDetail
    ↓
写入SQLite数据库
    ↓
刷新课表显示
```
