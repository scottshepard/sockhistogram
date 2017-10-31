sock_histogram <- function(socks_df, Date=Sys.Date()) {
  socks_df$date <- as.Date(socks_df$date)
  Date <- as.Date(Date)
  socks_df <- filter(socks_df, date <= Date)
  ggplot(socks_df, aes(x=sock)) + 
    geom_histogram(stat='count') + 
    stat_count(geom="text", aes(label=..count.., vjust=1.5), color="white") +
    theme(axis.text.x = element_text(hjust=1.0, angle=18),
          axis.title = element_blank())
}

