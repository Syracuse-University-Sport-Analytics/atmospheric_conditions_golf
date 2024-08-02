#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(bslib)
library(shinydashboard)
library(tidyverse)
library(EBImage) #BiocManager
library(sf)
library(geojsonsf)

# round_level_data <- readRDS("data/round_level_data.RDS")
# 
# #remove "# 2" from event_name
# round_level_data <- readRDS("data/round_level_data.RDS") %>% mutate(course_name = gsub("Golf Club", "GC", course_name)) %>% mutate(course_name = gsub("Country Club", "CC", course_name))%>% mutate(course_name = gsub("Golf Links", "GL", course_name))
# 
# #get rid of anything with parentheses in it, including space before open parenthesis
# round_level_data <- round_level_data %>% filter(!grepl("\\(", course_name))
# 
# #replace "Quail Hollow-PGA Championship" with "Quail Hollow Club"
# round_level_data <- round_level_data %>% mutate(course_name = gsub("Quail Hollow-PGA Championship", "Quail Hollow Club", course_name))
# 
# #replace "El Camale√≥n Golf Course at Mayakoba" with "El Camaleon GC"
# round_level_data <- round_level_data %>% mutate(course_name = gsub("El Camale√≥n Golf Course at Mayakoba", "El Camaleon GC", course_name))
# 
# #replace "The CC" with "The CC of Jackson"
# round_level_data <- round_level_data %>% mutate(course_name = gsub("The CC of Jackson", "The CC", course_name))
# round_level_data <- round_level_data %>% mutate(course_name = gsub("CC of Jackson", "The CC", course_name))
# round_level_data <- round_level_data %>% mutate(course_name = gsub("The CC", "The CC of Jackson", course_name))
# 
# 
# round_level_data <- round_level_data %>% mutate(course_name = gsub("Albany, Bahamas", "Albany", course_name))
# round_level_data <- round_level_data %>% mutate(course_name = gsub("Albany GC", "Albany", course_name))
# round_level_data <- round_level_data %>% mutate(course_name = gsub("Albany", "Albany GC", course_name))
# 
# round_level_data %>% group_by(course_name) %>% summarize(driving_dist = mean(driving_dist, na.rm=T), true_sg_total = mean(true_sg_total, na.rm=T), elevation = mean(elevation, na.rm=T), avg_temperature = mean(avg_temperature, na.rm=T), avg_humidity = mean(avg_humidity, na.rm=T), avg_pressure = mean(avg_pressure, na.rm=T), avg_dew_point = mean(avg_dew_point, na.rm=T), avg_wind_speed = mean(avg_wind_speed, na.rm=T), avg_wind_gust = mean(avg_wind_gust, na.rm=T), sum_precipitation = mean(sum_precipitation, na.rm=T), air_density = mean(air_density, na.rm=T), teetimeinmin = mean(teetimeinmin, na.rm=T), avg_wet_bulb_temperature = mean(avg_wet_bulb_temperature, na.rm=T)) -> avg_data
# 
# round_level_data %>% summarize(true_sg_total = mean(true_sg_total, na.rm=T), driving_dist = mean(driving_dist, na.rm=T), elevation = mean(elevation, na.rm=T), avg_temperature = mean(avg_temperature, na.rm=T), avg_humidity = mean(avg_humidity, na.rm=T), avg_pressure = mean(avg_pressure, na.rm=T), avg_dew_point = mean(avg_dew_point, na.rm=T), avg_wind_speed = mean(avg_wind_speed, na.rm=T), avg_wind_gust = mean(avg_wind_gust, na.rm=T), sum_precipitation = mean(sum_precipitation, na.rm=T), air_density = mean(air_density, na.rm=T), teetimeinmin = mean(teetimeinmin, na.rm=T), avg_wet_bulb_temperature = mean(avg_wet_bulb_temperature, na.rm=T)) -> all_avg_data
# 
# avg_data %>% mutate(driving_dist = replace_na(driving_dist, all_avg_data$driving_dist)) -> avg_data
# 
# all_avg_data %>% mutate(course_name = "Average") %>% bind_rows(avg_data) -> avg_data
# 
# saveRDS(avg_data, "data/avg_dataRDS")


avg_data <- readRDS("data/avg_dataRDS")


# Define UI for application that draws a histogram
ui <- dashboardPage(title = "GC Projection Calculator", skin = "green",

    # Application title
    dashboardHeader(title = span(tagList(icon("golf-ball-tee"), "GC Projection"))),

    # Sidebar with a slider input for number of bins 
 
      dashboardSidebar(

            #create dropdown of course_name
            selectInput("course_name", "Course Name", choices = c(unique(avg_data$course_name))),
            
            #create textInput for the following:  [1] "air_density"              "avg_dew_point"            "avg_humidity"             "avg_pressure"            
            #[5] "avg_temperature"          "avg_wet_bulb_temperature" "avg_wind_gust"            "avg_wind_speed"          
            #[9] "course_name"              "elevation"                "sum_precipitation"        "teetimeinmin"   
            

            textInput("avg_dew_point", "Average Dew Point", value = avg_data$avg_dew_point[1]),
            textInput("avg_humidity", "Average Humidity", value = avg_data$avg_humidity[1]),
            textInput("avg_pressure", "Average Pressure", value = avg_data$avg_pressure[1]),
            textInput("avg_temperature", "Average Temperature", value = avg_data$avg_temperature[1]),
            textInput("avg_wind_gust", "Average Wind Gust", value = avg_data$avg_wind_gust[1]),
            textInput("avg_wind_speed", "Average Wind Speed", value = avg_data$avg_wind_speed[1]),
            textInput("elevation", "Elevation", value = avg_data$elevation[1]),
            textInput("sum_precipitation", "Sum Precipitation", value = avg_data$sum_precipitation[1])

            ,tags$head(tags$style("section.content { overflow-y: hidden; }"))
            

            
        ),

        # Show a plot of the generated distribution
      dashboardBody(

        sliderInput("sg_total",
                    "True Strokes Gained: Total during Average Conditions",
                    min = -10,
                    max = 10,
                    value = 0),
        valueBoxOutput(
          "sg_total_updated",
        ),
        sliderInput("driving_distance",
                    "Drive Distance during Average Conditions",
                    min = 100,
                    max = 400,
                    value = 250),
        valueBoxOutput(
          "driving_distance_updated",
        ),
        sliderInput("hole_distance",
                    "Hole Distance to Project",
                    min = 50,
                    max = 750,
                    value = 400),
        box(
          title = "Projected Hole From Updated Conditions:", status = "primary", solidHeader = TRUE, width = 12,
            plotOutput("golf_course")
        ),
       
       

        
        )
    
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  "Johnson, Dustin" -> average_player
  1 -> average_round
  2022 -> average_year
  
  air_density_components_model_driving_dist <- readRDS("models/air_density_components_model_driving_dist_player_FE.RDS")
  # air_density_components_model_driving_dist <- butcher::axe_data(air_density_components_model_driving_dist)
  # air_density_components_model_driving_dist <- butcher::axe_call(air_density_components_model_driving_dist)
  # air_density_components_model_driving_dist <- butcher::axe_env(air_density_components_model_driving_dist)
  # air_density_components_model_driving_dist <- butcher::axe_fitted(air_density_components_model_driving_dist)
  # air_density_components_model_driving_dist <- butcher::butcher(air_density_components_model_driving_dist)
  # air_density_components_model_driving_dist$qr$qr <- NULL
  # saveRDS(air_density_components_model_driving_dist, "models/air_density_components_model_driving_dist_player_FE.RDS")
  
  air_density_components_model_sg_total <- readRDS("models/air_density_components_model_sg_total_player_FE.RDS")
  # air_density_components_model_sg_total <- butcher::axe_data(air_density_components_model_sg_total)
  # air_density_components_model_sg_total <- butcher::axe_call(air_density_components_model_sg_total)
  # air_density_components_model_sg_total <- butcher::axe_env(air_density_components_model_sg_total)
  # air_density_components_model_sg_total <- butcher::axe_fitted(air_density_components_model_sg_total)
  # air_density_components_model_sg_total <- butcher::butcher(air_density_components_model_sg_total)
  # air_density_components_model_sg_total$qr$qr <- NULL
  # saveRDS(air_density_components_model_sg_total, "models/air_density_components_model_sg_total_player_FE.RDS")
  
  
  predicted_sg_avg_conditions <- reactive({
    round(predict(air_density_components_model_sg_total, newdata = avg_data %>% filter(course_name == input$course_name) %>% mutate(round_num = average_round, year = average_year, player_name = average_player)),2)})
  
  predicted_sg_updated_conditions <- reactive({
    round(predict(air_density_components_model_sg_total, newdata = avg_data %>% filter(course_name == input$course_name) %>% mutate(round_num = average_round, year = average_year, player_name = average_player, avg_dew_point = as.numeric(input$avg_dew_point), avg_humidity = as.numeric(input$avg_humidity), avg_pressure = as.numeric(input$avg_pressure), avg_temperature = as.numeric(input$avg_temperature), avg_wind_gust = as.numeric(input$avg_wind_gust), avg_wind_speed = as.numeric(input$avg_wind_speed), elevation = as.numeric(input$elevation), sum_precipitation = as.numeric(input$sum_precipitation))),2)})
  
  predicted_sg_average_player <- reactive({
    difference_between_updated_and_avg <- predicted_sg_updated_conditions() - predicted_sg_avg_conditions()
    round(input$sg_total + difference_between_updated_and_avg,2)
  })
  
  predicted_sg_average_player_status <- reactive({
    difference_between_updated_and_avg <- predicted_sg_updated_conditions() - predicted_sg_avg_conditions()
    if(difference_between_updated_and_avg > 0){
      "green"
    } else if(difference_between_updated_and_avg < 0){
      "red"
    } else {
      "light-blue"
    }
  })
  
  
  predicted_driving_dist_avg_conditions <- reactive({
    round(predict(air_density_components_model_driving_dist, newdata = avg_data %>% filter(course_name == input$course_name) %>% mutate(round_num = average_round, year = average_year, player_name = average_player)),2)})
  
  predicted_driving_dist_updated_conditions <- reactive({
    round(predict(air_density_components_model_driving_dist, newdata = avg_data %>% filter(course_name == input$course_name) %>% mutate(round_num = average_round, year = average_year, player_name = average_player, avg_dew_point = as.numeric(input$avg_dew_point), avg_humidity = as.numeric(input$avg_humidity), avg_pressure = as.numeric(input$avg_pressure), avg_temperature = as.numeric(input$avg_temperature), avg_wind_gust = as.numeric(input$avg_wind_gust), avg_wind_speed = as.numeric(input$avg_wind_speed), elevation = as.numeric(input$elevation), sum_precipitation = as.numeric(input$sum_precipitation))),2)})
  
  predicted_driving_dist_average_player <- reactive({
    difference_between_updated_and_avg <- predicted_driving_dist_updated_conditions() - predicted_driving_dist_avg_conditions()
    percent_difference <- difference_between_updated_and_avg / predicted_driving_dist_avg_conditions()
    round(input$driving_distance * (1 + percent_difference),2)
  })
  
  predicted_driving_dist_average_player_status <- reactive({
    difference_between_updated_and_avg <- predicted_driving_dist_updated_conditions() - predicted_driving_dist_avg_conditions()
    percent_difference <- difference_between_updated_and_avg / predicted_driving_dist_avg_conditions()
    if(percent_difference > 0){
      "green"
    } else if(percent_difference < 0){
      "red"
    } else {
      "light-blue"
    }
  })
  
  predicted_driving_hole_distance <- reactive({
    difference_between_updated_and_avg <- predicted_driving_dist_updated_conditions() - predicted_driving_dist_avg_conditions()
    percent_difference <- difference_between_updated_and_avg / predicted_driving_dist_avg_conditions()
    round(input$hole_distance / (1 + percent_difference),2)
  })
  
  predicted_driving_hole_distance_percentage <- reactive({
    difference_between_updated_and_avg <- predicted_driving_dist_updated_conditions() - predicted_driving_dist_avg_conditions()
    percent_difference <- difference_between_updated_and_avg / predicted_driving_dist_avg_conditions()
    round(1 / (1 + percent_difference),2)
  })
  
  
  output$sg_total_updated <- renderValueBox({
    valueBox(
      value = predicted_sg_average_player(),
      subtitle = "True SG Total with Updated Conditions",
      color = predicted_sg_average_player_status()
    )
  })
  
  output$driving_distance_updated <- renderValueBox({
    valueBox(
      value = predicted_driving_dist_average_player(),
      subtitle = "Drive Distance during Updated Conditions",
      color = predicted_driving_dist_average_player_status()
    )
  })
  
  
  output$hole_distance_updated <- renderValueBox({
    valueBox(
      value = predicted_driving_hole_distance(),
      subtitle = "Projected Hole Distance with Updated Conditions",
      color = predicted_driving_dist_average_player_status()
    )
  })
  
 
  output$golf_course <- renderPlot({
    geojson_df <- readRDS("data/geojson_df.RDS")
    tibble(geojson_df) -> geojson_updated_df
    
    scale <- predicted_driving_hole_distance_percentage()
    
    #scale geojson_updated_df$geometryby 1.5
    #geojson_updated_df$geometry <- geojson_updated_df$geometry * 1.5
    st_geometry(geojson_updated_df) <- (st_geometry(geojson_df)-c(1292367, -508633.4))* c(scale,scale) + (c(1292367, -508633.4)) - c(0,100)
    st_crs(geojson_updated_df) <- st_crs(geojson_df)
    
    #st_centroid(geojson_updated_df) - this is where the values above came from
    
    

    # generate ggplot map
    ggplot() +
        geom_sf(data = geojson_df, aes(fill = color), color = "black") + 
        geom_sf(data = geojson_updated_df, aes(fill = color), color = "red") +
        geom_text(data = filter(geojson_df, grepl("_fairway$", polygon_name)), 
                aes(x = st_coordinates(centroid)[, 1], 
                    y = st_coordinates(centroid)[, 2]), 
                size = 5, color = "black", fontface = "bold", hjust = 0.5, vjust = 1, label = paste0("Original: ", round(input$hole_distance,0), " yards.")) +
        geom_text(data = filter(geojson_updated_df, grepl("_fairway$", polygon_name)), 
                aes(x = st_coordinates(centroid)[, 1], 
                    y = st_coordinates(centroid)[, 2] - 100), 
                size = 5, color = "black", fontface = "bold", hjust = 0.5, vjust = 1, label = paste0("Projected: ", round(input$hole_distance*predicted_driving_hole_distance_percentage(),0), " yards." )) +
        scale_fill_identity() + 
        theme_minimal() + 
        theme(axis.title.x = element_blank(), 
              axis.title.y = element_blank(),
              axis.text.x = element_blank(), 
              axis.text.y = element_blank(), 
              plot.title = element_text(size = 16),
              panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank()) + 
        theme(legend.position = "none") -> course_map

    course_map
  })
    

    
  
    
    #update the textInput values based on the course_name
    observe({
      updateSliderInput(session, "sg_total", value = round(avg_data$true_sg_total[avg_data$course_name == input$course_name],2))
      updateSliderInput(session, "driving_distance", value = round(avg_data$driving_dist[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "air_density", value = round(avg_data$air_density[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "avg_dew_point", value = round(avg_data$avg_dew_point[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "avg_humidity", value = round(avg_data$avg_humidity[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "avg_pressure", value = round(avg_data$avg_pressure[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "avg_temperature", value = round(avg_data$avg_temperature[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "avg_wet_bulb_temperature", value = round(avg_data$avg_wet_bulb_temperature[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "avg_wind_gust", value = round(avg_data$avg_wind_gust[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "avg_wind_speed", value = round(avg_data$avg_wind_speed[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "elevation", value = round(avg_data$elevation[avg_data$course_name == input$course_name],2))
      updateTextInput(session, "sum_precipitation", value = round(avg_data$sum_precipitation[avg_data$course_name == input$course_name],2))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
