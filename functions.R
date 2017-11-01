count_socks <- function(sdf) {
  sdf %>% 
    group_by(sock) %>%
    summarize(n=n())
}

sock_histogram <- function(socks_df, Date=Sys.Date()) {
  socks_df$date <- as.Date(socks_df$date)
  Date <- as.Date(Date)
  full_dataset <- socks_df
  socks_df <- filter(socks_df, date <= Date)
  
  ymax <- max(count_socks(full_dataset)$n)
  counts <- count_socks(socks_df)
  counts$ylabel <- counts$n
  
  zero_counts <- setdiff(unique(full_dataset$sock), counts$sock)
  if(length(zero_counts) > 0) {
    zero_counts <- data.frame(sock = zero_counts, n = 0)
    counts$sock <- factor(counts$sock, levels=unique(full_dataset$sock))
    counts <- bind_rows(counts, zero_counts)
    counts <- mutate(counts, ylabel=ifelse(n==0, '', n))
  }
  
  ggplot(counts, aes(x=sock, y=n)) + 
    geom_bar(stat='identity') +
    geom_text(aes(label=ylabel, y=n, vjust=-0.5)) +
    theme(axis.text.x = element_text(hjust=1.0, angle=18),
          axis.title = element_blank()) +
    expand_limits(y=ymax)
}

df <- read.csv('socks.csv')
sock_histogram(df)