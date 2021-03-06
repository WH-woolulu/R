## R-25일차(2018.1.30)

# 역행렬
P <- matrix(c(-2,1,1,-1,0,1,0,1,0), 3, 3)
P
P %*% solve(P)

solve
hilbert

hilbert <- function(n) { i <- 1:n; 1 / outer(i - 1, i, "+") }
h8 <- hilbert(8); h8
sh8 <- solve(h8)
round(sh8 %*% h8, 3)
A <- hilbert(4)
A[] <- as.complex(A)
## might not be supported on all platforms
try(solve(A))
x <- 1:9; names(x) <- x
# Multiplication & Power Tables
x %o% x
y <- 2:8; names(y) <- paste(y,":", sep = "")
outer(y, x, "%%")


## Information Technology -> Data Technology

'''
[알리바바 마윈] "세상은 지금 IT시대에서 DT시대로 가고 있다."

# Big Data : 우량아
- 기존의 관리 및 분석체계로는 감당할 수 없을 정도의 거대한 데이터의 집합 

# Big Data 특성

Volume
Variety
Velocity

# Big Data 기술
- 엄청남 양의 데이터가 실시간 발생될 때 무질서한 것처럼 보이는 데이터 속에서 특징 또는
  일정한 패턴을 찾아내는 기술

# 통계를 왜 배워야 하는가?
- 통계학은 데이터에서 의미를 찾아내는 방법을 다루는 학문, 
  빅데이터 기술의 기본은 바로 통계학이다. 

# 자료(DATA)
- 데이터는 어떠한 가치 판단을 할 수 있는 근거가 되는 재료
- 자료는 문제를 해결하기 위한 원재료로서 처리되지 않는 문자, 숫자, 이미지...
- 정치, 경제, 사회, 문화 어떤 현상을 분석하고 문제의 해결방안을 제시하여
  미래를 예측하기 위해서는 먼저 자료를 수집하고 분석해야 한다.

# 용어
- 모집단 : 관심있는 연구대상 전체 집합
- 모수 : 모집단의 특성을 나타내는 수 
- 표본 : 모집단을 닮은 모집단의 부분집합 
- 통계량 : 표본의 특성을 나타내는 수 

# 통계분석을 위해 자료를 수집
- 개체 : 관찰대상, 조사대상(신입사원, 성인남녀 만 19세 이상)
- 요인 : 개체에 관한 특성 중 연구자가 관심을 갖는 특성(신입사원 경력사항, 신체조건, 경제조건)
- 변수 : 요인의 특성을 수치화하기 위해 쓰이는 속성 
         (신인사원 : 키, 몸무게, 가슴둘레, 발크기, 시력, 허리둘레, 혈액형)
         (경력사항 : 학위, 근무연수, 직무)
- 측정 : 개체의 특성, 요인을 수치화 하는 것         



             연구대상
             ------------  
             흡연아빠의 신생아의 문제점

                |
  
              요 인
              -----------
              흡연아빠의 영향

                |
  
    -------------------------      
    |                       |
  
  변 수                   척 도
----------              -----------
  신생아 몸무게           g(비율척도)

    |                       |
    -------------------------
                |
  
              자 료
              ------------
              홍길동, 2940


사회조사분석사

수집 -> 정리, 요약 -> 추측


# 통계적으로 처리하는 방법

# 기술통계학(Descriptive Statistics)
- 수집된 자료를 정리, 요약하여 수치, 표, 그래프로 자료의 특징을 파악

# 추측통계학(Inferential Statistics)
- 모집단의 일부인 표본을 분석하여 모집단에 대한 추측하고 일반화 시키는 연구분야

새로운 가설이 맞는지 틀리는지를 검증

대통령 선거 당일 2000명으로 추측한 당선 후보 예상 득표율?
  
  5000개의 형광등에서 50개 샘플로 조사한 형광등 수명으로 불량품 예측?
  
  수집된 자료의 형태

# 양적자료(숫자, 크기), 측정되는 값

연속형자료 : 키, 몸무게
이산형자료 : 출생아수, 남학생수, 우리반 남학생들의 왼손잡이수

# 질적자료(성별, 자료가 내포하고 있는 의미)

순위형자료 : 학점(A,B,C,D,F), 매우좋음, 좋음, 보통, 나쁨 
(의미가 중요하고 그중에 순서가 중요하다)
명목형자료 : 남자, 여자(구별하기 위해서), 혈액형, 거주지역
요약방법                  자료정리                      그래프              예
질적자료 도표, 그래프 도수분포표(table), 막대그래프, wordcloud 분할표(pivot) 원그래프

양적자료 수치, 그래프 산술평균 히스토그램 (연속자료) 중앙값 (넓이가 중요) 표준편차 상자도표 분산 시계열도표
최대값, 최소값 산점도

평균에는 기하평균, 조화평균

도수분포표(Frequency Distribution)

- 처음 조사된 원자료는 그 자료의 특징 및 분포를 파악하기 어렵다.

- 처음 조사된 원자료를 구간을 나누거나 돗수를 세거나 해서 정리하여 자료의
구조적 특징을 파악하는 표 

- 미리 구간을 설정해 놓고 각 구간의 범위안에 조사된 데이터 값들이 몇개씩
속하는가를 표시한다

- 계급(class) : 각 구간

- 도수(frequency) : 각 구간(계급)에 속한 데이터 값들의 개수 
'''


#[문제185]

library(reshape2)  # melt()
grade <- readLines("c:/r/grade.txt")
grade

grade1 <- unlist(strsplit(grade, " "))
grade1

grade2 <- table(grade1)
grade2

grade3 <- as.data.frame(grade2)
names(grade3) <- c("grade", "cnt")
grade3

library(colorspace)
bp <- barplot(grade2, ylim = c(0,20), col = heat_hcl(8), las = 1,
              main = "성적별 인원분포", xlab = "성적", ylab = "인원수(명)", 
              border = "green")
abline(h = seq(1,20,1), lty = 3, col = "grey50")
text(x = bp, y = grade2, label = paste0(grade2,"명"), pos = 3)