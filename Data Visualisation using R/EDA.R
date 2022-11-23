songs.df <- read.csv("songs_updated_v4.csv")
summary(songs.df)
#install.packages("magrittr") # package installations are only needed the first time you use it
#install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr) 
library(ggplot2)
library(plotly)

Spotify <- songs.df

#remove Popularity whose score is less than 10. they are more like outliers
Pop.df <- Spotify[Spotify$popularity > 10,]

#1. Popularity distribution
# library

ggplot( Pop.df,aes(x=popularity)) +
  geom_histogram( binwidth=3, fill="#69b3a2", color="#e9ecef", alpha=0.9) +
  ggtitle("Popularity Histogram") + xlab("Popularity Ratings") + ylab ("Frequency")

#1.2
#popularity score across each year
library(dplyr)
selected.var <- c(3,5,6,7,8,9,10,11,12,13,14,15,16,17)

year_average.df=Spotify[selected.var]
year_average.df

year_average <- year_average.df %>% group_by(year) %>% 
  summarise(Total_Popularity=sum(popularity))
print(year_average)
View(year_average)


# Grouped
ggplot(year_average, aes(fill=Total_Popularity, y=Total_Popularity, x=year)) + 
  geom_bar(position="dodge", stat="identity")

#2. Correlation between characterictics of songs
#using plot_ly library and The pipe operator %>% -was introduced to "decrease development time and to improve readability and maintainability of code."
fig1 <- plot_ly(data = Spotify,x = ~popularity, y = ~danceability,
                type = 'scatter', mode = 'markers', 
                name="Danceability",marker=list(size = 3,
                                                color = ~danceability)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Danceability'))

fig1

fig2 <- plot_ly(data = Spotify,x = ~popularity, y = ~energy, type = 'scatter', mode = 'markers', 
                name="Energy",marker=list(size = 3,
                                          color = ~energy)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Energy'))


fig3 <- plot_ly(data = Spotify,x = ~popularity, y = ~key, type = 'scatter', mode = 'markers', 
                name="Key",marker=list(size = 3,
                                       color = ~key)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Key'))


fig4 <- plot_ly(data = Spotify,x = ~popularity, y = ~loudness, type = 'scatter', mode = 'markers', 
                name="Loudness",marker=list(size = 3,
                                            color = ~loudness)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Loudness (dB)'))

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleY = TRUE, titleX = TRUE, margin = 0.1)%>% 
  layout(
    #title = 'Characteristics vs. Popularity',
    plot_bgcolor='#e5ecf6', 
    xaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'), 
    yaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Danceability vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Energy vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "Key vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Loudness vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))

fig <- fig %>%layout(annotations = annotations) 
#options(warn = -1)
fig

fig1 <- plot_ly(data = Spotify,x = ~popularity, y = ~danceability,
                type = 'scatter', mode = 'markers', 
                name="Danceability",marker=list(size = 3,
                                                color = ~danceability)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Danceability'))


fig2 <- plot_ly(data = Spotify,x = ~popularity, y = ~energy, type = 'scatter', mode = 'markers', 
                name="Energy",marker=list(size = 3,
                                          color = ~energy)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Energy'))


fig3 <- plot_ly(data = Spotify,x = ~popularity, y = ~key, type = 'scatter', mode = 'markers', 
                name="Key",marker=list(size = 3,
                                       color = ~key)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Key'))


fig4 <- plot_ly(data = Spotify,x = ~popularity, y = ~loudness, type = 'scatter', mode = 'markers', 
                name="Loudness",marker=list(size = 3,
                                            color = ~loudness)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Loudness (dB)'))

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleY = TRUE, titleX = TRUE, margin = 0.1)%>% 
  layout(
    #title = 'Characteristics vs. Popularity',
    plot_bgcolor='#e5ecf6', 
    xaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'), 
    yaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Danceability vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Energy vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "Key vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Loudness vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))

fig <- fig %>%layout(annotations = annotations) 
#options(warn = -1)
fig


fig1 <- plot_ly(data = Spotify,x = ~popularity, y = ~mode,
                type = 'scatter', mode = 'markers', 
                name="Mode",marker=list(size = 3,
                                        color = ~mode)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Mode'))


fig2 <- plot_ly(data = Spotify,x = ~popularity, y = ~liveness, type = 'scatter', mode = 'markers', 
                name="Liveness",marker=list(size = 3,
                                             color = ~liveness)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Liveness'))


fig3 <- plot_ly(data = Spotify,x = ~popularity, y = ~valence, type = 'scatter', mode = 'markers', 
                name="Valence",marker=list(size = 3,
                                           color = ~valence)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Valence'))


fig4 <- plot_ly(data = Spotify,x = ~popularity, y = ~duration_ms, type = 'scatter', mode = 'markers', 
                name="Length(Duration)",marker=list(size = 3,
                                                    color = ~duration_ms)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Length'))

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleY = TRUE, titleX = TRUE, margin = 0.1)%>% 
  layout(
    #title = 'Characteristics vs. Popularity',
    plot_bgcolor='#e5ecf6', 
    xaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'), 
    yaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Mode vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Liveness vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "Valence vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Length vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))

fig <- fig %>%layout(annotations = annotations) 
#options(warn = -1)
fig


fig1 <- plot_ly(data = Spotify,x = ~popularity, y = ~acousticness,
                type = 'scatter', mode = 'markers', 
                name="Acousticness",marker=list(size = 3,
                                                color = ~acousticness)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Acousticness'))
fig1

fig2 <- plot_ly(data = Spotify,x = ~popularity, y = ~speechiness, type = 'scatter', mode = 'markers', 
                name="Speechiness",marker=list(size = 3,
                                               color = ~speechiness)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Speechiness'))


fig3 <- plot_ly(data = Spotify,x = ~popularity, y = ~instrumentalness, type = 'scatter', mode = 'markers', 
                name="Instrumentalness",marker=list(size = 3,
                                                    color = ~instrumentalness)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Instrumentalness'))


fig4 <- plot_ly(data = Spotify,x = ~popularity, y = ~tempo, type = 'scatter', mode = 'markers', 
                name="Tempo",marker=list(size = 3,
                                         color = ~tempo)) %>%
  layout(xaxis = list(title = 'Popularity',range = c(10,100)), yaxis = list(title = 'Tempo'))

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleY = TRUE, titleX = TRUE, margin = 0.1)%>% 
  layout(
    #title = 'Characteristics vs. Popularity',
    plot_bgcolor='#e5ecf6', 
    xaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'), 
    yaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Acousticness vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Speechiness vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "Instrumentalness vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Tempo vs. Popularity",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))

fig <- fig %>%layout(annotations = annotations) 
#options(warn = -1)
fig


#3. Correlation map
#install.packages("ggcorrplot")
library(ggcorrplot)
correlation <- Spotify
str(correlation)
correlation$popularity <- as.numeric(correlation$popularity)
correlation$duration_ms <- as.numeric(correlation$duration_ms)
correlation$key <- as.numeric(correlation$key)
correlation$mode<- as.numeric(correlation$mode)
#selecting numneric records for checking correlation
selected.var <- c(3,6,7,8,9,10,11,12,13,14,15,16,17)
selected.df <- correlation[, selected.var]
nrow(selected.df)
cormat <- round(cor(selected.df),2)
cormat
#install.packages("reshape2")
library(reshape2)
melted_cormat <- melt(cormat)
head(melted_cormat)
library(ggplot2)
ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()

# Get lower triangle of the correlation matrix
get_lower_tri<-function(cormat){
  cormat[upper.tri(cormat)] <- NA
  return(cormat)
}
# Get upper triangle of the correlation matrix
get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}
upper_tri <- get_upper_tri(cormat)
upper_tri
# Melt the correlation matrix
library(reshape2)
melted_cormat <- melt(upper_tri, na.rm = TRUE)
# Heatmap
library(ggplot2)
ggplot(data = melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed()

reorder_cormat <- function(cormat){
  # Use correlation between variables as distance
  dd <- as.dist((1-cormat)/2)
  hc <- hclust(dd)
  cormat <-cormat[hc$order, hc$order]
}

# Reorder the correlation matrix
cormat <- reorder_cormat(cormat)
upper_tri <- get_upper_tri(cormat)
# Melt the correlation matrix
melted_cormat <- melt(upper_tri, na.rm = TRUE)
# Create a ggheatmap
ggheatmap <- ggplot(melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ # minimal theme
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed()
# Print the heatmap
print(ggheatmap)

ggheatmap + 
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 2) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.6, 0.7),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))

#4. Most Popular artists with 10 0r more songs in the dataset
library(ggplot2)
genres <- Spotify %>% count(genre, sort = TRUE, name = "Count")

genreFil <- genres 

#par(mar = c(12, 5, 4, 2)+ 0.1)
barplot(genreFil$Count, 
        #xlab="Genre category",
        title("Total Songs based on genres"),
        ylab = "Number of songs",
        col = "#30d6c8",
        names.arg= genreFil$genre,
        width= 0.01,
        ylim = c(0,500),
        las = 2)

#5. Most Popular artists with 10 0r more songs in the dataset
Art <- songs.df %>% count(artist, sort = TRUE, name = "Count")

ArtFil <- Art %>% filter(Count >= 10)

par(mar = c(12, 5, 4, 2)+ 0.1)
barplot(ArtFil$Count, 
        title="Most Popular artists with 10 0r more songs",
        ylab = "Number of songs",
        col = "#30d6c8",
        names.arg= ArtFil$artist,
        width= 0.01,
        ylim = c(0,20),
        las = 2)

str(Spotify)

#6. Songs characterictics over time- years
library(dplyr)
selected.var <- c(3,5,6,7,8,9,10,11,12,13,14,15,16,17)

year_average.df=Spotify[selected.var]
year_average.df
#Removing years 1998,1999 and 2020 for better understanding 
year_average.df = year_average.df[year_average.df$year > 1999,]
year_average.df = year_average.df[year_average.df$year < 2020,]
#mean of all characteristics
year_average <- year_average.df %>% group_by(year) %>% 
  summarise(across(everything(), list(mean = mean)))
year_average
View(year_average)

fig1
fig1 <- plot_ly(data = year_average,x = ~year, y = ~acousticness_mean,
                type = 'scatter', mode = 'lines', 
                name="Acousticness") %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Acousticness'))

fig2 <- plot_ly(data = year_average,x = ~year, y = ~speechiness_mean,
                type = 'scatter', mode = 'lines', 
                name="speechiness") %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Speechiness'))

fig3 <- plot_ly(data = year_average,x = ~year, y = ~instrumentalness_mean, type = 'scatter', 
                mode = 'lines', 
                name="Instrumentalness",marker=list(size = 3)) %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Instrumentalness'))


fig4 <- plot_ly(data = year_average,x = ~year, y = ~tempo_mean,
                type = 'scatter', mode = 'lines', 
                name="Tempo",marker=list(size = 3)) %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Tempo'))

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleY = TRUE, titleX = TRUE, margin = 0.1)%>% 
  layout(
    #title = 'Song Characteristics over time',
    plot_bgcolor='#e5ecf6', 
    xaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'), 
    yaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Acousticness vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Speechiness vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "Instrumentalness vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Tempo vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))

fig <- fig %>%layout(annotations = annotations) 
#options(warn = -1)
fig

# ggplot(year_average, aes(x=year, y=tempo_mean)) +
#   geom_line()

str(year_average)

fig1 <- plot_ly(data = year_average,x = ~year, y = ~danceability_mean,
                type = 'scatter', mode = 'lines', 
                name="Danceability") %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Danceability'))

fig2 <- plot_ly(data = year_average,x = ~year, y = ~energy_mean,
                type = 'scatter', mode = 'lines', 
                name="Energy") %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Energy'))

fig3 <- plot_ly(data = year_average,x = ~year, y = ~popularity_mean, type = 'scatter', 
                mode = 'lines', 
                name="Popularity",marker=list(size = 3)) %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Popularity'))


fig4 <- plot_ly(data = year_average,x = ~year, y = ~loudness_mean,
                type = 'scatter', mode = 'lines', 
                name="Loudness",marker=list(size = 3)) %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Loudness'))

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleY = TRUE, titleX = TRUE, margin = 0.1)%>% 
  layout(
    #title = 'Song Characteristics over time',
    plot_bgcolor='#e5ecf6', 
    xaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'), 
    yaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Danceability vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Energy vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "Popularity vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Loudness vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))

fig <- fig %>%layout(annotations = annotations) 
#options(warn = -1)
fig

str(year_average)

fig1 <- plot_ly(data = year_average,x = ~year, y = ~liveness_mean,
                type = 'scatter', mode = 'lines', 
                name="Liveness") %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Liveness'))

fig2 <- plot_ly(data = year_average,x = ~year, y = ~key_mean, type = 'scatter', 
                mode = 'lines', 
                name="Key",marker=list(size = 3)) %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Key'))

fig3 <- plot_ly(data = year_average,x = ~year, y = ~valence_mean,
                type = 'scatter', mode = 'lines', 
                name="Valence") %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Valence'))

fig4 <- plot_ly(data = year_average,x = ~year, y = ~duration_ms_mean,
                type = 'scatter', mode = 'lines', 
                name="Length",marker=list(size = 3)) %>%
  layout(xaxis = list(title = 'Year'), yaxis = list(title = 'Length'))

fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleY = TRUE, titleX = TRUE, margin = 0.1)%>% 
  layout(
    #title = 'Song Characteristics over time',
    plot_bgcolor='#e5ecf6', 
    xaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'), 
    yaxis = list( 
      zerolinecolor = '#ffff', 
      zerolinewidth = 2, 
      gridcolor = 'ffff'))

annotations = list( 
  list( 
    x = 0.2,  
    y = 1.0,  
    text = "Liveness vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.8,  
    y = 1,  
    text = "Key vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.2,  
    y = 0.4,  
    text = "Valence vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.8,  
    y = 0.4,  
    text = "Length vs. Time",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ))
fig <- fig %>%layout(annotations = annotations) 
#options(warn = -1)
fig

library(ggplot2)
#7. Average BPM for top genre- Pop

Pop <- filter(Spotify, Spotify$is_pop == 'True')
# nrow(Pop)

boxplot(Spotify$tempo,Pop$tempo,
        main = "Beats per minute",
        xlab = "bpm",
        names = c("bpm overall", "bpm Pop genre"),
        col = c("orange", "red"),
        border = "brown",
        horizontal = TRUE,
        notch = TRUE)

#8. Popularity vs Energy
ggplot(Spotify, 
       aes(x=energy, y=popularity, color = popularity)) + 
  geom_point(size=5) +
  ggtitle("Relations between song popularity and its energy")

#9 Popularity change with explicit content
p <- Spotify %>%
  ggplot( aes(x=popularity, fill=explicit)) +
  geom_histogram()
p

#10 is Pop genre belong to popular
po <- Spotify %>%
       ggplot(aes(x=popularity, fill=is_pop)) + 
  geom_boxplot()
po

