# Install required packages if not already installed
# install.packages("shiny")
# install.packages("dplyr")
# install.packages("DT")

# Load necessary libraries
library(shiny)
library(dplyr)
library(DT)

# Sample data (replace this with your actual data)
students <- data.frame(
  StudentID = c(1, 2, 3, 4),
  Name = c("Student1", "Student2", "Student3", "Student4"),
  FeesPaid = c(1000, 1500, 800, 1200),
  TotalFees = c(2000, 2000, 1000, 1500)
)

# Define the UI
ui <- fluidPage(
  titlePanel("School Fees Management"),
  sidebarLayout(
    sidebarPanel(
      selectInput("student_id", "Select Student:", choices = students$StudentID),
      actionButton("refresh_btn", "Refresh")
    ),
    mainPanel(
      dataTableOutput("fees_table")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  # Reactive function to filter student data based on selection
  filtered_data <- reactive({
    students %>% filter(StudentID == input$student_id)
  })

  # Render the data table
  output$fees_table <- renderDataTable({
    filtered_data()
  })

  # Event handler to refresh the data table
  observeEvent(input$refresh_btn, {
    output$fees_table <- renderDataTable({
      filtered_data()
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
