#' Visualize Airport Delays
#'
#' @description A function that Visualize Airport Delays from NY Airport
library(dplyr)
library(ggplot2)
visualize_airport_delays <- function(){
  fli <- nycflights13::flights
  air <- nycflights13::airports
  delay <-dplyr::select(fli,dep_delay,origin)
  mean_delay <- delay %>% group_by(origin) %>% summarise(mean_size = mean(dep_delay,na.rm = TRUE))
  exact_pool <- dplyr::filter(air,faa %in% mean_delay$origin)
  exact_la_lo <- dplyr::select(exact_pool,faa,lat,lon)
  mean_delay <- dplyr::bind_cols(mean_delay,exact_la_lo)
  plot_dat <-data.frame(mean_delay)
  ggplot(plot_dat,aes(x=lon,y=lat))+geom_point(size=2) + geom_text(aes(label=origin),hjust=0, vjust=2)
}
