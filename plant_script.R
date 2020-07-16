# plant script

library(tidyverse)

plants <- read_csv("data/plant_data.csv")

tidy_plants <- plants %>%
  pivot_longer(cols = c(`Leaf width day 1`, `Leaf width day 2`, `Leaf width day 3`, `Stem length day 1`, `Stem length day 2`, `Stem length day 3`),
               names_to = "Element_day",
               values_to = "Measurement")

tidy_plants <- plants %>%
  pivot_longer(cols = where(is.numeric),
               names_to = "Element_day",
               values_to = "Measurement") %>%
  separate(col = Element_day, sep = " day ", into = c("Element", "Day"))

tidy_plants %>%
  pivot_wider(names_from = c(Element, Day),
              names_sep = " day ",
              values_from = Measurement)



plants %>%
  ggplot(aes(x = `Stem length day 1`,
             y = `Stem length day 2`,
             color = Treatment)) +
  geom_point()

tidy_plants %>%
  filter(Element == "Stem length") %>%
  ggplot(aes(x = Day,
             y = Measurement,
             color = Treatment)) +
  geom_boxplot()

