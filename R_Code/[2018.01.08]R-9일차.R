## R-9일차(2018.1.8)
 # 9-1. ddply
 # 9-2. function
 # 9-3. 가변인수
 # 9-4. 중첩함수
 # 9-5. adply 함수
 # 9-6. dplyr
  # -6-1. filter
  # -6-2. select
  # -6-3. 복합적으로 사용
  # -6-4. mutate
  # -6-5. summarise


#[문제127] 아래와 같이 결과를 출력하세요.

    DEPARTMENT_ID SALARY
1             10   4400
2             20  19000
3             30  24900
4             40   6500
5             50 156400
6             60  28800
7             70  10000
8             80 304500
9             90  58000
10           100  51608
11           110  20308
12     소속부서X   7000
13          총액 691416

#sol.1 : SQL(group by rollup 안됨)
library(sqldf)
ex_127 <- sqldf("select department_id, sum(salary) salary 
                from emp
                group by department_id")
library(doBy)
ex_127 <- orderBy(~DEPARTMENT_ID ,ex_127)
tot <- colSums(ex_127)
ex_127 <- rbind(ex_127, tot)
ex_127[12:13,]$DEPARTMENT_ID <- c('소속부서X','총액') 
ex_127

#sol.2 : R
ds_tab <- aggregate(SALARY~DEPARTMENT_ID, emp, sum)
ds_tab <- rbind(ds_tab, list('소속부서X', sum(emp[is.na(emp$DEPARTMENT_ID), "SALARY"])))
ds_tab <- rbind(ds_tab, list('총액', sum(emp$SALARY)))
ds_tab

#sol.3 : ddply(오늘 배움)
ddply(emp, 'DEPARTMENT_ID', summarise, SALARY = sum(SALARY))
sol.4 : dplyr(select-)
emp%>%
  group_by(DEPARTMENT_ID)%>%
  summarise(sum_sal = sum(SALARY))


#[문제128] fruits_sales.csv file 읽어 들인 후 과일 이름별 판매량, 판매합계를 구하세요.

#tapply 방법
x <- rbind(tapply(fruits_sales$qty, fruits_sales$name, sum),
           tapply(fruits_sales$price, fruits_sales$name, sum))
rownames(x) <- c("판매량", "판매합계")
x
class(x)
mode(x)
str(x)
y <- cbind(tapply(fruits_sales$qty, fruits_sales$name, sum),
           tapply(fruits_sales$price, fruits_sales$name, sum))
colnames(y) <- c("qty","price")
y
class(y)

#aggregate 방법
x <- aggregate(qty~name, fruits_sales, sum)
y <- aggregate(price~name, fruits_sales, sum)

merge(x,y)

#sqldf 방법
sqldf("select name, sum(qty), sum(price) 
      from fruits_sales
      group by name")


## 9-1. ddply 함수
# 데이터 프레임을 분할하고 함수를 적용한 뒤 결과를 데이터 프레임으로 반환하는 함수

install.packages("plyr")
library("plyr")

# ddply(data, 기준컬럼, func)

# 1) summarise (~ group by) : 기준컬럼의 데이터끼리 모은 후 함수를 적용해서 값을 출력

ddply(emp, 'DEPARTMENT_ID', summarise, sum_sal = sum(SALARY), avg_sal = mean(SALARY))
ddply(emp, 'DEPARTMENT_ID', summarise, var_sal = var(SALARY), sd_sal = sd(SALARY))
ddply(emp, 'DEPARTMENT_ID', summarise, max_sal = max(SALARY), min_sal = min(SALARY))
ddply(emp, c('DEPARTMENT_ID','JOB_ID'), summarise, 
      sum_sal = sum(SALARY), avg_sal = mean(SALARY), sd_sal = sd(SALARY))


#[문제129] fruits_sales.csv file 읽어 들인 후 과일 이름별 판매량, 판매합계를 구하세요. (ddply함수를 이용하세요.)

ddply(fruits_sales, "name", summarise,
      qty = sum(qty), price = sum(price))

#번외 연구
ddply(fruits_sales, "name", summarise,
      avg_qty = mean(qty), sd_qty = round(sd(qty), 2), 
      max_qty = max(qty), min_qty = min(qty))
ddply(fruits_sales, "name", summarise,
      avg_price = mean(price), sd_price = round(sd(price), 2), 
      max_price = max(price), min_price = min(price))
library(lubridate)
aggregate(SALARY~year(emp$HIRE_DATE), emp, max)

aggregate(SALARY~format(as.Date(emp$HIRE_DATE), '%Y'), emp, max)

# 2) trasform : 각 행별로 연산을 수행해서 행당 값을 출력하는 기능(비율값)
ddply(fruits_sales, 'name', transform, s_qty = sum(qty), r_qty = (100*qty) / sum(qty))
ddply(fruits_sales, 'year', transform, s_qty = sum(qty), r_qty = (100*qty) / sum(qty))
ddply(fruits_sales, 'year', transform, x = qty^2, y = price%%qty)


## 9-2. 함수(function)
# - 사용자가 정의하는 함수를 생성할 수 있다.
# - 자주 반복되어 사용하는 기능을 정의하는 프로그램
# - 코드가 간단해 진다.
# - 메모리에 남아서 프로그램 종료전까지 사용가능

함수이름 <- function(){
  함수 수행해야할 코드
  return(반환값)  # 선택사항
}
Sys.date() -> date1()

date1 <- function(){
  return(Sys.Date())
}

date1()
date1
date2 <- function(){
  Sys.Date()
}

date2()
date2
time <- function(){
  Sys.time()
}

time()
time
Sys.Date는 Sys.time을 바라보고 시간값만 제외하고 호출하는 원리
Sys.Date
pl/sql에서 source문을 보기위해서는 select text from user_source... 를 해야함

#입력값 처리
hap <- function(x,y){
  res <- x + y
  return(res)
}

hap(1,2)
hap(2,1)


#[문제130] hap 함수에 인자값을 입력하게 되면 1부터 해서 입력숫자까지 합을 구하세요.
#          hap(n) = 1+2+3+...+9+10+...+n 

#sol.1 : for 반복문
hap_1 <- function(n){     
  
  res <- 0
  
  for(i in 1:n){
    
    res <- res + i  # 누적된 합
    
  }
  return(res)
}

hap_1(1)     # 1
hap_1(2)     # 3
hap_1(10)    # 55
hap_1(100)   # 5050

#sol.2 : 일반식
hap_2 <- function(n){
  
  return(n*(n+1)/2)  # 가우스 합
  
}

hap_2(10)
hap_2(100)

#sol.3 : 재귀호출
hap_3 <- function(n){
  res <- 0
  if(n==1){
    return(1)
  }else if(n > 1){
    res <- n + hap_3(n-1)
  }
  return(res)
}

hap_3(1)
hap_3(10)
hap_3(100)


#[문제131] fac 함수에 인자값을 입력하게 되면 1부터 해서 입력숫자까지 곱을 구하세요.
#          fac(n) = 1*2*3*....*(n-1)*n 

#sol.1 : for 반복문
fac <- function(n){
  res <- 1
  
  if(n > 0){
    
    for(i in 1:n){
      res <- res * i
    }
    return(res)
    
  }else if(n == 0){
    return(res)
  }
}

fac(0)    # 1
fac(1)    # 1
fac(2)    # 2
fac(3)    # 6
fac(4)    # 24
fac(10)   # 3628800
fac(100)  # 9.332622e+157

#sol.2 : 재귀호출
fac <- function(n){
  if(n %in% c(0,1)){
    return(1)    # exit
  }else{
    return(n * fac(n-1))
  }
}

fac(0)
fac(1)
fac(2)
fac(3)
fac(4)
fac(10)

#번외 연구(수열)
gamma
Γ(x) = integral_0^Inf t^(x-1) exp(-t) dt

#피보나치 수열
fibo <- function(n){
  if(n==1||n==2){
    return(1)
  }
  return(fibo(n-1) + fibo(n-2))   # f_n = f_(n-1) + f_(n-2)
}
for(i in 1:10){
  print(paste('fibo(',i,')=',fibo(i)))
}

#황금비율
gold_ratio <- function(n){
  #fibo(n)/fibo(n-1) == gold_ratio(n-1)
  fibo(n)/fibo(n-1)
}

gold_ratio(20)


#[문제132] 사원 번호를 입력 값으로 받아서 사원의 LAST_NAME, SALARY를 출력하는 함수를 생성하세요.

> find(100)
    LAST_NAME SALARY
10      King  24000

#sol.1
find <- function(n){
  emp[emp$EMPLOYEE_ID == n, c("LAST_NAME", "SALARY")]
}

find(100)

#sol.2
find <- function(n){
  subset(emp, emp$EMPLOYEE_ID == n, c(LAST_NAME, SALARY))
}

find(100)

#현재 떠있는 함수들
ls()
# rm(function name) : remove function

f <- function(x, y){
  print(x)
  print(y)
}

f(10,20)     # 위치지정방식
f(y=20,x=10) # 이름지정박식


## 9-3. 가변인수
f <- function(...){
  myargs <- list(...)
  
  for(i in myargs){
    print(i)
  }
}

f(1,2,3,4)
f('a','b','c')
sum(1,2,3)

# ... : 아무나 와라
f <- function(...){
  myargs <- list(...)
  
  for(i in myargs){
    append(myargs, i, after = length(myargs))
  }
  return(myargs)
}

f(1,2,3,4)
f('a','b','c')
f <- function(...){
  myargs <- c(...)
  
  for(i in myargs){
    append(myargs, i, after = length(myargs))
  }
  return(myargs)
}

f(1,2,3,4)
f('a','b','c')
f_1 <- function(...){
  myargs <- c(...)
  var <- NULL
  for(i in myargs){
    var <- c(var,i)  # vector 중첩을 허용하지 안는 성질 응용
  }
  return(var)
}

f_1(1,2,3,4)
f_1('a','b','c')


## 9-4. 중첩함수
f <- function(x,y){
  print(x)
  f2 <- function(y){
    print(y)
  }
  f2(y)
}
f(10,20)
df <- data.frame(name = c('king','smith','jane'),
                 sql = c(97,88,78),
                 python = c(60,70,100))
df
apply(df[,2:3], 1, sum)
apply(df[,2:3], 2, sum)
df[df$sql >= 70 & df$python >= 90, ]

df$sql >= 70 & df$python >= 90


## 9-5. adply 함수
# - 데이터 프레임 값에 대한 로직값의 컬럼을 생성과 동시에 합쳐서 출력
# library(plyr)
df
adply(df, 1, function(x){x$sql >= 70 & x$python >= 90})   # df -> x


## 9-6. dplyr
install.packages("dplyr")
library("dplyr")

# 9-6-1. filter
# - 조건을 주어서 필터링하는 함수 

filter(emp, DEPARTMENT_ID == 10)[,c("EMPLOYEE_ID","LAST_NAME","DEPARTMENT_ID")]
emp[emp$DEPARTMENT_ID == 10, c("EMPLOYEE_ID","LAST_NAME","DEPARTMENT_ID")]
subset(emp, DEPARTMENT_ID == 10, label = c(EMPLOYEE_ID,LAST_NAME,DEPARTMENT_ID))
filter(emp, DEPARTMENT_ID == 10)[,'LAST_NAME']
filter(emp, DEPARTMENT_ID == 10)[,c('LAST_NAME','JOB_ID')]
filter(emp, DEPARTMENT_ID == 10)[,2:5]
filter(emp, DEPARTMENT_ID == 30 & SALARY >= 3000)[,1:5]

# 9-6-2. select
# - 여러 컬럼이 있는 데이터셋에서 특정 컬럼만 선택사용

select(emp, LAST_NAME, SALARY)
select(emp, 1, 2)
select(emp, 1:5)
select(emp, 3,5,6)
select(emp, c(3,5,6))
select(emp, -SALARY, -COMMISSION_PCT, -DEPARTMENT_ID)

# 9-6-3. 여러문장을 조합해서 사용하는 방법
# %>%

emp%>%
  select(LAST_NAME, JOB_ID, SALARY)%>%
  filter(SALARY >= 20000)

emp%>%
  select(LAST_NAME, JOB_ID, SALARY)%>%
  filter(SALARY >= 20000)%>%
  arrange(SALARY)  # 오름차순 정렬 

emp%>%
  select(LAST_NAME, JOB_ID, SALARY)%>%
  filter(SALARY >= 20000)%>%
  arrange(desc(SALARY))  # 내림차순 정렬 

# 9-6-4. mutate
# - 새로운 컬럼을 추가

mutate(emp, sal = SALARY*12)
emp%>%
  select(LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT)%>%
  mutate(ANNUAL_SAL = SALARY*12 + ifelse(is.na(COMMISSION_PCT),
                                         0, SALARY*COMMISSION_PCT))%>%
  arrange(desc(ANNUAL_SAL))

# 9-6-5. summarise
# - 주어진 데이터 집계

emp%>%
  summarise(sum_sal = sum(SALARY), mean_sal = mean(SALARY), 
            max_sal = max(SALARY), min_sal = min(SALARY))

# summarise_at
emp%>%
  group_by(DEPARTMENT_ID)%>%
  summarise_at("SALARY",sum)

emp%>%
  summarise_at(vars(SALARY), sum)

emp%>%
  summarise_at(c("SALARY", "COMMISSION_PCT"), sum, na.rm = T)

# summarise_if
emp%>%
  summarise_if(is.numeric, sum, na.rm = T)  # numeric 값을 가진 모든 column에 대해 합 

emp%>%
  summarise_if(is.numeric, sum, na.rm = T)%>%
  select(-EMPLOYEE_ID, -MANAGER_ID)