
## 랜덤포레스트

```{R}
library('tidyverse')
library('tidymodels')
library(randomForest)
library(yardstick)
plz <- read.csv('True.csv')

str(plz)

plz %>%
  initial_split(prop=0.7) -> plz_split

plz_split

plz_split %>%
  training()

plz_split %>%
  testing()

str(plz)

plz_split %>% training() %>%
  recipe(도매가격.원.kg.~평균기온..C.,일강수량.mm.,평균.5cm.지중온도..C.,평균.풍속.m.s.)

plz_recipe

plz_recipe %>%
  bake(plz_split %>% testing()) -> plz_testing

plz_recipe %>%
  juice() -> plz_training

plz_training

rand_forest(trees=100, mode='regression') %>%
  set_engine('randomForest') %>%
  fit(도매가격.원.kg.~ 평균+평균기온..C.+평균상대습도...+월합강수량.00.24h만..mm.+합계.일조시간.hr.+생산량..톤., data = plz_training) -> plz_rf

plz_rf

plz_rf %>%
  predict(plz_testing) %>%
  bind_cols(plz_testing)

a <- plz_rf %>%
  predict(plz_testing) %>%
  bind_cols(plz_testing) %>%
  metrics(truth=도매가격.원.kg., estimate=.pred)

a

```