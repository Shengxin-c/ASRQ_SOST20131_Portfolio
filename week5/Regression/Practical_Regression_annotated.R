# ============================================
# 教材名称：《Statistics: An Introduction Using R》（R 语言统计入门）
# 作者：Michael J. Crawley
# ============================================
rm(list = ls())

setwd("C:/Users/30834/iCloudDrive/Year3/SOST20131/week5/SOST20131_30031")

# ============================================
# 代码 1：基础知识（教材第 1-23 页）
# ============================================

# 下面开始绘制用于说明"最大似然估计"原理的图形

x <- c(1,3,4,6,8,9,12)                         # 创建自变量 x 向量（含 7 个观测值）
y <- c(5,8,6,10,9,13,12)                       # 创建因变量 y 向量（含 7 个观测值）
windows(14,6)                                  # 打开一个宽 14 英寸、高 6 英寸的图形窗口
par(mfrow=c(1,3))                              # 将图形窗口设置为 1 行 3 列的布局
plot(x,y,pch=21,bg="blue",ylim=c(0,15))        # 绘制 x-y 散点图：实心圆点、蓝色填充、y 轴范围 0~15
abline(0,0.6793,col="red")                     # 添加截距为 0、斜率为 0.6793 的红色直线
plot(x,y,pch=21,bg="blue",ylim=c(0,15))        # 再次绘制同一散点图（第 2 个子图）
abline(8,0.6793,col="red")                     # 添加截距为 8、斜率为 0.6793 的红色直线
plot(x,y,pch=21,bg="blue",ylim=c(0,15))        # 第三次绘制同一散点图（第 3 个子图）
abline(lm(y~x))                                # 添加 y 对 x 的最小二乘回归直线（默认黑色）
abline(lm(y~x),col="blue")                     # 用蓝色再次绘制同一条回归直线（覆盖显示）

plot(x,y,pch=21,bg="blue",ylim=c(0,15))        # 重新绘制散点图（第 1 个子图）
abline(4.8273,1.5,col="red")                   # 添加截距 4.8273、斜率 1.5 的红色直线
plot(x,y,pch=21,bg="blue",ylim=c(0,15))        # 重新绘制散点图（第 2 个子图）
abline(4.8273,0.2,col="red")                   # 添加截距 4.8273、斜率 0.2 的红色直线
plot(x,y,pch=21,bg="blue",ylim=c(0,15))        # 重新绘制散点图（第 3 个子图）
abline(lm(y~x))                                # 添加 y 对 x 的最小二乘回归直线
abline(lm(y~x),col="blue")                     # 用蓝色再次绘制回归直线

# 下面演示如何为实验设计随机分配处理（treatment）

treatments <- c("aloprin","vitex","formixin","panto","allclear")  # 创建包含 5 种处理名称的字符向量

# 使用 sample 函数为 1~5 号培养皿中活跃的昆虫随机打乱处理分配

sample(treatments)                             # 对处理名称做一次随机排列（每次运行结果不同）

# 下面这段代码会产生警告信息，原因是同名变量出现在两个被 attach 的数据框中

first.frame <- read.csv("data/test.pollute.csv")   # 读取 test.pollute.csv 到数据框 first.frame
second.frame <- read.csv("data/ozone.data.csv")    # 读取 ozone.data.csv 到数据框 second.frame
attach(first.frame)                            # 将 first.frame 挂载到搜索路径（可直接用其列名）
attach(second.frame)                           # 将 second.frame 也挂载（可能与前者有同名列，产生警告）

# 以下才是避免这类问题的正确做法

first.frame <- read.csv("data/test.pollute.csv")   # 重新读取 first.frame 数据
second.frame <- read.csv("data/ozone.data.csv")    # 重新读取 second.frame 数据
attach(first.frame)                            # 先只挂载 first.frame

# ........
# 在这里处理 first.frame 中的信息
# 处理完成后再继续
# ........

detach(first.frame)                            # 从搜索路径中卸载 first.frame
attach(second.frame)                           # 再挂载 second.frame，避免同名变量冲突

# ============================================
# 代码 2：数据框（教材第 23-34 页）
# ============================================

# 从名为 worms.csv 的文件读取数据，创建名为 worms 的数据框

worms <- read.csv("data/worms.csv")            # 读取 worms.csv 到数据框 worms
names(worms)                                   # 查看 worms 的所有列名

attach(worms)                                  # 挂载 worms 以便直接用列名访问
worms                                          # 打印整个 worms 数据框

# 选取所有行、但只保留第 1 到第 3 列

worms[,1:3]                                    # 用行列索引取前 3 列的全部行

# 选取所有列、但只保留第 5 到第 15 行

worms[5:15,]                                   # 取第 5~15 行的全部列

# 选取所有列、但只保留满足条件（Area>3 且 Slope<3）的行

worms[Area>3 & Slope <3,]                      # 用逻辑条件筛选 Area 大于 3 且 Slope 小于 3 的行

# 按 Area 递增顺序对行进行排序

worms[order(Area),]                            # 用 order(Area) 返回的索引对行按 Area 升序排列

# 只保留数值型数据的列（第 2、3、5、7 列）

worms[order(Area),c(2,3,5,7)]                  # 按 Area 排序后仅选取第 2、3、5、7 列

# 按第 5 列降序排序，并只保留第 5、7 两列

worms[rev(order(worms[,5])),c(5,7)]            # 先按第 5 列升序取索引再反转实现降序，并取第 5、7 列

# 使用 tapply 在指定数据框上分组计算

with(worms,tapply(Worm.density,Vegetation,mean))  # 按 Vegetation 分组计算 Worm.density 的均值

# 使用 aggregate 按因子水平汇总多个变量

aggregate(worms[,c(2,3,5,7)],list(Vegetation),mean)  # 按 Vegetation 分组对第 2、3、5、7 列求均值

aggregate(worms[,c(2,3,5,7)],list(Community=Vegetation),mean)  # 同上，但给分组列命名为 Community

# 多个解释变量的分组汇总

aggregate(worms[,c(2,3,5,7)],                 # 指定要汇总的数值列（第 2、3、5、7 列）
          list(Moisture=Damp,Community=Vegetation),mean)  # 按 Damp 与 Vegetation 双因子分组求均值

# 对比 aggregate 与 tapply 的用法

with(worms,tapply(Slope,list(Damp,Vegetation),mean))  # 用 tapply 按 Damp 与 Vegetation 交叉分组求 Slope 均值

# 开始绘制数据图形

data <- read.csv("data/das.csv")               # 读取 das.csv 到数据框 data
attach(data)                                   # 挂载 data
head(data)                                     # 查看 data 的前 6 行

# 找出离群点（outlier）的具体位置

which(y > 10)                                  # 找出 y 大于 10 的观测所在的行号
y[50]                                          # 查看第 50 个 y 值（即离群点的具体数值）

# 绘制带分类解释变量的图形

yields <- read.csv("data/fertyield.csv")       # 读取 fertil yield（肥料产量）数据
attach(yields)                                 # 挂载 yields
head(yields)                                   # 查看 yields 前 6 行
table(treatment)                               # 统计 treatment 各水平的频数
which(treatment == "nitogen")                  # 找出 treatment 等于 "nitogen" 的行号
detach(yields)                                 # 卸载 yields，释放搜索路径

# ============================================
# 代码 5：单样本（教材第 66-80 页）
# ============================================

# 单样本分析

data <- read.csv("data/example.csv")           # 读取 example.csv 到数据框 data
attach(data)                                   # 挂载 data
names(data)                                    # 查看 data 的列名

summary(y)                                     # 输出变量 y 的描述性统计（最小值、分位数、均值等）

boxplot(y)                                     # 绘制 y 的箱线图

hist(y)                                        # 绘制 y 的直方图

# 绘制地毯图（rug plot），在坐标轴上用小竖线标出每个数据点

length(table(y))                               # 统计 y 中不同取值的个数（去重后数量）
plot(range(y),c(0,10),type="n",xlab="y values",ylab="")  # 创建空白坐标框架，x 为 y 的范围，y 轴 0~10
for (i in 1:100) lines(c(y[i],y[i]),c(0,1),col="blue")   # 循环为前 100 个点各画一条蓝色小竖线

# 设计直方图的组距（bin width）

(max(y)-min(y))/10                             # 极差除以 10，估算组距

diff(range(y))/11                              # 极差除以 11，另一种组距估算方式

# 模拟掷双骰子的赌博游戏（craps）

score <- 2:12                                  # 双骰子可能的总点数范围 2~12

ways <- c(1,2,3,4,5,6,5,4,3,2,1)               # 每个点数对应的组合方式数量（例如 7 有 6 种组合）

( game <- rep(score,ways) )                    # 按组合数重复各点数，构造总体分布并打印

sample(game,1)                                 # 从总体中随机抽取一次（模拟掷一次双骰子）

outcome <- numeric(10000)                      # 预分配长度为 10000 的数值向量存放结果
for (i in 1:10000) outcome[i] <- sample(game,1)  # 循环 10000 次，每次模拟掷一次骰子
hist(outcome,breaks=(1.5:12.5))                # 绘制 10000 次结果的直方图，断点设在 1.5~12.5

mean.score <- numeric(10000)                   # 预分配长度为 10000 的向量存放样本均值
for (i in 1:10000) mean.score[i] <- mean(sample(game,3))  # 每次抽 3 个骰子点数求均值，重复 10000 次
hist(mean.score,breaks=(1.5:12.5))             # 绘制 10000 个样本均值的直方图

mean(mean.score)                               # 计算 10000 个样本均值的均值（近似总体均值）
sd(mean.score)                                 # 计算样本均值分布的标准差（即标准误）

xv <- seq(2,12,0.1)                            # 生成 2~12、步长 0.1 的横坐标序列
yv <- 10000*dnorm(xv,mean(mean.score),sd(mean.score))  # 用正态密度函数计算对应纵坐标并乘样本量
hist(mean.score,breaks=(1.5:12.5),ylim=c(0,3000),col="yellow", main="")  # 绘制均值直方图，黄色填充、无标题
lines(xv,yv,col="red")                         # 在直方图上叠加红色正态分布曲线

# 标准正态分布

standard.deviations <- seq(-3,3,0.01)          # 生成 -3~3、步长 0.01 的序列（以标准差为单位）
pd <- dnorm(standard.deviations)               # 计算标准正态分布在各点的概率密度
plot(standard.deviations,pd,type="l",col="blue")  # 绘制标准正态分布密度曲线（蓝色折线）

pnorm(-2)                                      # 计算标准正态分布小于 -2 的累积概率
pnorm(-1)                                      # 计算标准正态分布小于 -1 的累积概率
1-pnorm(3)                                     # 计算标准正态分布大于 3 的累积概率（右侧尾部）

qnorm(c(0.025,0.975))                          # 计算 0.025 和 0.975 分位点对应的标准正态分位数

# 为标准正态分布的双侧尾部区域着色

xv<-seq(-3,3,0.01)                             # 生成 -3~3、步长 0.01 的横坐标序列
yv<-dnorm(xv)                                  # 计算对应概率密度
plot(c(-3,3),c(0,0.3),xlim=c(-3,3),ylim=c(0,0.4),type="n",ylab="pd",xlab="standard deviations")  # 创建空白坐标框架
polygon(c(1.96,1.96,-1.96,-1.96,xv[105:496]),c(yv[496],0,0,yv[105],yv[105:496]),col="green")  # 用绿色填充中间 95% 区域
polygon(c(-1.96,-1.96,xv[1],xv[1:104]),c(yv[104],0,0,yv[1:104]),col="red")  # 用红色填充左尾区域
polygon(c(xv[601],xv[601],1.96,1.96,xv[497:601]),c(yv[601],0,0,yv[496:601]),col="red")  # 用红色填充右尾区域
text(0,0.2,"95%",cex=2)                        # 在图中标注 "95%" 文字（放大 2 倍）
lines(xv,yv,col="blue")                        # 叠加蓝色正态密度曲线

# 使用标准正态分布进行计算

ht <- seq(150,190,0.01)                        # 生成身高序列 150~190、步长 0.01（厘米）
plot(ht,dnorm(ht,170,8),type="l",col="brown",  # 绘制均值为 170、标准差为 8 的身高正态分布曲线（棕色）
     ylab="Probability density",xlab="Height") # 设置 y 轴标签"概率密度"、x 轴标签"身高"

pnorm(-1.25)                                   # 计算身高标准化后小于 -1.25 的累积概率

pnorm(1.875)                                   # 计算身高标准化后小于 1.875 的累积概率
1 - pnorm(1.875)                               # 计算身高标准化后大于 1.875 的累积概率

pnorm(1.25) - pnorm(-0.625)                    # 计算标准化身高落在 -0.625 到 1.25 之间的概率

# 绘制四个正态分布组成的面板图

par(mfrow=c(2,2))                              # 将图形窗口设置为 2 行 2 列布局

ht <- seq(150,190,0.01)                        # 重新生成身高序列 150~190
pd <- dnorm(ht,170,8)                          # 计算均值为 170、标准差为 8 的正态密度

plot(ht,dnorm(ht,170,8),type="l",col="brown",  # 第 1 个子图：绘制完整正态分布曲线
     ylab="Probability density",xlab="Height") # 设置坐标轴标签

plot(ht,dnorm(ht,170,8),type="l",col="brown",  # 第 2 个子图：再次绘制正态分布曲线
     ylab="Probability density",xlab="Height") # 设置坐标轴标签
yv <- pd[ht<=160]                              # 取身高 <=160 对应的密度值（左尾部分）
xv <- ht[ht<=160]                              # 取身高 <=160 对应的横坐标值
xv <- c(xv,160,150)                            # 补上边界点以闭合多边形
yv <- c(yv,yv[1],yv[1])                        # 补上密度值使多边形闭合
polygon(xv,yv,col="orange")                    # 用橙色填充身高 <=160 的区域

plot(ht,dnorm(ht,170,8),type="l",col="brown",  # 第 3 个子图：再次绘制正态分布曲线
     ylab="Probability density",xlab="Height") # 设置坐标轴标签
xv <- ht[ht>=185]                              # 取身高 >=185 对应的横坐标值（右尾部分）
yv <- pd[ht>=185]                              # 取身高 >=185 对应的密度值
xv <- c(xv,190,185)                            # 补上边界点以闭合多边形
yv <- c(yv,yv[501],yv[501])                    # 补上密度值使多边形闭合
polygon(xv,yv,col="blue")                      # 用蓝色填充身高 >=185 的区域

plot(ht,dnorm(ht,170,8),type="l",col="brown",  # 第 4 个子图：再次绘制正态分布曲线
     ylab="Probability density",xlab="Height") # 设置坐标轴标签
xv <- ht[ht>=160 & ht <= 180]                  # 取身高在 160~180 之间的横坐标值
yv <- pd[ht>=160 & ht <= 180]                  # 取身高在 160~180 之间的密度值
xv <- c(xv,180,160)                            # 补上边界点以闭合多边形
yv <- c(yv,pd[1],pd[1])                        # 补上密度值使多边形闭合
polygon(xv,yv,col="green")                     # 用绿色填充身高 160~180 的区域

# 绘制用于检查偏态（skewness）的图形

data <- read.csv("data/skewdata.csv")          # 读取 skewdata.csv 偏态数据
attach(data)                                   # 挂载 data
qqnorm(values)                                 # 绘制 values 的正态 QQ 图（检验正态性）
qqline(values,lty=2)                           # 在 QQ 图上添加虚线参考线

# 光速（speed of light）数据

light <- read.csv("data/light.csv")            # 读取 light.csv 光速测量数据
attach(light)                                  # 挂载 light
names(light)                                   # 查看 light 的列名
hist(speed)                                    # 绘制 speed（光速）的直方图
summary(speed)                                 # 输出 speed 的描述性统计

# ============================================
# 代码 7：回归（教材第 114-134 页）
# ============================================

# 请阅读教材第 7 章第 114-134 页并运行以下代码

# 绘制正文中的示意图

plot(c(0,10),c(0,100),xlab="",ylab="",type="n") # 创建空白坐标框架（x 0~10、y 0~100）
lines(c(0,10),c(80,10),lwd=2)                  # 画一条从 (0,80) 到 (10,10) 的粗线

# 截距 = 80

lines(c(0,0),c(0,80),col="green")              # 画绿色竖线标示截距（y 轴从 0 到 80）
lines(c(0,-10),c(80,80),col="red")             # 画红色水平线标示截距 80 的位置

# 斜率 = -7

lines(c(2,8),c(24,24),col="brown")             # 画棕色水平线用于斜率计算（高差对应 42）
lines(c(2,2),c(66,24),col="blue")              # 画蓝色竖线标示对应的高差（66-24=42）

# 单宁（tannin）示例

reg.data <- read.csv("data/tannin.csv")        # 读取 tannin.csv（单宁浓度与生长数据）
attach(reg.data)                               # 挂载 reg.data
names(reg.data)                                # 查看 reg.data 的列名

plot(tannin,growth,pch=21,bg="blue")           # 绘制 tannin（单宁）与 growth（生长）的散点图

lm(growth~tannin)                              # 拟合 growth 对 tannin 的线性模型并输出系数
abline(lm(growth~tannin),col="green")          # 在散点图上添加绿色回归直线

fitted <- predict(lm(growth~tannin))           # 用拟合模型计算每个观测的拟合值（预测值）
fitted                                         # 打印拟合值向量
lines(c(0,0),c(12,11.7555555))                 # 画一条竖线示意某点的观测值与拟合值之差

# 残差（residuals）

for (i in 1:9)                                 # 对前 9 个观测点循环
  lines (c(tannin[i],tannin[i]),c(growth[i],fitted[i]),col="red")  # 用红色竖线连接观测值与拟合值（即残差）

# 估计最大似然斜率

b <-  seq(-1.43,-1,0.002)                      # 生成候选斜率序列 -1.43~-1、步长 0.002
sse <- numeric(length(b))                      # 预分配与 b 等长的向量存放残差平方和
for (i in 1:length(b)) {                       # 遍历每个候选斜率
  a <- mean(growth)-b[i]*mean(tannin)          # 由候选斜率反解出对应的截距 a
  residual <- growth - a - b[i]*tannin         # 计算该斜率下的残差
  sse[i] <- sum(residual^2)                    # 计算残差平方和（SSE）并存入 sse[i]
}

plot(b,sse,type="l",ylim=c(19,24))             # 绘制 SSE 随斜率变化的曲线
arrows(-1.216,20.07225,-1.216,19,col="red")    # 用红色箭头标示最小 SSE 对应的斜率位置
abline(h=20.07225,col="green",lty=2)           # 画绿色虚线标示最小 SSE 值
lines(b,sse)                                   # 再次叠加 SSE 曲线

b[which(sse==min(sse))]                        # 找出使 SSE 最小的斜率值

# 修正的平方和（corrected sums of squares）

SSX <- sum(tannin^2)-sum(tannin)^2/length(tannin)  # 计算 x 的修正平方和 SSX
SSY <- sum(growth^2)-sum(growth)^2/length(growth)  # 计算 y 的修正平方和 SSY
SSXY <- sum(tannin*growth)-sum(tannin)*sum(growth)/length(tannin)  # 计算交叉修正平方和 SSXY

# 绘制教材 box 7.5 的示意图

plot(c(0,10),c(0,10),xlab="",ylab="",type="n") # 创建空白坐标框架
abline(h=5,lty=2)                              # 画水平虚线标示 y 的均值位置
lines(c(0,10),c(8,2))                          # 画回归直线（从 (0,8) 到 (10,2)）
text(2,6.2,expression(hat(y) - bar(y)))        # 标注表达式：拟合值减均值
text(2,8.45,expression(y - hat(y)))            # 标注表达式：观测值减拟合值
arrows(7,5,7,9.5,code=3,length=0.1)            # 画双向箭头标示总变异
arrows(1,5,1,7.4,code=3,length=0.1)            # 画双向箭头标示已解释变异
arrows(1,9.5,1,7.4,code=3,length=0.1)          # 画双向箭头标示未解释变异（残差）
points(1,9.5,pch=16)                           # 在 (1,9.5) 处画一个实心点表示观测值
text(8,7.4,expression(y - bar(y)))             # 标注总变异表达式
text(0.2,5,expression(bar(y)))                 # 标注均值符号
text(.2,7.4,expression(hat(y)))                # 标注拟合值符号
text(.2,9.5,"y")                               # 标注观测值 y

# 在 R 中建立回归模型

model <- lm(growth~tannin)                     # 拟合 growth 对 tannin 的线性回归模型
summary(model)                                 # 输出模型的完整摘要（系数、R²、F 检验等）
summary.aov(model)                             # 输出模型的方差分析表（ANOVA）

par(mfrow=c(2,2))                              # 设置图形布局为 2 行 2 列
plot(model)                                    # 绘制模型的四幅诊断图（残差图、QQ 图等）

# ================================================================
# ==================== 延伸阅读（further reading）=================
# 选读内容：教材第 135-150 页
# ================================================================

# 非线性关系示例

par(mfrow=c(1,1))                              # 恢复图形布局为 1 行 1 列
data <- read.csv("data/decay.csv")             # 读取 decay.csv（衰减数据）
attach(data)                                   # 挂载 data
names(data)                                    # 查看 data 的列名

plot(time,amount,pch=21,col="blue",bg="green") # 绘制 time（时间）与 amount（数量）的散点图

abline(lm(amount~time),col="red")              # 用红色直线拟合（线性近似，实际关系非线性）
summary(lm(amount~time))                       # 输出线性拟合的摘要（R² 较低说明拟合不佳）

plot(time,log(amount),pch=21,col="blue",bg="red")  # 绘制 time 与对数 amount 的散点图（对数变换）
abline(lm(log(amount)~time),col="blue")        # 对对数变换后的数据做线性拟合并画蓝色直线

model <- lm(log(amount)~time)                  # 建立 log(amount) 对 time 的线性模型
summary(model)                                 # 输出该模型的摘要

par(mfrow=c(1,1))                              # 恢复图形布局为 1 行 1 列
plot(time,amount,pch=21,col="blue",bg="green") # 重新绘制原始散点图
xv <- seq(0,30,0.25)                           # 生成 0~30、步长 0.25 的横坐标序列
yv <- 94.38536 * exp(-0.068528 * xv)           # 用指数函数计算对应的拟合曲线纵坐标
lines(xv,yv,col="red")                         # 叠加红色指数衰减拟合曲线

# 二次关系（quadratic relationship）的图形形态

par(mfrow=c(2,2))                              # 设置图形布局为 2 行 2 列
curve(4+2*x-0.1*x^2,0,10,col="red",ylab="y")   # 绘制开口向下的二次曲线（-0.1x²+2x+4）
curve(4+2*x-0.2*x^2,0,10,col="red",ylab="y")   # 绘制开口更窄向下的二次曲线
curve(12-4*x+0.3*x^2,0,10,col="red",ylab="y")  # 绘制开口向上的二次曲线（0.3x²-4x+12）
curve(4+0.5*x+0.1*x^2,0,10,col="red",ylab="y") # 绘制开口向上的二次曲线（0.1x²+0.5x+4）

model2 <- lm(amount~time)                      # 建立仅含线性项的模型 model2
model3 <- lm(amount~time+I(time^2))            # 建立含线性项与二次项的模型 model3
summary(model3)                                # 输出二次模型的摘要
AIC(model2,model3)                             # 用 AIC 准则比较两个模型（越小越好）
anova(model2,model3)                           # 用方差分析检验二次项是否显著

# 使用 nls 进行非线性回归

deer <- read.csv("data/jaws.csv")              # 读取 jaws.csv（鹿下颌骨数据）
attach(deer)                                   # 挂载 deer
names(deer)                                    # 查看 deer 的列名
par(mfrow=c(1,1))                              # 恢复图形布局为 1 行 1 列
plot(age,bone,pch=21,bg="lightgrey")           # 绘制 age（年龄）与 bone（骨长）的散点图

model <- nls(bone~a-b*exp(-c*age),start=list(a=120,b=110,c=0.064))  # 用三参数指数模型做非线性拟合
summary(model)                                 # 输出非线性模型的摘要

model2 <- nls(bone~a*(1-exp(-c*age)),start=list(a=120,c=0.064))  # 用两参数渐近模型做非线性拟合
anova(model,model2)                            # 比较两个非线性模型的拟合优度

av <- seq(0,50,0.1)                            # 生成 0~50、步长 0.1 的年龄序列用于预测
bv <- predict(model2,list(age=av))             # 用 model2 预测新年龄对应的骨长
lines(av,bv,col="blue")                        # 叠加蓝色拟合曲线
summary(model2)                                # 输出 model2 的摘要

null.model <- lm(bone ~ 1)                     # 建立仅含截距的空模型（用于对比）
summary.aov(null.model)                        # 输出空模型的方差分析表

# 广义加性模型（GAM）

library(mgcv)                                  # 加载 mgcv 包（用于拟合 GAM）
hump <- read.csv("data/hump.csv")              # 读取 hump.csv（驼峰型关系数据）
names(hump)                                    # 查看 hump 的列名

# 说明：原脚本用 attach(hump) 会让 hump 的 x、y 被全局变量遮蔽（本脚本开头已定义全局 x、y），
# 导致 gam() 报"唯一协变量组合不足"错误；这里改用 data= 显式指定数据，更规范且可复现。

model <- gam(y ~ s(x), data = hump)            # 用平滑样条 s(x) 拟合 y 的广义加性模型（data= 显式指定数据源）

plot(model, col = "blue")                      # 绘制 GAM 的平滑项拟合图（蓝色）
points(hump$x, hump$y - mean(hump$y), pch = 21, bg = "red")  # 叠加中心化后的原始数据点（红色实心）
summary(model)                                 # 输出 GAM 模型的摘要
