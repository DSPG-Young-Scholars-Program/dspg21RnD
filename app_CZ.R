if(!require(shiny)) install.packages("shiny", repos = "http://cran.us.r-project.org")
if(!require(shinythemes)) install.packages("shinythemes", repos = "http://cran.us.r-project.org")
if(!require(rsconnect)) install.packages("rsconnect", repos = "http://cran.us.r-project.org")
if(!require(shinycssloaders)) install.packages("shinycssloaders", repos = "http://cran.us.r-project.org")
if(!require(shinyjs)) install.packages("shinyjs", repos = "http://cran.us.r-project.org")
if(!require(shinydashboard)) install.packages("shinydashboard", repos = "http://cran.us.r-project.org")

if(!require(sjmisc)) install.packages("sjmisc", repos = "http://cran.us.r-project.org")
if(!require(RColorBrewer)) install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")
if(!require(ggthemes)) install.packages("ggthemes", repos = "http://cran.us.r-project.org")
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(DT)) install.packages("DT", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")
if(!require(readr)) install.packages("readr", repos = "http://cran.us.r-project.org")
if(!require(stringr)) install.packages("stringr", repos = "http://cran.us.r-project.org")
if(!require(leaflet)) install.packages("leaflet", repos = "http://cran.us.r-project.org")

prettyblue <- "#232D4B"
navBarBlue <- '#427EDC'
#options(spinner.color = prettyblue, spinner.color.background = '#ffffff', spinner.size = 3, spinner.type = 7)

colors <- c("#232d4b","#2c4f6b","#0e879c","#60999a","#d1e0bf","#d9e12b","#e6ce3a","#e6a01d","#e57200","#fdfdfd")

#setwd("/home/zz3hs/git/dspg21RnD")

# data -----------------------------------------------------------
abstracts <- readRDS("data_shiny/abstracts_shiny.rds")
abstracts_oecd <- abstracts %>% 
  filter(IS_AI_OECD == T)

# user -------------------------------------------------------------
ui <- navbarPage(title = "RnD",
                 selected = "overview",
                 theme = shinytheme("lumen"),
                 tags$head(tags$style('.selectize-dropdown {z-index: 10000}')),
                 useShinyjs(),
                 # main -----------------------------------------------------------
                 # tabPanel("Home", value = "home",
                 #          fluidRow(style = "margin: 6px;",
                 #                   align = "center",
                 #                   br("", style = "padding-top:10px;"),
                 #                   img(src = "uva-dspg-logo.jpg", class = "topimage", width = "20%", style = "display: block; margin-left: auto; margin-right: auto;"),
                 #                   br(""),
                 #                   h2(strong("Addressing Barriers to Health in Patrick County, Virginia"),
                 #                   br(""),
                 #                   h4("Data Science for the Public Good Program"),
                 #                   h4("University of Virginia"),
                 #                   h4("Biocomplexity Insititute"),
                 #                   br(),
                 #                   br(),
                 #                   br(),
                 #                   br(),
                 #                   br(),
                 #                   p(tags$small(em('Last updated: August 2020')))
                 #                   )
                 #          )
                 # ),
                 
                 # main -----------------------------------------------------------
                 tabPanel("Overview", value = "overview",
                          fluidRow(style = "margin: 2px;",
                                   align = "center",
                                   # br("", style = "padding-top:2px;"),
                                   # img(src = "uva-dspg-logo.jpg", class = "topimage", width = "20%", style = "display: block; margin-left: auto; margin-right: auto;"),
                                   br(""),
                                   h1(strong("R&D Text Corpora Filtering and Data Mining"),
                                      br(""),
                                      h4("Data Science for the Public Good Program"),
                                      h4("University of Virginia"),
                                      h4("Biocomplexity Insititute"),
                                      br()
                                   )
                          ),
                          fluidRow(style = "margin: 6px;",
                                   column(4,
                                          h2(strong("Project Background")),
                                          p(strong("The problem."), "Rural counties often face challenges in providing health care access to their residents given limited", a(href = "https://www.ruralhealthinfo.org/topics/hospitals", "health facilities", target = "_blank"), 
                                            "available, lack of broadband infrastructure that makes it difficult to provide", a(href = "https://www.ruralhealthinfo.org/topics/telehealth", "telemedicine access", target = "_blank"), "or communicate health information, and individual-level", 
                                            a(href = "https://www.ruralhealthinfo.org/topics/social-determinants-of-health", "inequalities", target = "_blank"), "that pose barriers to health care use and health 
                                            behaviors. Identifying areas of high need or potential solutions may also be difficult for rural areas without adequate resources to acquire, analyze, and interpret 
                                            relevant data."),
                                          p(),
                                          p(strong("The setting."), a(href = "https://www.co.patrick.va.us/", "Patrick County", target = "_blank"), "is a rural area in Virginia’s Central Piedmont, bordering North Carolina, 
                                            with a declining population of approximately 17,600 people. Like many other rural areas in the United States, Patrick County is having difficulty meeting its residents’ health and quality of life needs. 
                                            The county’s", a(href = "https://www.countyhealthrankings.org/app/virginia/2019/rankings/patrick/county/outcomes/overall/snapshot", "doctor to patient ratios", target = "_blank"), 
                                            "of 3,530 to 1 for primary care providers, 8,840 to 1 for dentists, and 2,520 to 1 for mental health providers are 3- 
                                            to 8-times higher than statewide, and the county’s only hospital closed in 2017. At the same time, the median income for Patrick County residents is $42,900, 
                                            46% of children living in the county are eligible for free or reduced-price school lunch, and 12% of residents are food insecure."),
                                          p(),
                                          p(strong("The project."), "This University of Virginia", a(href = "https://biocomplexity.virginia.edu/social-decision-analytics", "Biocomplexity Institute", target = "_blank"), 
                                            "Data Science for Public Good (DSPG) project aimed to build local capacity, leverage social and data science to address current and future resident well-being, and enhance 
                                            data-driven decision making about rural health in Patrick County, Virginia.")
                                          ),
                                   column(4,
                                          h2(strong("Our Work")),
                                          p("Our research team worked closely with Patrick County Extension Office, Virginia Department of Health, and Healthy Patrick County coalition stakeholders 
                                            to identify the county’s priority challenges in the area of health. The research team reviewed a prior", a(href = "https://www.vdh.virginia.gov/west-piedmont/2020/05/27/patrick-county-health-needs-improvement-plan-completed/", 
                                                                                                                                                       "community health assessment,", target = "blank"), a(href = "https://www.pubs.ext.vt.edu/VCE/VCE-596/VCE-596-75/VCE-1002-75.html", "situation analysis", target = "_blank"),
                                            "relevant funding applications, and held a listening meeting with stakeholders to identify these challenges. Lack of 
                                            data on health care access, food access as related to diabetes and heart disease prevalence, older adult health, and digital connectivity that would facilitate 
                                            access to telemedicine emerged as key problems where providing actionable insights could address barriers to Patrick County residents’ health."),
                                          p(),
                                          p("We implemented the", a(href = "https://doi.org/10.1162/99608f92.2d83f7f5", "data science framework", target = "_blank"), "and identified, acquired, profiled, and used 
                                            publicly available data to provide Patrick County with data-driven resources in each of the four priority areas. We:"),
                                          tags$li("Provided census tract- and census block group-level maps of Patrick County residents'", strong("sociodemographic and socioeconomic characteristics,"), " highlighting underprivileged areas."),
                                          tags$li("Created census tract-level maps on", strong("older adult health"), "to show the geographic distribution of older adults in the county by gender and
                                                  type of disability, identifying areas where providing telehealth or travelling preventive care services may be particularly important."),
                                          tags$li("Mapped residents'", strong("computing device and internet access"), "at census block group level, and constructed 10- and 15-minute isochrones (areas of equal travel time) from households to free
                                                  wifi hotspots to highlight internet gaps that could suggest where new wi-fi hotspots could be optimally placed to provide internet access to more residents."),
                                          tags$li("Calculated and mapped", strong("emergency medical service (EMS) station coverage"), "of households within 8-, 10-, and 12-minute travel times, identifying areas difficult to reach within 
                                                  standard EMS travel thresholds."),
                                          tags$li("Constructed", strong("food access"), "maps by census tract, 10- and 15-minute isochrones from households to grocery stores and farmers markets, and maps of food security resources in the county,
                                                  highlighting food deserts and areas that could benefit from programs facilitating access to fresh produce."),
                                          p(),
                                          p("This dashboard compiles our findings and allows extension professionals, stakeholders, and other users to explore the information interactively.")
                                          ),
                                   column(4,
                                          h2(strong("Dashboard Aims")),
                                          p("Our dashboard is aimed at:"),
                                          p(strong("Patrick County extension professionals and the communities they serve."), "Information available through the interface helps extension 
                                            agents identify areas where residents may not have access to internet, or areas with a high smartphone ownership share, suggesting what channels agents may 
                                            want to use to disseminate health-related information most effectively. Information on older adult populations and grocery store access can help extension agents 
                                            better understand where underserved populations live and how to advocate on their behalf."),
                                          p(strong("Local health-related agencies and departments seeking data insights to inform their decision-making."), "For local stakeholders, identifying broadband 
                                            access gaps that limit access to telemedicine, grocery store access gaps, and areas with high proportions of older adults with independent living difficulty can suggest 
                                            optimal locations for placing free wifi hotspots, providing grocery delivery services, devising mobile health unit routes, or can inform other solutions that would benefit 
                                            a broad population base."),
                                          p(strong("State government representatives in the Virginia Department of Health and the State Office of Rural Health."), "These and similar stakeholders may 
                                            need small or rural area-specific insights that Centers for Disease Control and other county-level datasets cannot provide.")
                                          )
                                          ),
                          fluidRow(align = "center",
                                   p(tags$small(em('Last updated: August 2020'))))
                                   ),
                 # Data and Methods -----------------------------------------------------------
                 tabPanel("Data & Methods", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Data and Methodology"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(5,
                                          h4(strong("DATA")),
                                          p("We examined research projects abstracts within the Federal RePORTER."),
                                          p("The Federal RePORTER is a database of federally funded science research projects. The database provides information on projects, including supporting
                                            agencies, starting dates, project terms, and abstracts. Our dataset consisted project abstracts that began within the years of 2009-2018, 
                                            or around ______ abstracts.")),
                                   column(5,
                                          h4(strong("Methodology")),
                                          fluidRow( style = "margin: 6px;",
                                                   p("", style = "padding-top:10px;"),
                                                   h4(strong("Identifying Emerging Topics")),
                                                          p("In order to identify which topics in AI are emerging, we use linear regression on the abstracts about a topic over the years in the data.
                                            A positive correlation between the topic prevalence in our corpus over time indicates that it is an emerging topic in AI, or a 'hot' topic.
                                            A negative correlation tells us that this topic is decreasing in popularity, or is a 'cold' topic.")
                                                          )
                                          
                                   )
                                   )
                          ),
                 # Method 1. OECD, Cierra -----------------------------------------------------------
                 tabPanel("Filtering Method 1. OECD", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Term matching"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4,
                                          h4(strong("OECD Terms")),
                                          p("To perform term matching, we used a list of artificial intelligence-related terms from the Organization for Economic Co-operation and Development (OECD). 
                                            The list of key terms are broken into 2 groups: core terms and non-core terms. See the listed key terms below."),
                                          p("In addition to a list of key terms, OECD provided methodology for retriving documents related to artificial intelligence. As suggested by OECD, we tagged a document
                                            as being related to AI if at least one core term or two non-core terms were found within the project abstract."),
                                          h5(strong("Core Terms")),
                                          wellPanel(id="tPanel",style="overflow-y:scroll; max-height: 200px",
                                                    tags$ul(tags$li("adaboost"),
                                                            tags$li("artificial intelligence"),
                                                            tags$li("artificial neural network"),
                                                            tags$li("back propagation"),
                                                            tags$li("back propagation neural network"),
                                                            tags$li("computational intelligence"),
                                                            tags$li("computer vision"),
                                                            tags$li("convolutional neural network"),
                                                            tags$li("deep belief network"),
                                                            tags$li("deep convolutional neural network"),
                                                            tags$li("deep learn"),
                                                            tags$li("deep neural network"),
                                                            tags$li("elman neural network"),
                                                            tags$li("expert system"),
                                                            tags$li("fee forward neural network"),
                                                            tags$li("inference engine"),
                                                            tags$li("machine intelligence"),
                                                            tags$li("machine learn"),
                                                            tags$li("machine translation"),
                                                            tags$li("machine vision"),
                                                            tags$li("multilayer neural network"),
                                                            tags$li("natural language process"),
                                                            tags$li("perceptron"),
                                                            tags$li("random forest"),
                                                            tags$li("rbf neural network"),
                                                            tags$li("recurrent neural network"),
                                                            tags$li("self organize map"),
                                                            tags$li("spike neural network"),
                                                            tags$li("supervise learn"),
                                                            tags$li("support vector machine"),
                                                            tags$li("svm classifier"),
                                                            tags$li("unsupervised learn"))),
                                          h5(strong("Non-core Terms")),
                                          wellPanel(id="tPanel",style="overflow-y:scroll; max-height: 200px",
                                                    tags$ul(tags$li("actor critic"),
                                                            tags$li("analog vlsi"),
                                                            tags$li("associative memory"),
                                                            tags$li("autonomous vehicle"),
                                                            tags$li("bayes classifer"),
                                                            tags$li("bayesian belief network"),
                                                            tags$li("bioinformatics"),
                                                            tags$li("camera calibration"),
                                                            tags$li("collaborative system"),
                                                            tags$li("commonsense reason"),
                                                            tags$li("computational biology"),
                                                            tags$li("datum mine"),
                                                            tags$li("decision tree"),
                                                            tags$li("description logic"),
                                                            tags$li("dimensionality reduction"),
                                                            tags$li("discriminant analysis"),
                                                            tags$li("fuzzy logic"),
                                                            tags$li("gene ontology"),
                                                            tags$li("hide markov model"),
                                                            tags$li("humanoid"),
                                                            tags$li("image alignment"),
                                                            tags$li("image match"),
                                                            tags$li("information retrieval"),
                                                            tags$li("kegg pathway"),
                                                            tags$li("knowledge base"),
                                                            tags$li("knowledge representation and reason"),
                                                            tags$li("linear discriminant"),
                                                            tags$li("markov decision process"),
                                                            tags$li("mulitclass classification"),
                                                            tags$li("naive bayes"),
                                                            tags$li("name entity recognition"),
                                                            tags$li("near neighbor classifier"),
                                                            tags$li("neural network"),
                                                            tags$li("neuro fuzzy"),
                                                            tags$li("neuromorphic compute"),
                                                            tags$li("neuromorphic hardware"),
                                                            tags$li("non rigid registration"),
                                                            tags$li("nonmonotonic reason"),
                                                            tags$li("object recognition"),
                                                            tags$li("opinion mine"),
                                                            tags$li("optimal search"),
                                                            tags$li("pattern analysis"),
                                                            tags$li("pattern recognition"),
                                                            tags$li("person re identification"),
                                                            tags$li("principal component analysis"),
                                                            tags$li("question answer"),
                                                            tags$li("radial basis function"),
                                                            tags$li("rbf kernel"),
                                                            tags$li("reinforcement learn"),
                                                            tags$li("rigid registration"),
                                                            tags$li("robot"),
                                                            tags$li("sarsa"),
                                                            tags$li("sensor datum fusion"),
                                                            tags$li("sensor network"),
                                                            tags$li("speech recognition"),
                                                            tags$li("stereo match"),
                                                            tags$li("symbolic reason"),
                                                            tags$li("system and control theory"),
                                                            tags$li("template match"),
                                                            tags$li("text categorization"),
                                                            tags$li("text mine"),
                                                            tags$li("text summarization"),
                                                            tags$li("word sense disambiguation")))),
                                   column(8,
                                          h4(strong("Term Matching Results")),
                                          tabsetPanel(
                                            tabPanel("Funding Sources",
                                                     plotOutput("oecd_agency"),
                                                     plotOutput("oecd_year")
                                                     
                                            ),
                                            tabPanel("NMF Model Fitting",
                                                     p("The highest Coherence Score was achieved with Number of Topics = 20. Based on the coherence model, 20 was the optimal number of topics."),
                                                     img(src = "oecd_coherence.png", style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "600px")
                                            ),
                                            tabPanel("Emerging Topics",
                                                     p(""),
                                                     p("Our interactive plots visualize the hot and cold topics among identified AI-related abstracts."),
                                                     
                                                     selectInput(
                                                       inputId = "k", 
                                                       label = "Select Number of Topics:",
                                                       width = "50%", 
                                                       choices = c('10 Topics', '20 Topics', '30 Topics'),
                                                       selected = '10 Topics'
                                                     ),
                                                     conditionalPanel("input.k == '10 Topics'",
                                                                      img(src = "oecd_10_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k == '20 Topics'",
                                                                      img(src = "oecd_20_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k == '30 Topics'",
                                                                      img(src = "oecd_30_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     )
                                            )
                                          )
                                   )
                                          )),

                
                 # Method 2. Term Matching + LDA, Haleigh -----------------------------------------------------------
                 tabPanel("Filtering Method 2. Term Matching + LDA", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Term matching + LDA"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4,
                                          h4(strong("Method Borrowed from Eads and others")),
                                          p("This method uses a combination of term matching and LDA in order to filter to AI-related grant abstracts."),
                                          p("Eads and others use a more supervised method for filtering their corpus.  We adapt this to our abstract data.
                                            The method uses LDA topic modeling in combination with a keyword list in order to identify topics about AI in
                                            a corpus whether they directly mention the keywords or not. Before topic modeling, we filter our data to only
                                            include projects produced by the NSF, and within the subject area of Computer and Information Science and Engineering.
                                            We do this to have a more narrow corpus in hopes to increase the AI presence within the data.  After filtering, we have
                                            about 16,000 grant abstracts.  We found that an LDA topic model with 100 topics gave us several topics about AI. As an intital
                                            keyword list, we use the AI core terms identified by the OECD paper (ref?), and extend this with the most common words used in
                                            the AI-related topics identified by our topic model."),
                                          p("After obtaining the AI-related topics and keyword list, we used the /wheat_filtration/ package made available by Eads et al. to 
                                            filter the overall corpus to those related to AI.")),
                                   column(8,
                                          h4(strong("NMF Topic Modeling Results")),
                                          tabPanel("Title",
                                                   p(""),
                                                   column(6,
                                                          selectInput("olddrop", "1. Select Variable:", width = "100%", choices = c(
                                                            "Percent with Vision Difficulty" = "visdiff",
                                                            "Percent with Ambulatory Difficulty" = "ambdiff",
                                                            "Percent with Self-Care Difficulty" = "carediff",
                                                            "Percent with Cognitive Difficulty" = "cogdiff",
                                                            "Percent with Independent Living Difficulty" = "ildiff",
                                                            "Percent with Any Disability" = "disab",
                                                            "Percent in Poverty" = "inpov",
                                                            "Percent in Labor Force" = "labfor")
                                                          )),
                                                   p(tags$small("Data Source: Federal RePORTER abstracts."))
                                                   
                                          )
                                   )
                                          )
                 ),
                 # Method 3. Bert, Crystal -----------------------------------------------------------
                 tabPanel("Filtering Method 3. Embedding", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Sentence Bert Embedding"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4,
                                          h4(strong("Method")),
                                          h5(strong("Web Scraping")),
                                          p("We scraped" , a(href = "https://en.wikipedia.org/wiki/Artificial_intelligence", "Artificial Intelligence Wikipedia page", target = "_blank") , "and extracted text. 
                                            We tokenized the paragraphs into sentences."),
                                          h5(strong("Sentence BERT Embedding and Cosine Similarity Score")),
                                          p("We also tokenized the abstracts into sentences. Then, we computed sentence embeddings using", a(href = "https://www.sbert.net/", "Sentence BERT (SBERT)", target = "_blank"), 
                                            ". We then compare the embedding of AI corpus to Federal RePORTER abstracts using cosine-similarity. Cosine-similarity score ranges from 0 to 1, higher the score, more similar two sentences are to each other. For each sentence in an abstract, we identified the top ten most similar sentences
                                            from our AI corpus and obtained their cosine-similarity scores. We then took the average of the ten scores and obtained an average score for each abstract, indicating how similar the abstract is to AI. We classify an abstract with a score that is 2.5 standard deviation above the mean as AI related." ),
                              
                                          h5(strong("Choosing a Cutoff Score")),
                                          p("To choose a cutoff cosine similarity score,")),
                                   column(8,
                                          h4(strong("Topic Modeling Results")),
                                          tabsetPanel(
                                            tabPanel("Funding Sources",
                                                     p("")
                                            ),
                                            tabPanel("NMF Model Fitting",
                                                     p("Number of topics = 10 achieved the highest coherence with topics. Thus we based on the coherence model, 10 is the optimal number of topics."),
                                                     img(src = "nmf_fitting_bert.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                            ),
                                            tabPanel("Emerging Topics",
                                                     p(""),
                                                     p("Our interactive plots visualize the hot and cold topics among identified AI-related abstracts."),
                                                     
                                                     selectInput(
                                                       inputId = "k", 
                                                       label = "Select Number of Topics:",
                                                       width = "50%", 
                                                       choices = c('10 Topics', '20 Topics', '30 Topics'),
                                                       selected = '10 Topics'
                                                       ),
                                                     conditionalPanel("input.k == '10 Topics'",
                                                       img(src = "bert_trends_10topics.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k == '20 Topics'",
                                                       img(src = "bert_trends_20topics.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k == '30 Topics'",
                                                                      img(src = "bert_trends_30topics.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     p(""),
                                                     p(""),
                                                     p("")

                                            )
                                          )
                                   )
                                   )
                          ),

                 # contact -----------------------------------------------------------
                 tabPanel("Contact", value = "contact",
                          fluidRow(style = "margin-left: 300px; margin-right: 300px;",
                                   h1(strong("Contact"), align = "center"),
                                   br(),
                                   h4(strong("UVA Data Science for the Public Good")),
                                   p("The", a(href = 'https://biocomplexity.virginia.edu/social-decision-analytics/dspg-program', 'Data Science for the Public Good (DSPG) Young Scholars program', target = "_blank"), 
                                     "is a summer immersive program held at the", a(href = 'https://biocomplexity.virginia.edu/social-decision-analytics', 'University of Virginia Biocomplexity Institute’s Social and Decision Analytics division (SDAD).'), 
                                     "In its seventh year, the program engages students from across the country to work together on projects that address state, federal, and local government challenges around 
                                     critical social issues relevant in the world today. DSPG young scholars conduct research at the intersection of statistics, computation, and the social sciences 
                                     to determine how information generated within every community can be leveraged to improve quality of life and inform public policy. For more information on program 
                                     highlights, how to apply, and our annual symposium, please visit", a(href = 'https://biocomplexity.virginia.edu/social-decision-analytics/dspg-program', 'the official Biocomplexity DSPG website.', target = "_blank")),
                                   p("", style = "padding-top:10px;")
                                   ),
                          fluidRow(style = "margin-left: 300px; margin-right: 300px;",
                                   column(6, align = "center",
                                          h4(strong("DSPG Team Members")),
                                          img(src = "team-Crystal.jpeg", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Cierra.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Haleigh.png", style = "display: inline; border: 1px solid #C0C0C0;", width = "150px"),
                                          p(a(href = '', 'Crystal Zang', target = '_blank'), "(University of Pittsburgh Graduate School of Public Health, Biostatistics);",
                                            a(href = '', 'Cierra Oliveira', target = '_blank'), "(Clemson University);",
                                            a(href = '', 'Haleigh Tomlin', target = '_blank'), "(Washington and Lee University)."),
                                          p("", style = "padding-top:10px;")
                                   ),
                                   column(6, align = "center",
                                          h4(strong("UVA SDAD Team Members")),
                                          img(src = "team-Kathryn.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Eric.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Joel.png", style = "display: inline; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Stephanie.png", style = "display: inline; border: 1px solid #C0C0C0;", width = "150px"),
                                          p(a(href = "", 'Kathryn Kinehan', target = '_blank'), "(Project Lead, Research Scientist);",
                                            a(href = "", 'Eric Oh', target = '_blank'), "(Research Assistant Professor);",
                                            a(href = '', 'Joel Thurston', target = '_blank'), "(Senior Scientist).",
                                          a(href = "", 'Stephanie Shipp', target = '_blank'), "(Deputy Division Director, Research Professor);"),
                                          p("", style = "padding-top:10px;")
                                   )
                          ),
                          fluidRow(style = "margin-left: 300px; margin-right: 300px;",
                                   h4(strong("Project Stakeholders")),
                                   p(a(href = '', 'John Jankowski', target = '_blank'), "(NCSES, Director of R&D Statistics Program);",
                                     a(href = '', 'Audrey Kindlon', target = '_blank'), "(NCSES, Survey Statistician)."),
                                   p("", style = "padding-top:10px;"),
                                   h4(strong("Acknowledgments")),
                                   p("We would like to thank  XXXXX  for their input to this project.")
                          )
                          ),
                 inverse = T)



# server -----------------------------------------------------------
server <- function(input, output, session) {
  # Run JavaScript Code
 # runjs(jscode)
  
  # oecd agency plot
  output$oecd_agency <- renderPlot({
    abstracts_oecd %>% 
      group_by(DEPARTMENT) %>% 
      count() %>% 
      ggplot(aes(x=DEPARTMENT, y=n))+
      geom_bar(stat='identity')
  })
  
  # oecd start year plot
  output$oecd_year <- renderPlot({
    
    abstracts_oecd %>% 
      mutate(d=as.Date(PROJECT_START_DATE, format="%m/%d/%Y")) %>% 
      mutate(d=format(d,"%Y")) %>% 
      filter(d<"2019") %>% 
      group_by(d) %>% 
      count() %>% 
      ggplot(aes(x=d, y=n))+
      geom_bar(stat='identity')+
      theme(axis.text.x=element_text(angle=90))
  })
}

shinyApp(ui = ui, server = server)