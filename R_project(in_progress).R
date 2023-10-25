library(ggplot2)
library(dplyr)
library(moderndive)
library(readr)

# What factors help contribute to a team winning in League of Legends?

high_diamond_ranked_10min <- read_csv("Downloads/high_diamond_ranked_10min.csv")
View(high_diamond_ranked_10min)

ranked_game_data <- high_diamond_ranked_10min

head(ranked_game_data)

# let's add some columns and variables
ranked_game_data $win <- factor(ranked_game_data$blueWins, levels = c(0, 1), labels = c("Red team", "Blue team"))
ranked_game_data $firstBlood <- factor(ranked_game_data$blueFirstBlood, levels = c(0, 1), labels = c("Red team", "Blue team"))

# First, I will see if the champion level relates to whether the team won or lost.
# I will be looking at the blue team for this.

median_AvgLevel <- median(ranked_game_data$blueAvgLevel)

ggplot(ranked_game_data, aes(x= blueAvgLevel, y= blueWins))+
  geom_col()+
  labs(x="Average Level", y="Wins", title = "Blue Team Wins vs. Level")+
  geom_vline(aes(xintercept=median_AvgLevel), linetype="dashed", color = "red")

# Now, we can see that most wins for the blue team has players with champions that have a median level of 7.

# Do higher level champions get more kills that influence the outcome of the game?

ggplot(ranked_game_data, aes(x= blueKills, y= blueAvgLevel))+
  geom_point()+
  labs(x="Number of Kills", y="Average Level")

# Let's add a best fit line to better see this correlation. 
ggplot(ranked_game_data, aes(x= blueKills, y= blueAvgLevel))+
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE)
  labs(x="Number of Kills", y="Average Level")
  
# We can now see that there is a positive correlation between the kills that a player gets and their champion level. 

get_correlation(ranked_game_data, blueKills ~ blueAvgLevel)

# How many total wins did the blue team have?
ranked_game_data %>% count(blueWins)

# 4,930 wins and 4,949 loses. 

# What was the average number of player kills a team got for each win?
avg_kills <- ranked_game_data %>%
  group_by(blueWins) %>%
  summarise(average_kills = mean(blueKills, na.rm = TRUE))

avg_kills

# Now we can see that the average amount of kills when the blue team won was 7.20 and when they lost it was 5.17.
# Let's plot this!
ggplot(data = ranked_game_data, mapping = aes(group = blueWins, x = blueKills, y = blueWins)) +
  geom_boxplot()

# blueCSPerMin vs blueTotalExperience
ggplot(ranked_game_data, aes(x= blueTotalExperience, y= blueCSPerMin))+
  geom_point(alpha = 0.2)+
  geom_smooth(method = 'lm')

# CSPerMin vs win??

# Blue kills vs deaths? I would suspect that deaths could go down as kills go up
ggplot(ranked_game_data, aes(x= blueDeaths, y= blueKills))+
  geom_col()+
  facet_wrap(~ blueWins)






