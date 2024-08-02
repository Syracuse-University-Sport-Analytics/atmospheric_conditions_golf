# Atmospheric Conditions and Golf
## [Rodney Paul](https://falk.syr.edu/people/paul-rodney/)
## [Christopher Cain](https://www.unlv.edu/people/christopher-cain)
## [Justin Ehrlich](https://falk.syr.edu/people/ehrlich-justin/)
## Collin Kneiss
## [Junghoon Lee](https://www.unlv.edu/people/junghoon-lee)
## [Nick Riccardi](https://ischool.syr.edu/nick-riccardi//)
### Interactive Weather Calculator: https://sportdataviz.syr.edu/Golf/
Professional athletes are incredibly talented and motivated individuals who work tirelessly toward the goal of excellence in their given sport.  The amount of skill and dedication it takes to make it to the highest level of a sport is often difficult for amateurs and non-athletes to fathom.  Among the elite athletes, the difference between qualifying, advancing, and winning or losing is often small.  Top athletes are often evenly matched with the slightest mistake or favorable situation being the difference between success and failure.\
\
Golf professionals on the PGA Tour are no exception.  Players being able to qualify for a tournament, make the cut, and place high on the leaderboard often only have the slightest statistical advantage over their peers.  While much of the difference in performance on a day-to-day, week-to-week, and season-to-season period comes down to pure ability coupled with luck, another factor which impacts performance may also play a key role.  This factor is the weather.\
\
Weather conditions, whether it is precipitation, wind, or other factors is a major challenge to golfers of all ages and abilities.  In nearly all cases, weather conditions change frequently from week-to-week, during a tournament, daily, and even during a round.  Players facing more challenging weather conditions often post higher scores, leading to key differences in making the cut, position of finish, or even winning a tournament.\
\
Using regression models, we estimate and describe the effects of these variables on player performance for professional golfers on the PGA tour.  These results have major implications for PGA tour performance and rankings, but also have implications for golfers of all ages and abilities, as weather is a major factor in their scores as well.\
\
\
\
`Analysis.Rmd`: Script to analyze weather data.\
`calculator/`: Interactive Weather Calculator.\
`data/`: Location of data.\
`models/`: Location of estimated models.\
`tables/`: Location of table analysis.\
`visualizations/`: Location of visualization analysis.\
\
\
\Instructions: \
\To run the interactive calculator, open `calculator\Golf\app.R` in RStudio. All required data is located within `calculator\Golf\data\` and all required estimated models are located within `calculator\Golf\models\`
\Run the code in Analysis.RMD, which populates the `models\`, `tables\`, and `visualizations\` folders.

