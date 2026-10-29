# ============================================
# 教程：简单线性回归（Simple Linear Regression）
# 数据：SHARE_PRICE.csv（股价与公司指标）
# ============================================

suppressPackageStartupMessages(library(dplyr))  # 静默加载 dplyr 包（隐藏启动消息）

# 从远程 CSV 文件读取数据

companyd <- read.csv("https://tanjakec.github.io/mydata/SHARE_PRICE.csv", header=T)  # 读取网络 CSV 到数据框 companyd（首行为表头）

# 查看数据结构

glimpse(companyd)                               # 用 dplyr 的 glimpse 查看各列类型与前几行

# 将部分列转换为因子（factor）类型变量

companyd[, 5] <- as.factor(companyd[, 5])       # 将第 5 列（Competition）转换为因子类型
companyd[, 6] <- as.factor(companyd[, 6])       # 将第 6 列（Sector）转换为因子类型
companyd[, 7] <- as.factor(companyd[, 7])       # 将第 7 列（Type）转换为因子类型

# 浏览数据：思考下面两个函数的区别是什么？

summary(companyd)                               # 输出各列的汇总统计（数值列给出分位数，因子列给出频数）
glimpse(companyd)                               # 输出紧凑的数据结构视图（列类型 + 前几行）

attach(companyd)                                # 挂载 companyd，使列名可直接作为变量使用
names(companyd)                                 # 查看 companyd 的所有列名

plot(Share_Price ~ Profit, cex = .6, main = "Share Price = f(Profit) + e")  # 绘制股价对利润的散点图（点缩小 0.6 倍）
abline(lm(Share_Price ~ Profit))                # （已补全）在散点图上添加最小二乘回归直线

lm(Share_Price ~ Profit)                        # 拟合股价对利润的线性模型并输出截距与斜率
summary(lm(Share_Price ~ Profit))               # 输出该线性模型的完整摘要

# 创建散点图（正式步骤）

plot(Share_Price ~ Profit, cex = .6, main = "Share Price = f(Profit) + e")  # 再次绘制股价对利润的散点图

# 拟合模型

model_1 <- lm(Share_Price ~ Profit)             # 建立线性模型 model_1：Share_Price 对 Profit 回归

# 在散点图上添加最佳拟合直线

abline(model_1, lty = 2, col = 2)               # 用红色虚线在散点图上绘制 model_1 的拟合直线

summary(model_1)$r.squared                      # 提取模型的决定系数 R²（解释变异比例）

summary(model_1)                                # 输出 model_1 的完整摘要

F_crit <- qf(0.95, 1, 58)                       # 计算 F 分布 95% 分位数作为临界值（自由度 1 和 58）
F_crit                                          # 打印 F 临界值（用于与模型 F 统计量比较）

summary(Profit)                                 # 输出解释变量 Profit 的描述性统计

# ============================================
# YOUR TURN：补充分析（练习要求完成）
# 1) Share_Price 与 RD（研发支出）的关系
# 2) Share_Price 与 Turnover（年营收）的关系
# ============================================

# --- 关系 1：Share_Price ~ RD ---

plot(Share_Price ~ RD, cex = .6, main = "Share Price = f(RD) + e")  # 绘制股价对研发支出（RD）的散点图
model_RD <- lm(Share_Price ~ RD)                # 建立线性模型 model_RD：Share_Price 对 RD 回归
abline(model_RD, lty = 2, col = 2)              # 用红色虚线添加 RD 模型的拟合直线
summary(model_RD)$r.squared                     # 输出 RD 模型的决定系数 R²
summary(model_RD)                               # 输出 RD 模型的完整摘要

# --- 关系 2：Share_Price ~ Turnover ---

plot(Share_Price ~ Turnover, cex = .6, main = "Share Price = f(Turnover) + e")  # 绘制股价对营收（Turnover）的散点图
model_Turnover <- lm(Share_Price ~ Turnover)    # 建立线性模型 model_Turnover：Share_Price 对 Turnover 回归
abline(model_Turnover, lty = 2, col = 2)        # 用红色虚线添加 Turnover 模型的拟合直线
summary(model_Turnover)$r.squared               # 输出 Turnover 模型的决定系数 R²
summary(model_Turnover)                         # 输出 Turnover 模型的完整摘要
