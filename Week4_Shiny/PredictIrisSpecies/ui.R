library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict iris species by selecting four characteristics"),
  
  # Sidebar with slider input for Sepal.Length, Sepal.Width, Petal.Length and
  # Petal.Width
  sidebarLayout(
    sidebarPanel(
       h4("Please select the following characteristics:"),
       sliderInput("Sepal.Length",
                   "Sepal length:",
                   min = 4.1,
                   max = 7.9,
                   step = 0.1,
                   value = 6.0),
       sliderInput("Sepal.Width",
                   "Sepal width:",
                   min = 2.0,
                   max = 4.4,
                   step = 0.1,
                   value = 3.0),
       sliderInput("Petal.Length",
                   "Petal length:",
                   min = 1.0,
                   max = 6.9,
                   step = 0.1,
                   value = 4.35),
       sliderInput("Petal.Width",
                   "Petal width:",
                   min = 0.1,
                   max = 2.5,
                   step = 0.1,
                   value = 1.3)
    ),
    
    # Show plot of the charactristics and predicted iris species
    mainPanel(
       h4("The plot shows the four characteristics and the iris species as
          given in the iris dataset. The red cross indicates the values you
          selected with the sliders on the left side"),
       plotOutput("plotCharacteristics"),
       h4("The iris species that matches your characteristics is:"),
       htmlOutput("predSpecies"),
       h4("It looks like this:"),
       imageOutput("imageSpecies")
    )
  )
))


