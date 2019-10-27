#' Visualize Airport Delays
#'
#' @description A function that Visualize Airport Delays from NY Airport
#' @return gg 
#' @import dplyr
#' @import ggplot2
#' @import nycflights13
#' @import maps
#' @export visualize_airport_delays
#' 
visualize_airport_delays <- function(){
  fl_delays <- select(nycflights13::flights, arr_delay, dest)
  air_long_lat <- select(nycflights13::airports, faa, lat, lon)
  
  data <- fl_delays %>%
    group_by(dest) %>%
    summarise(mean_delay=mean(arr_delay, na.rm=TRUE)) %>%
    left_join(air_long_lat, by=c("dest"="faa")) %>%
    filter(!is.na(mean_delay), !is.na(lat),lat<50,lat>24) #remove nans and some outliers 
  
  usa <- map_data("usa") # we already did this, but we can do it again
  gg <- ggplot(data = usa,  mapping =aes(x=long, y = lat, group = group))+
    geom_polygon() +
    coord_fixed(1.3)+
    geom_point(data, mapping = aes(x=lon ,y=lat, group = mean_delay ,color=mean_delay))+
    scale_colour_gradient(high = "red",low="yellow")+
    ggtitle("Mean arrival delay to airports")+
    xlab("Latitude")+
    ylab("Longitude")
  
  return(gg)
}
