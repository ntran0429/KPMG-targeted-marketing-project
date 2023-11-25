# load palmer penguins data
library(palmerpenguins)
head(penguins)

# plot flipper length vs bill length by sex, faceted by species, size by body mass
penguins |>
  ggplot(aes(x = flipper_length_mm, 
             y = bill_length_mm, 
             color = sex, 
             size = body_mass_g)) +
  geom_point(alpha = .5) +
  facet_wrap(~species)

# remove rows with missing sex, exclude year and island
penguins_df <-
  penguins |>
  drop_na(sex) |>
  select(-year, -island)
