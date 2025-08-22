library(haven)
BalkanBarometer_2024 <- read_dta("BalkanBarometer_2024.dta")
View(BalkanBarometer_2024)
library(dplyr)
library(ggplot2)
library(forcats)

BalkanBarometer_2024$country <- labelled(BalkanBarometer_2024$country,
                                         c("Albania" = 1,
                                           "Bosnia & Herzegovina" = 2,
                                           "Kosovo" = 3,
                                           "Montenegro" = 4,
                                           "North Macedonia" = 5,
                                           "Serbia" = 6))
BalkanBarometer_2024$country <- factor(BalkanBarometer_2024$country, labels = c("Albania",
                                                                                "Bosnia & Herzegovina", "Kosovo", "Montenegro", "North Macedonia", "Serbia"))
trust_data_long <- BalkanBarometer_2024 %>%
  select(country, judicial, parliament, government, parties) %>%
  pivot_longer(cols = c(judicial, parliament, government, parties),
               names_to = "Institution", values_to = "TrustLevel")
trust_data_long$TrustLevel <- as.numeric(trust_data_long$TrustLevel)
ggplot(trust_data_long, aes(x = TrustLevel, color = Institution)) +
  geom_density(alpha = 0.5, fill = NA, bw = 0.5, size = 0.7) +
  facet_wrap(~ country, nrow = 2) +
  labs(title = "Trust in Key Institutions Across Western Balkans",
       subtitle = "Comparing trust in the judiciary, parliament, government, and political
parties by country",
       x = "Trust Level",
       y = "Density",
       color = "Institution",
       caption = "Source: Balkan Barometer 2024") +
  scale_color_manual(values = c("judicial" = "#c96710",
                                "parliament" = "#004494",
                                "government" = "#097d59",
                                "parties" = "#bf2a2a")) +
  scale_x_reverse() +
  theme_minimal()