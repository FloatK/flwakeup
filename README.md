# WakeUp 课程表

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.41-blue?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.11-blue?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/license-Non--Commercial-red" alt="License">
</p>

一款基于 Flutter 的课程表 App，支持手动添加课程、周视图展示、学期配置，数据本地持久化。

> 当前处于 **第一期 MVP** 阶段，第二期（教务系统课表导入）和第三期（通知提醒）正在规划中。

---

## 功能

### 第一期 MVP ✓

- **周视图课表** — 8列 × 12行网格，清晰展示每周课程
- **课程管理** — 添加、编辑、删除课程，支持多时间段配置
- **颜色标记** — 8 种预设颜色 + 自定义，课程一目了然
- **周次切换** — 左右箭头切换查看不同周次的课程
- **学期配置** — 设置开学日期和总周数，自动计算当前周
- **数据持久化** — SQLite 本地存储，重启不丢失
- **单双周支持** — 课程可设全周/单周/双周模式

### 规划中

| 阶段 | 功能 |
|------|------|
| 第二期 | 教务系统课表导入（强智/正方）、多课表管理、JSON 导出导入、分享 |
| 第三期 | 浅色/深色主题、Android 桌面小部件、上课提醒通知 |

---

## 技术栈

| 类别 | 技术 |
|------|------|
| 框架 | Flutter 3.x + Dart 3 |
| 状态管理 | Riverpod（`@riverpod` 代码生成） |
| 数据库 | Drift（SQLite） |
| 路由 | go_router |
| 序列化 | freezed + json_serializable |
| 架构 | Clean Architecture（core → data → domain → presentation） |

---

## 项目结构

```
lib/
├── main.dart                         # 入口，初始化数据库 & ProviderScope
├── app.dart                          # MaterialApp.router，主题 & 路由
├── core/
│   ├── constants/                    # AppColors, AppStrings
│   ├── theme/                        # Material 3 主题
│   └── utils/                        # 日期工具
├── data/
│   ├── models/                       # freezed 数据模型 (Course, TimeDetail)
│   ├── datasources/                  # Drift 数据库 & 示例数据
│   └── repositories/                 # 仓库实现
├── domain/
│   └── repositories/                 # 仓库接口
└── presentation/
    ├── pages/                        # 页面（周视图、添加/编辑、学期设置）
    ├── widgets/                      # 可复用组件
    └── providers/                    # Riverpod Provider
```

---

## 快速开始

### 环境要求

- Flutter 3.x
- Dart 3.x
- Windows / macOS / Linux / Android / iOS

### 运行

```bash
# 安装依赖
flutter pub get

# 生成代码（freezed, drift, riverpod）
dart run build_runner build --delete-conflicting-outputs

# 运行
flutter run
```

### 开发

```bash
# 持续代码生成（修改模型/provider 后自动生成）
dart run build_runner watch --delete-conflicting-outputs

# 代码检查
flutter analyze
```

---

## 数据模型

```dart
Course {
  String id;              // UUID
  String name;            // 课程名
  String teacher;         // 教师
  String? location;       // 教室（可选）
  int color;              // 背景色
  List<TimeDetail> timeDetails;  // 时间段列表
}

TimeDetail {
  int dayOfWeek;          // 1=周一, 7=周日
  int startPeriod;        // 起始节次 1-12
  int duration;           // 持续节数 1-3
  List<int> weeks;        // 上课周次
  String singleOrDouble;  // 'all' | 'single' | 'double'
}
```
