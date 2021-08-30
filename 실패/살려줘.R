garlic <- read.csv("마늘가격.csv")
garlic <- filter(garlic, 광역산지 == '강원') #강원지역만 선정

year <- substr(garlic$일시, 1, 4) # 연도만 추출해보자

month <- substr(garlic$일시, 6, 7) # 연도만 추출해보자

garlic <- cbind(garlic, year) # 연도와 날씨를 합치기

garlic <- cbind(garlic, month) # 월 과 날씨를 합치기

names(garlic)[names(garlic)=="month"]="월"

names(garlic)[names(garlic)=="year"]="시점"