# iTunesDemo
项目名称：iTunesDemo

版本：iOS 13+ （要是用Combine）

依赖库：Kingfisher
- (用最少的库实现功能)

管理工具：SPM

支持语言：简体中文、繁体中文、英文

## 功能

- 首页展示收藏列表
- 根据关键字搜索歌曲、专辑、歌手
- 分页加载搜索结果
- 对搜索结果进行媒体类型筛选（没有城市筛选类型，因为iTunes的结果中字段’country’是当前地区，而不是这个艺术品的所属地。）
- 对歌曲进行放入或移除收藏夹
- 对收藏夹进行持久化
## 目录结构

```
--- Page 业务模块
    --- Home 首页
        --- Model
        --- ViewModel
        --- View
    --- Search 搜索
--- View 公共UI
--- Model 公共数据模型
--- ViewModel 公共视图模型
--- Service 公共服务
```

## 技术点

- 分页
    - 使用prefetchDataSource 实现 分页触发
    - 使用ListViewModel 简化分页数据逻辑
- 国际化
    - 使用enum管理key值减少硬编码
- APIService
    - 分离request
- MVVM
  - CaseType
    - 方便为ViewModel 编写测试   
- Combine
- KVDataSotrage
    - 架构上支持多种存储方式。UserDefault，File（json、plist等），Sqlite等
