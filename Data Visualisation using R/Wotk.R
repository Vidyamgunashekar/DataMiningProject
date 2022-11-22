
#install.packages("magrittr") # package installations are only needed the first time you use it
#install.packages("dplyr")  # alternative installation of the %>%
#install.packages("plotly") 
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr) 
library(plotly)


songs.df <- read.csv("songs_updated_v3.csv")
summary(songs.df)
#Cloning Dataset to avoid tampering
Spotify <- songs.df

library(plotly)

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
