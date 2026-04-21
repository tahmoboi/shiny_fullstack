setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(shiny)
library(lubridate)
library(DT)

# Function for saving data to a CSV file
log_line <- function(newdata, filename = 'app_data.csv'){
  (dt <- Sys.time() %>% round %>% as.character)
  (newline <- c(dt, newdata) %>% paste(collapse=',') %>% paste0('\n'))
  cat(newline, file=filename, append=TRUE)
  print('Data stored!')
}

################################################################################
################################################################################
ui <- fluidPage(
  titlePanel(h2("Sewanee International Student: Major Choice")),
  p(h4(strong("What is this survey?")),
    "This app collects information about major choices among international students
    at Sewanee: The University of the South. It captures each student's country of
    origin, chosen major, academic year, primary motivation for their choice,
    post-graduation plans, and confidence level in their major."),

  p(h4(strong("How to use this form:")),
    "Fill in each field below with your information, then click",
    em("\"Add to File\""), "at the bottom to save your response.
    Each submission is saved automatically- no login or account is required.
    Please submit only once."),

  helpText("Data Source: Primary data collected via this survey instrument by
            Tahmid Hossain Bhuiyan (Class of 2029) as part of a data story#5
            project for ESCI 222 class. Data is stored
            locally and used solely for academic research purposes."),

  hr(), #adds a thin line separation

  fluidRow(
    # Free text input space for country
    column(4, textInput(inputId = 'country',
                        label='Country?',
                        value='',
                        placeholder = 'e.g. Bangladesh',
                        width = '95%')),

    # Dropdown for declared or intended major
    column(4, selectInput(inputId = 'major',
                          label = "Select Your Major",
                          choices = c(
                            "American Studies",
                            "Anthropology",
                            "Art",
                            "Art History",
                            "Asian Studies",
                            "Biochemistry",
                            "Biology",
                            "Chemistry",
                            "Classical Languages",
                            "Computer Science",
                            "Creative Writing",
                            "Data Science",
                            "Economics",
                            "English",
                            "Environment and Sustainability",
                            "Environmental Arts and Humanities",
                            "Finance",
                            "Forestry",
                            "French and French Studies",
                            "Geology",
                            "German and German Studies",
                            "Greek",
                            "History",
                            "Interdisciplinary Self-Designed",
                            "International and Global Studies",
                            "Latin",
                            "Mathematics",
                            "Medieval Studies",
                            "Music",
                            "Natural Resources and the Environment",
                            "Neuroscience",
                            "Philosophy",
                            "Physics",
                            "Politics",
                            "Psychology",
                            "Religious Studies",
                            "Rhetoric",
                            "Russian",
                            "Sociology",
                            "Spanish",
                            "Theatre",
                            "Women's and Gender Studies"
                          ),
    ),
    ),
    # Radio Buttons for 4 years of college
    column(4, radioButtons(inputId = 'year',
                           label='What year are you?',
                           choices = c('Freshman', "Sophomore","Junior","Senior"),
                           inline = TRUE,
                           width='95%'))),

  br(), #Line Breaks for smoother UI
  br(),

  fluidRow(
    # Dropdown for what motivated to choose the major question.
    column(4, selectInput(inputId = 'influence',
                          label= "What was your main motivation behind choosing this major?",
                          choices= c('Passion',
                                     'Salary Potential',
                                     'Family Expectations',
                                     'Job Security',
                                     'Social Impact',
                                     'Other'))),
    # Dropdown for postgrad choices
    column(4,selectInput(inputId='postgrad',
                         label='What are you planning to do after graduation?',
                         choices=c('Business',
                                   'Grad School',
                                   'Job',
                                   'Undecided'))),

    #Slider for confidence level in major selection
    column(4, sliderInput(inputId = 'confidence',
                        label= 'On a scale of 1-5, how confident are you with your major choice?',
                        min= 1,
                        max= 5,
                        value= 1)),

  ),
  br(),
  br(),

  fluidRow(column(2),
           # Save button!
           column(8, actionButton('save',
                                  h3('Add to File'),
                                  width='100%')),
           column(2))
)

################################################################################
################################################################################

server <- function(input, output) {

  # Save button ================================================================
  observeEvent(input$save, {
    newdata <- c(input$country, input$major, input$influence,input$year, input$postgrad, input$confidence) #Added all 6 inputs
    log_line(newdata)
    showNotification("Response Saved Successfully!")
  })
  #=============================================================================

}

################################################################################
################################################################################

shinyApp(ui, server)

