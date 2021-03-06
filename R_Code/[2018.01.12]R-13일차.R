## R-13일차(2018.1.12)

#[문제155] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 SQL 점수를 막대그래프로 출력해주세요.

exam
barplot(exam$grade[exam$subject == "SQL"],
        names.arg = exam$name[exam$subject == "SQL"],
        main = "SQL 점수",
        ylim = c(0, 100),
        cex.names = 0.7,
        col = topo.colors(NROW(exam$name[exam$subject == "SQL"])), density = 40)
abline(h = seq(0,100,10), lty = 3, col = "red")
box()

#선생님 풀이
graphics.off()
par(mfrow=c(1,1))  # 행열 
par(mfrow=c(2,2))

barplot(exam[exam$subject=='SQL','grade'], ylim=c(0,100),
        names.arg=exam[exam$subject=='SQL','name'],
        main='SQL 점수',
        las=2,
        col=rainbow(length(exam[exam$subject=='SQL','name'])))
box()  # box 나타내려면 


#[문제156] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 R 점수를 막대그래프로 출력해주세요.

barplot(exam$grade[exam$subject == "R"],
        names.arg = exam$name[exam$subject == "R"],
        ylim = c(0, 100),
        cex.names = 0.7,
        col = topo.colors(nrow(ex_158)), density = 40)

#선생님 풀이
barplot(exam[exam$subject=='R','grade'], ylim=c(0,100),
        names.arg=exam[exam$subject=='R','name'],
        main='R 점수',
        las=2,
        col=rainbow(length(exam[exam$subject=='R','name'])))

box()


#[문제157] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 PYTHON 점수를 막대그래프로 출력해주세요.

barplot(exam$grade[exam$subject == "PYTHON"],
        names.arg = exam$name[exam$subject == "PYTHON"],
        ylim = c(0, 100),
        cex.names = 0.7,
        col = topo.colors(nrow(ex_158)), density = 40)

#선생님 풀이
barplot(exam[exam$subject=='PYTHON','grade'], ylim=c(0,100),
        names.arg=exam[exam$subject=='PYTHON','name'],
        main='PYTHON 점수',
        las=2,
        col=rainbow(length(exam[exam$subject=='PYTHON','name'])))

box()


#[문제158] exam.csv file에는 학생들의 시험점수가 있습니다. 학생들의 과목 총 점수를 막대그래프로 출력하세요.

#그룹화 집계값 구하는 방법
aggregate(grade ~ name, exam, sum)

library(plyr)
ex_158 <- ddply(exam, 'name', summarise, sum_grade = sum(grade))

library(sqldf)
sqldf("select name, sum(grade) sum_grade
      from exam
      group by name")

library(dplyr)
exam%>%
  group_by(name)%>%
  summarise_at('grade', sum)
barplot(ex_158$sum_grade,
        names.arg = ex_158$name,
        main = "총점수",
        ylim = c(0,300),
        cex.name = 0.7,
        col = topo.colors(nrow(ex_158)), density = 40)

#선생님 풀이
exam_t <- aggregate(grade ~ name, exam, sum)

barplot(exam_t$grade, 
        ylim=c(0,300),
        names.arg=exam_t$name,
        main='과목 총 점수',
        las=2,
        col=rainbow(length(exam_t$name)))
graphics.off()
par(mfrow=c(2,2))

barplot(exam[exam$subject=='SQL','grade'], ylim=c(0,100),
        names.arg=exam[exam$subject=='SQL','name'],
        main='SQL 점수',
        las=2,
        col=rainbow(length(exam[exam$subject=='SQL','name'])))
box()

barplot(exam[exam$subject=='R','grade'], ylim=c(0,100),
        names.arg=exam[exam$subject=='R','name'],
        main='R 점수',
        las=2,
        col=rainbow(length(exam[exam$subject=='R','name'])))

box()

barplot(exam[exam$subject=='PYTHON','grade'], ylim=c(0,100),
        names.arg=exam[exam$subject=='PYTHON','name'],
        main='PYTHON 점수',
        las=2,
        col=rainbow(length(exam[exam$subject=='PYTHON','name'])))

box()

exam_t <- aggregate(grade ~ name, exam, sum)

barplot(exam_t$grade, 
        ylim=c(0,300),
        names.arg=exam_t$name,
        main='과목 총 점수',
        las=2,
        col=rainbow(length(exam_t$name)))
box()


#[문제159] 학생들의 이름을 기준으로 과목점수를 스택형 막대그래프로 생성하세요.

#sol.1
x1 <- exam[exam$subject == "SQL", c("name","grade")]
x2 <- exam[exam$subject == "R", c("name","grade")]
x3 <- exam[exam$subject == "PYTHON", c("name","grade")]

names(x1)[2] <- "SQL"
names(x2)[2] <- "R" 
names(x3)[2] <- "PYTHON"  

x1;x2;x3  
ex_159 <- merge(merge(x1, x2), x3)
str(ex_159)
ex_159
barplot(t(as.matrix(ex_159[,2:4])),
        names.arg = ex_159[,1],
        beside = FALSE,
        main = "성적표",
        ylim = c(0,300),
        cex.names = 0.7,
        col = topo.colors(3), density = 40,
        legend.text = names(ex_159)[-1],
        args.legend = list(cex = 0.5))

#sol.2
t_159 <- t(tapply(exam$grade, list(exam$name, exam$subject), sum))
t_159
barplot(t_159, 
        cex.names = 0.7, cex.axis = 0.7,
        legend.text = rownames(t_159), args.legend = list(cex = 0.5))

#선생님 풀이
t <- tapply(exam$grade, list(exam$subject, exam$name), sum)

bp <- barplot(t, names.arg=names(t), ylim=c(0,350),
              xlab='이름', ylab='성적',
              col=c('blue','green','purple'),
              main='과목별 점수',
              las=2)
legend('topright',
       legend=rownames(t),
       title='과목',
       pch=15,
       col=c('blue','green','purple'),
       cex=0.9, pt.cex=1)


#[문제160] 학생들의 이름을 기준으로 과목점수를 그룹형 막대그래프로 생성하세요.

barplot(t(as.matrix(ex_159[,2:4])),
        names.arg = ex_159[,1],
        beside = TRUE,
        main = "성적표",
        ylim = c(0,100),
        cex.names = 0.7,
        col = topo.colors(3), density = 40,
        legend.text = names(ex_159)[-1],
        args.legend = list(cex = 0.5))
barplot(t_159, 
        beside = TRUE,
        ylim = c(0,100),
        cex.names = 0.7, cex.axis = 0.7,
        legend.text = rownames(t_159), args.legend = list(cex = 0.5))
abline(h=seq(0,100,20), col='black',lty=3)
box()

#선생님 풀이
bp <- barplot(t, names.arg=names(t), beside=TRUE, ylim=c(0,110),
              xlab='이름', ylab='성적',
              col=c('blue','green','purple'),
              main='과목별 점수',
              las=2)
legend('topright',
       legend=rownames(t),
       title='과목',
       pch=15,
       col=c('blue','green','purple'),
       cex=0.8, pt.cex=0.6)
plot(cars, main = "Stopping Distance versus Speed")
lines(stats::lowess(cars))


#[문제161] 창업건수.csv 파일에 데이터 중에 년도별 치킨집 창업 건수를 막대그래프로 생성하세요.

opn <- read.csv("C:/R/창업건수.csv", header = T, stringsAsFactors = F) cls <- read.csv("C:/R/폐업건수.csv", header = T, stringsAsFactors = F)

class(opn$X)
t <- tapply(opn$치킨, opn$X, max)
barplot(t, main = "치킨집 창업건수", ylim = c(0,1500)) ; box()
abline(h = seq(0,1400,200), lty = 3)

#선생님 풀이
create_cnt <- read.csv("c:/r/창업건수.csv",header=T) drop_cnt <- read.csv("c:/r/폐업건수.csv",header=T)

create_cnt drop_cnt

barplot(create_cnt$치킨,main="년도별 치킨집 창업건수", names.arg=create_cnt$X,col=('blue'), ylim=c(0,1300) )

class(opn$X)
t <- tapply(opn$치킨, opn$X, max)
barplot(opn$치킨집, names.arg = opn$X, col = "skyblue", 
        main = "치킨집 창업건수", 
        ylim = c(0,1400), cex.axis = 0.9, las = 1)
abline(h = seq(0,1400, 200), lty = 3, col = "red")
box(col = "orange")


#[문제162] 년도별 치킨집 창업, 폐업 건수를 그룹형 막대그래프로 생성하세요.

ex_162 <- rbind(opn$치킨집, cls$치킨집)
ex_162

bp_162 <- barplot(ex_162, names.arg = opn$X, beside = T, 
                  ylim = c(0, 4000), 
                  col = c("orange", "green"), density = 50,
                  legend.text = c("창업","폐업"),
                  las = 1)

text(x = bp_162[ex_162 == max(ex_162)], 
     y = max(ex_162), labels = "AI발병", pos = 3, col = "red")

#선생님 풀이
graphics.off()

x <- rbind(create_cnt$치킨,drop_cnt$치킨) x

barplot(x, main="년도별 치킨집 창업,폐업", names.arg=create_cnt$X,col=c("blue","red"), ylim=c(0,4000), beside=T)

barplot(x, main="년도별 치킨집 창업,폐업", names.arg=create_cnt$X,col=c("blue","red"), ylim=c(0,4000), beside=T, legend=c("창업","폐업") )


#[문제163] 2014 년도 업종별 창업 비율을 원형 그래프로 생성하세요.

opn_2014 <- opn[opn$X==2014, -1]
opn_2014
per <- round(opn_2014 * 100 /sum(opn_2014))
pie(as.numeric(opn_2014), labels = paste(names(opn_2014), per, '%'),
    main = '2014년 업종별 창업비율', font.main = 11,
    init.angle = 110, col = rainbow(ncol(opn_2014)))

#번외 연구 : 자료 추출
subset(opn, X == 2014, select = -1)
filter(opn, X == 2014)[,-1]


#[문제164] 년도를 입력하면 해당 년도의 원형 그래프 생성할 수 있는 함수를 생성하세요.

show_pie(2006)

show_pie <- function(y){
  
  res <- filter(opn, X == y)[,-1]
  per <- round(res*100/sum(res))
  
  pie(as.numeric(res), labels = paste(names(res),per,'%'), 
      init.angle = 110, col = rainbow(ncol(res)),
      main = paste(y,'년 업종별 창업비율'))
  
}

show_pie(2005)
show_pie(2006)
show_pie(2007)
show_pie(2008)
show_pie(2009)
show_pie(2010)
show_pie(2011)
show_pie(2012)
show_pie(2013)
show_pie(2014)

#위 개선안
show_pies <- function(x,y){
  tmp <- y - x + 1
  
  if(tmp%%2 == 0){
    
    par(mfrow = c(2, tmp/2))
    
  } else{
    
    par(mfrow = c(2,(tmp+1)/2))
    
  }
  
  for(i in x:y){
    
    res <- filter(op1, X == i)[,-1]
    per <- round(res*100/sum(res))
    
    pie(as.numeric(res), labels = paste(names(res),per,'%'), 
        init.angle = 110, col = rainbow(ncol(res)),
        main = paste(i,'년 업종별 창업비율'))
    
    box()
  }
}

show_pies(2005, 2014)
round(5/2,0)
5%/%2
par(mfrow=c(1,3))

pie(as.numeric(opn_2014), labels = paste(names(opn_2014), per, '%'),
    main = '2014년 업종별 창업비율', font.main = 11,
    init.angle = 110, col = rainbow(ncol(opn_2014)))


## 13-1. 그래프 사진파일로 저장하기
library(jpeg)
jpeg("c:/r/1.jpg")

pie(as.numeric(opn_2014), labels = paste(names(opn_2014), per, '%'),
    main = '2014년 업종별 창업비율', font.main = 11,
    init.angle = 110, col = rainbow(ncol(opn_2014)))

dev.off()
jpeg("c:/r/2.jpg")
pie(as.numeric(opn_2014), labels = paste(names(opn_2014), per, '%'),
    main = '2014년 업종별 창업비율', font.main = 11,
    init.angle = 110, col = rainbow(ncol(opn_2014)))
dev.off()


## 13-2. 산점도(scatter plot)
# - 주어진 데이터를 점으로 표시해서 흩뿌리 듯, 시각화한 그래프
# - 데이터의 실제값들이 표시되므로 데이터의 분포를 한 눈에 파악할 수 있다.

# * db file scatter read ~ full table scan
# x - y plotting

# 산포도(상관도)
# - 자료에서 2개 항목 간의 관계를 아는데는 산포도가 편리하다.
# - 자료의 분산 상황을 나타내는 수의 값으로 변량과 분포가 주어졌을 때, 
# 변량이 분포의 중심값에 흩어진 정도

# * 회귀분석이 여기서 부터 시작된다

library(help = datasets)  # R 내장된 dataset list check

help(women)
Average Heights and Weights for American Women

"""
Description

This data set gives the average heights and weights for American women aged 30???39.

Format

A data frame with 15 observations on 2 variables.

[,1]	height	numeric	Height (in) 
[,2]	weight	numeric	Weight (lbs) Details
"""

women
str(women)
plot(women$weight)
plot(women$height)
"""
1) type = p(점), l(선), b(점,선), c(b의 선), o(점 위의 선), h(수직선), s(계단형), S, n(나타나지 않음)

2) lty : 선의 유형 0 ~ 6

- 0 : 그리지 않음
- 1 : 실선(기본값)
- 2 : 대시(-)
- 3 : 점
- 4 : 점과 대시
- 5 : 긴 대시
- 6 : 두개의 대시

3) lwd : 선의 굵기(기본값 1)

4) pch : 점의 종류(0 ~ 25)

- 0 ~ 18 : S언어가 사용하던 특수문자
- 19 ~ 25 : R언어가 확장한 특수문자

5) cex : 점의 크기(기본값 1)   
"""
plot(x = women$height, y = women$weight,
     xlab = "키", ylab = "몸무게",
     main = "여성의 키와 몸무게",
     sub = "미국 70년대 기준",
     type = "c", lty = 3, lwd = 2, pch = 23)


## 13-3. Orange data
help("Orange")

a1 <- Orange[Orange$Tree == 1, 2:3]
a1

a2 <- Orange[Orange$Tree == 2, 2:3]
a2

a3 <- Orange[Orange$Tree == 3, 2:3]
a3

a4 <- Orange[Orange$Tree == 4, 2:3]
a4

a5 <- Orange[Orange$Tree == 5, 2:3]
a5
plot(a1$age, a1$circumference, type = 'o', pch = 1, axes = FALSE, 
     xlim = c(110,1600), ylim = c(30,210), col = "red", xlab = "age", ylab = "circumference",
     lwd = 1)
lines(a2$age, a2$circumference, type = 'o', pch = 2, col = "blue")
lines(a3$age, a3$circumference, type = 'o', pch = 3, col = "black")
lines(a4$age, a4$circumference, type = 'o', pch = 4, col = "darkgreen")
lines(a5$age, a5$circumference, type = 'o', pch = 5, col = "orange")

axis(side = 2)
axis(side = 1)
box()

legend('topleft', legend = c('Tree1','Tree2','Tree3','Tree4','Tree5'),
       col = c("red", "blue","black","darkgreen","orange"), pch = c(1:5), lty = 1)
w <- data.frame(sal = emp$SALARY * 12, 
                w_day = as.numeric(as.Date(Sys.Date()) - as.Date(emp$HIRE_DATE, format='%Y-%m-%d')))

plot(x = w$w_day,       # x좌표
     y = w$sal,         # y좌표
     xlab = "근무일수",      # x축 이름
     ylab = "연봉",      # y축 이름
     main = "근무일수에 따른 연봉 관계",
     sub = "emp테이블 기준",
     type = "p",         
     lty = 4,
     lwd = 2,
     pch = 20)

scatter.smooth(w$w_day, w$sal, 
               xlab="근무일수", ylab="연봉", main="근무일수에 따른 연봉 관계", 
               span=2/3, degree=1, 
               lpars = list(col='orange',lwd=2,lty=2), pch=20, 
               col=ifelse(w$sal==max(w$sal),"red","blue"))