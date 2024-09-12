# Atmospheric Conditions and Golf
### [Justin Ehrlich](https://falk.syr.edu/people/ehrlich-justin/)
### [Rodney Paul](https://falk.syr.edu/people/paul-rodney/)
### [Nick Riccardi](https://ischool.syr.edu/nick-riccardi//)
### [Christopher Cain](https://www.unlv.edu/people/christopher-cain)
### [Junghoon Lee](https://www.unlv.edu/people/junghoon-lee)

## Interactive Weather Calculator: https://sportdataviz.syr.edu/Golf/

The data is all available on public websites. We recommend wunderground.com for atmospheric conditions data and datagolf.com for performance data. Once the data is present, you can run `prep_data.ipynb`, which takes the input files and creates `data/pga_tour_data_w_weather.csv`.  Then you can run `Analysis.RMD` for analysis of the data. \
\
The `tour_data_pga.csv` file, which contains tour performance data, must have the following columns:\
"tour"\
"year"\
"season"\
"event_completed"\
"event_name"\
"event_id"\
"player_name"\
"dg_id"\
"fin_text"\
"round_num"\
"course_name"\
"course_num"\
"course_par"\
"start_hole"\
"teetime"\
"round_score"\
"sg_putt"\
"sg_arg"\
"sg_app"\
"sg_ott"\
"sg_t2g"\
"sg_total"\
"driving_dist"\
"driving_acc"\
"gir"\
"scrambling"\
"prox_rgh"\
"prox_fw"\
"great_shots"\
"poor_shots"\
\
\
The `pga_weather.csv` file, which contains atmospheric conditions, must have the following columns:\
"Time"\
"TimeinMin"\
"Temperature"\
"Dew Point"\
"Humidity"\
"Wind"\
"Wind Speed"\
"Wind Gust"\
"Pressure"\
"Precip."\
"Condition"\
"City"\
"Date"\
"concat"\
