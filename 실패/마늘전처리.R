---
  title: "마늘 재배"
author: "곽명빈"
date: '2021 8 10 '
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(readxl)
library(dplyr)
library(stringr)
library(tidyr)
library(tidyverse)
library(lubridate)
library(knitr)
library(ggplot2)
```
# 마늘

```{r, echo = FALSE, out.width = "75%", fig.align = "left"}
include_graphics("재배환경.PNG")
include_graphics("파종시기.png")
include_graphics("품종선택.png")
include_graphics("마늘생육과정.png")
include_graphics("출하시기.png")
include_graphics("환경.png")

```

# 데이터 읽기
```{r}
weather <- read.csv("강원도 날씨.csv")
garlic <- read.csv("마늘가격.csv")
production <- read.csv("마늘생산량.csv")
garlic <- garlic %>% filter(광역산지 == '강원') #강원지역만 선정
```


```{r}
a <- unique(weather$지점명)
b <- unique(garlic$시군산지)
```

# 데이터 
```{r}
# c <- c('춘천', '철원', '강릉', '동해', '원주', '홍천', '태백', '정선') # 두개 겹치는거 

# weather1 <- weather %>% filter(지점명 == '춘천'|지점명 == '철원'|지점명 == '강릉'|지점명 == '동해'|지점명 == '원주'|지점명 == '홍천'|지점명 == '태백'|지점명 == '정선')

# garlic1 <- garlic %>% filter(시군산지 == '춘천'|시군산지 == '철원'|시군산지 == '강릉'|시군산지 == '동해'|시군산지 == '원주'|시군산지 == '홍천'|시군산지 == '태백'|시군산지 == '정선')


unique(weather1$지점명) 
unique(garlic1$시군산지)
```

# 시점
```{r}
#d <- substr(garlic1$일자, 1, 4) # 연도만 추출해보자

#garlic1 <- cbind(garlic1, d) # d와 마늘을 합치기

#names(garlic1)[names(garlic1)=="d"]="시점" # 열이름을 시점으로 변경

```

```{r}
#all_1 <- merge(garlic1, production, by ="시점") # 시점을 기준으로 합치기

# write.csv(all_1, "마늘+생산.csv")


```

# 마늘 + 생산량 데이터 만들기
```{r}
d1 <- substr(garlic$일자, 1, 4) # 연도만 추출해보자

garlic <- cbind(garlic, d1) # d와 마늘을 합치기

names(garlic)[names(garlic)=="d1"]="시점" # 열이름을 시점으로 변경

all_1 <- merge(garlic, production, by ="시점")

# write.csv(all_1, "마늘+생산.csv")

```

# 의미 없는 데이터 제거

```{r}
pro_gar <- read.csv("마늘+생산.csv")
pro_gar <- subset(pro_gar, select = -시도별)
pro_gar <- subset(pro_gar, select = -시장)
pro_gar <- subset(pro_gar, select = -법인)
pro_gar <- subset(pro_gar, select = -X)

```

## 단위 통일 시키기(톤으로)

```{r}
t <- pro_gar$X10a당.생산량..kg.*0.001 # kg단위를 t단위로 전환

pro_gar <- cbind(pro_gar, t)

names(pro_gar)[names(pro_gar)=="t"]="10a당 생산량.톤" # 열이름을 시점으로 변경

```

# 연도별 품종의 거래량 평균
```{r}
unique(pro_gar$시군산지)
g_ghd <- pro_gar %>% filter(시군산지 == '홍천')
g_vud <- pro_gar %>% filter(시군산지 == '평창')
g_cjf <- pro_gar %>% filter(시군산지 == '철원') 
g_cns <- pro_gar %>% filter(시군산지 == '춘천') 
g_tka <- pro_gar %>% filter(시군산지 == '삼척') 
g_rkd <- pro_gar %>% filter(시군산지 == '강릉') 
g_ghld <- pro_gar %>% filter(시군산지 == '횡성') 
g_rh <- pro_gar %>% filter(시군산지 == '강원고성') 
g_dnjs <- pro_gar %>% filter(시군산지 == '원주') 
g_xo <- pro_gar %>% filter(시군산지 == '태백') 
g_ehd <- pro_gar %>% filter(시군산지 == '동해') 
g_wjd <- pro_gar %>% filter(시군산지 == '정선') 
g_did <- pro_gar %>% filter(시군산지 == '양구') 
g_ghk <- pro_gar %>% filter(시군산지 == '화천') 
```
# Show in New Window
[1] "홍천"     "평창"     "철원"     "춘천"     "삼척"     "강릉"     "횡성"     "강원고성" "원주"    
[10] "태백"     "동해"     "정선"     "양구"     "화천"    

# 연도별 분류
```{r}
g2015 <- pro_gar %>% filter(시점 == 2015)
g2016 <- pro_gar %>% filter(시점 == 2016)
g2017 <- pro_gar %>% filter(시점 == 2017)
g2018 <- pro_gar %>% filter(시점 == 2018)
g2019 <- pro_gar %>% filter(시점 == 2019)
g2020 <- pro_gar %>% filter(시점 == 2020)
g2021 <- pro_gar %>% filter(시점 == 2021)

```


# 지역의 거래량의 평균
```{r}

a2015 <- data.frame(tapply(g2015$거래량.톤., g2015$시군산지, mean))
a2016 <- data.frame(tapply(g2016$거래량.톤., g2016$시군산지, mean))
a2017 <- data.frame(tapply(g2017$거래량.톤., g2017$시군산지, mean))
a2018 <- data.frame(tapply(g2018$거래량.톤., g2018$시군산지, mean))
a2019 <- data.frame(tapply(g2019$거래량.톤., g2019$시군산지, mean))
a2020 <- data.frame(tapply(g2020$거래량.톤., g2020$시군산지, mean))
a2021 <- data.frame(tapply(g2021$거래량.톤., g2021$시군산지, mean))


#write.csv(a2016,"a2016.csv")
#write.csv(a2017,"a2017.csv")
#write.csv(a2018,"a2018.csv")
#write.csv(a2019,"a2019.csv")
#write.csv(a2020,"a2020.csv")
#write.csv(a2021,"a2021.csv")

a2015 <- read.csv("a2015.csv")
a2016 <- read.csv("a2016.csv")
a2017 <- read.csv("a2017.csv")
a2018 <- read.csv("a2018.csv")
a2019 <- read.csv("a2019.csv")
a2020 <- read.csv("a2020.csv")
a2021 <- read.csv("a2021.csv")
```


# 데이터 합치는 과정(1) max치를 기준으로 합치기
```{r}
# a <- rbind(a2015,a2016,a2017,a2018,a2019,a2020,a2021) # 데이터 합치기

# ab <- c("시점", "시군산지")  

# pro_gar <- merge(pro_gar, a, by = ab) # 합치기

# write.csv(pro_gar, "garlic.csv")

# pro_gar <- read.csv("garlic.csv")

# summary(pro_gar$평균) # max 8.83667 = 정선

# weather1 <- filter(weather, 지점명 =='정선') # 정선의 날씨만 추출해서

# pro_gar1 <- merge(pro_gar, weather1, by = '일자') # 일자 기준으로 merge 하기
```


# 날씨 데이터 합치기 (지역 기반) 
comments: 날씨와 중복되는 지역은 그대로 쓰고, 중복되지 않은 지역은 summary(pro_gar$평균) # max 8.83667 = 정선/ 을 통하여, 평균이 제일 높은 정선지역으로 날씨 변환
```{r}
weather2 <- weather %>% filter(지점명 == '춘천'|지점명 == '철원'|지점명 == '강릉'|지점명 == '동해'|지점명 == '원주'|지점명 == '홍천'|지점명 == '태백'|지점명 == '정선')

unique(pro_gar$시군산지)
unique(weather2$지점명)

names(pro_gar)[names(pro_gar)=="시군산지"]="지점명"

cv <- c("지점명", "일자")

ga <- merge(pro_gar, weather2, by = cv) # 중복되는 곳

unique(ga$지점명)

# 중복되지 않은곳은 거래량평균치가 높은 정선으로 선택하기-------------------------

garlic3 <- pro_gar %>% filter(지점명 != '춘천'&지점명 != '철원'&지점명 != '강릉'&지점명 != '동해'&지점명 != '원주'&지점명 != '홍천'&지점명 != '태백'&지점명 != '정선') # 중복되지 않은곳 

weather1 <- filter(weather, 지점명 =='정선') # 정선의 날씨만 추출해서

pro_gar3 <- merge(garlic3, weather1, by = '일자') # 일자 기준으로 merge 하기 

# write.csv(ga, "편집해야해1.csv")
# write.csv(pro_gar3, "편집해야해2.csv")

aq <- read.csv("편집해야해1.csv")
aq1 <- read.csv("편집해야해2.csv")

pro_gar_we <- rbind(aq, aq1)

# write.csv(pro_gar_we, "마늘 날씨 생산량.csv")

pro_gar_we <- read.csv("마늘 날씨 생산량.csv")
```

# 마늘 재배에 영향을 줄 수 있는 날씨요인 
```{r}
include_graphics("마늘생육과정.png")

# 파종시기 9월~10월 
# 수확시기 5월~6월
# 25' 이상에선 생육정지

str(pro_gar_we)

as.numeric(pro_gar_we$도매가격.원.kg.)

# 산점도
ggplot(pro_gar_we, aes(x=pro_gar_we$생산량..톤., y=pro_gar_we$평균기온..C.)) +
  geom_point(shape=10, size=1, colour="blue") +
  ggtitle("Scatter plot : 도매가격, 평균기온") +
  theme(plot.title=element_text(size=20))


cor.test(pro_gar_we$생산량..톤.,pro_gar_we$평균기온..C., method = "pearson",conf.level = 0.95) 
```


