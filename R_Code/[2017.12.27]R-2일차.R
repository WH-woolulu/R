# R-2일차(2017-12-27)
  # 2-1. matrix
  # 2-2. array
  # 2-3. factor
  # 2-4. data frame

# [문제16] x 변수에 벡터값 1,2,3,5,6 을 입력한 후 3번째 요소 뒤에 4를 입력하세요.

x <- c(1,2,3,5,6)
x <- append(x,4,after=3)
x

# [문제17] 1부터 3씩 증가하는 10 이하의 정수값을 출력하세요.

seq(1,10,3)
seq(1,10,length.out = 4)  # length.out : 생성할 갯수

# [문제18] 10 부터 20 까지의 값을 x 변수에 생성한 후 원소의 값이 15 이상이고 18 이하인 값들만 출력하세요.

x <- c(10:20)
x
x[x >= 15 & x <= 18]

# [문제19] 10 부터 20 까지의 값을 x 변수에 생성한 후 원소의 값이 15 이상이고 18 이하인 값들만 2곱한 값으로 수정하세요.

x <- c(10:20)
x
x[x >= 15 & x <= 18] <- x[x >= 15 & x <= 18] *2
x
x[x >= 15 & x <= 18] <- ifelse(x >= 15 & x <= 18, x*2, x)
x


## 2-1. matrix
  # 벡터처럼 한가지 유형의 스칼라 값만 저장
  # matrix 함수를 이용해서 행렬을 생성
  # ex) matrix(입력값, nrow = m, ncol = n) m*n 행렬

x <- matrix(c(1:9), nrow = 3)
x

x <- matrix(c(1:9), nrow = 3, ncol = 3)
x

# 입력값 크기보다 행렬크기를 더 크게 만들수는 있으나 주의해서 사용
x <- matrix(c(1:9), nrow = 4, ncol = 3)
x

# dim() : 행 갯수 열 갯수
dim(x)

# byrow = TRUE(FALSE) : TRUE이면 행부터 순서대로 채움(기본값 FALSE, 열부터 채움)
x <- matrix(c(1:9), nrow = 3, byrow = TRUE)
x

x <- matrix(c(1:9), nrow = 3, byrow = FALSE)
x

# dimnames = list(c(),c()) : 메트릭스 생성과 동시에 행과 열에 이름 설정
x <- matrix(c(1:4), nrow = 2, byrow = TRUE, dimnames = list(c("row1","row2"), c("col1","col2")))
x

# dimnames(x) : 메트릭스 생성후, 행과 열 이름 추가하기
x <- matrix(c(1:9), nrow = 3)
x

dimnames(x) <- list(c("a1","a2","a3"), c("c1","c2","c3"))
x

# rownames(x) <- c() : 행이름 추가 / colnames(x) <- c() : 열이름 추가
rownames(x) <- c("r1","r2","r3")
colnames(x) <- c("b1","b2","b3")
x

# rownames(x) <- NULL : 행이름 제거 / colnames(x) <- NULL : 열이름 제거
rownames(x) <- NULL
colnames(x) <- NULL
x

# 벡터를 활용한 행렬표현
cells <- c(1:9)
rname <- c("row1","row2","row3")
cname <- c("col1","col2","col3")
(x <- matrix(cells, nrow = 3, byrow = TRUE, dimnames = list(rname,cname))) # 저장과 동시에 출력도 하고 싶다면 (x <- ...)

# 행렬이름[행인덱스, 열인덱스] : 각 자리의 값들 뽑아내기
x[1,1]
x[2,3]
x[3,2]

# 행열이름[행인덱스(행이름), ] : 각 행 전체
x[2,]
x[1,-2]
x[1,2:3]
x["row1",]

# 행렬이름[,열인데스(열이름)] : 각 열 전체
x[,3]
x[-1,2]
x[,"col1"]

# 행렬이름[행인덱스 범위, 열인덱스 범위]
x[c(1,3),c(2,3)]

# 행렬의 연산
s <- matrix(c(1:4), nrow = 2)
s

s + 1
s - 1
10 - s
s / 2
s * 2
s * s

# %*% : 행렬의 곱(그냥 *은 각 자리 곱셈)
s %*% s

# t(s) : 전치행렬(행과 열의 위치 바꿈)
s
t(s)

# solve(s) : 역행렬
solve(s)

s %*% solve(s)
# nrow(s) : 행의 수, ncol(s) : 열의 수, dim(s) : 행 열의 수

x <- matrix(c(1:6), ncol = 3)
x

# dim()을 통해 행 열의 갯수를 변경할 수 있다.
(dim(x) <- c(3,2))
x

# cbind(x,y) : 열을 기준해서 붙이는 함수
(x <- matrix(c(1:9), nrow = 3))
(y <- matrix(c(-1:-9), nrow = 3))
cbind(x,y)

# rbind(x,y) : 행을 기준해서 붙이는 함수
rbind(x,y)


# [문제20] x 변수에 행렬을 구성하세요. 값은 1부터 10까지 입력하시고 5행 2열으로 만들면서 값은 열을 기준으로 생성하세요.

(x <- matrix(c(1:10), ncol = 2))

# [문제21] x 변수에 열을 기준으로 11,12,13,14,15 값을 추가하세요.

(y <- matrix(c(11:15)))
(x <- cbind(x,y)) 

# [문제22] x 변수에 행을 기준으로 16,17,18 값을 추가하세요.

(z <- matrix(c(16:18), nrow = 1))
(x <- rbind(x,z))

# [문제23] x변수에 6행의 값을 20,21,22 로 수정하세요.

x[6,] <- c(20,21,22)
x

# [문제24] x 변수에 6행을 제거해주세요.

(x <- x[-6,])


## 2-2. Array(배열)
  # 같은 데이터 타입을 갖는 3차원 배열구조
  # matrix는 2차원 행렬, array 3차원 행렬
  # array함수 이용해서 생성
  # 행렬을 array로 생성

(x <- array(c(1:6), dim = c(2,3)))

# array(입력값, dim = c(행,열,면)) 단, 입력값 크기 = 행 * 열 * 면
(x <- array(c(1:24), dim = c(2,3,4)))
x[1,1,]
x[1,,]
x[,2,]
x[,,4]

# 행과 열 이름 지정
dimnames(x)
dimnames(x) <- list(c("r1","r2"), c("c1","c2","c3"))
x

# 구조형태 파악 : mode(x), 입력값 구조
class(x)  
mode(x)       
is.matrix(x)
is.array(x)

# [문제25] x 배열을 생성하세요. 1부터 12까지 값을 가지고있는 배열을 생성하세요. 면은 3개가 만들어지도록하세요.

(x <- array(c(1:12), dim = c(2,2,3), dimnames = list(c("r1","r2"), c("c1","c2"))))

# [문제26] x 배열 변수에 컬럼이름은 'a','b'로 설정하세요.

colnames(x) <- c("a","b")
x

# [문제27] x 배열 변수에 행이름은 'row1','row2'로 설정하세요.

rownames(x) <- c("row1","row2")
x

# [문제28] x 배열 변수에 면을 2로 수정하세요.

x[,,1:2]
(x <- array(c(1:12), dim = c(3,2,2)))

# 선생님 풀이
dim(x) <- c(2,3,2)
dim(x)
x
x[,,1] 


## 2-3. Factor
  # 범주형 : 데이터를 미리 정해진 유형으로 분류가 되어있음
  # ex) level : A, B, C, D, F 학점 '좋음', '보통', '나쁨'
  # 종류 : 1)순서형(ordinal), 2)명목형(nominal)
    # 데이터 간 순서를 둘 수 있는 경우(A,B,C,D,F)
    # 데이터간 크기비교 불가능한 경우(MALE, FEMALE)

# 명목형

(result <- factor("좋음", levels = c("좋음", "보통", "나쁨")))  # levels = 생략가능
str(result)
class(result)
mode(result)

# 순서형 : ordered = TRUE

# result_n에는 "좋음" 이라는 값만 입력됨, level은 명시용
(result_n <- factor("좋음", c("좋음", "보통", "나쁨"), ordered = TRUE))

# ordered = FALSE가 기본값이다
(result_o <- factor("좋음", c("좋음", "보통", "나쁨"), ordered = FALSE))

# nlevels : level 갯수 / levels : level 내부 값
nlevels(result_n)
levels(result_n)
levels(result_n)[1]
levels(result_n)[2]
levels(result_n)[3]

# level 내부값 변경
(levels(result_n) <- c("good", "normal", "bad"))

# is.factor : factor이면 TRUE, 아니면 FALSE / is.ordered : 순서형
is.factor(result_n)
is.factor(result_o)
is.ordered(result_n)
is.ordered(result_o)

# level은 설정 안해도 자동(중복값 단인값만)으로 설정
(gender <- factor(c("male","male","female")))

# ordered : 순서형 factor 바로 만드는 법
(s <- ordered(c("A","B"), c("A","B", "C", "D", "F")))
is.factor(gender)
is.factor(s)

is.ordered(gender)
is.ordered(s)
# "문자" 문자가 아니라 factor형 이라고 한다


# [문제29] 벡터에 있는 값 "large", "medium", "small", "small", "large", "medium" 을 factor 변수로 구성하세요. 
#          변수이름은 x로 생성하시고 levels samall, medium, large 순으로 지정하세요.

x <- factor(c("large", "medium", "small", "small", "large", "medium"), c("small", "medium", "large"), ordered = TRUE)
x <- ordered(c("large", "medium", "small", "small", "large", "medium"), c("small", "medium", "large"))
nlevels(x)
levels(x)
class(x)
mode(x)
is.ordered(x)

# [문제30] x factor형 목록이름중에 small 을 s로 수정하세요.

levels(x)[1] <- "s"
levels(x)
x

# 선생님 풀이
levels(x) == "large"
levels(x)[levels(x) == "large"] <- "l"
x

# factor에서 추가할 때 주의할 점 : 형을 변형해서 넣어야 한다는 불편한 진실
(x <- append(x, "tiny", after = 6))

x <- as.vector(x)  # 1.벡터로 변형
x <- append(x, "tiny", after = 6)  # 2.추가
(x <- as.factor(x))  # 3.


## 2-4. data frame(데이터 프레임) : 많이 사용됨 80% / 행렬과 비슷
  # 각기 다른 데이터 타입을 갖는 컬럼으로 이루어진 2차원 테이블 구조 (DB의 TABLE과 유사함)

# data.frame() 함수를 이용해서 각 컬럼, 행을 구성한다.
df <- data.frame(x = c(1,2,3,4,5), y = c(2,3,4,5,6))
df
mode(df)
class(df)
str(df)
df$x  # x column만 보기
df$y  # y column만 보기

df <- data.frame(name = c("scott","harden","curry"), sql = c(90,80,70), plsql = c(70,80,90))
df

# 열 추가 방법1 : df$추가할 열 <- c(입력값)
df$r <- c(80,70,60)
df

# 열 추가 방법2 : cbind 활용
df$r <- NULL
df
cbind(df, r = c(1,2,3))
rbind(df, c("hong",20,30))

# 특정컬럼을 확인 : 변수$컬럼명
df$name
df$sql
df$plsql
df$r
df[1,]
df[1,1] <- "james"
df[1,2]
df[1,2], df[3,2] = df[c(1,3),2] : 1row 2col, 3row 2col
df[c(1,3),2]
df[-1,-2], df[-1,-3] = df[-1,-c(2,3)] : 1row 2col, 1row 3col 제외한 나머지
df[-1,-c(2,3)]

# column name으로 찾기
df[,c("sql","r")]

# 특정한 컬럼만 출력(벡터형식으로 출력)
df[,"r"]   

# 데이터프레임 형식으로 출력
df[,"r", drop = FALSE] 

# 입력값 수정하기
df$sql[1] <- 100
df$sql[2] <- 90
df
x <- data.frame(1:3)
x

# 행 및 열 이름 변경
colnames(x) <- c("val")
rownames(x) <- c("a","b","c")
x
names(x) <- c("col")  # colnames
x

# 행 및 열 이름으로 부분 출력
df <- data.frame(a = 1:3, b = 4:6, c = 7:9)
df

df[, names(df) %in% c("b", "c")]  # 열이름이 b 나 c 출력
df[, !names(df) %in% c("a")]      # 열이름이 a만 제외 출력

rownames(df) <- c("i","j","k")
df

rownames(df) %in% c("i")
df[rownames(df) %in% c("i","k"), names(df) %in% c("a","b")]

df[1:2,2:3]
df <- data.frame(x = 1:1000)

head(df)
tail(df)
tail(df, n = 10)

# data frame 만들때 문자열들은 factor로 만들어짐(주의사항) -> 입력값 변경이 제한됨
str(df)

# 위 개선방법 : ... stringsAsFactors = FALSE) 기본값은 TRUE
df <- data.frame(name = c("scott","harden","curry"), sql = c(90,80,70), plsql = c(70,80,90), stringsAsFactors = FALSE)
df
str(df)
#'data.frame':	3 obs. of 3 variables:
#  obs : 로우 수
#variables : 컬럼 수

df
dd <- c("kim",100,100)

rbind(df,dd)

r <- c(1,2,3)
cbind(df,r)