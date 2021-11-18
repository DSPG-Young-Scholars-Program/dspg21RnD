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
if(!require(gt)) install.packages("gt", repos = "http://cran.us.r-project.org")


colors <- c("#232d4b","#2c4f6b","#0e879c","#60999a","#d1e0bf","#d9e12b","#e6ce3a","#e6a01d","#e57200","#fdfdfd")

#setwd("/Users/czang/Documents/UVA/2021DSPG/CrystalCode/dspg21RnD/shiny")
# data -----------------------------------------------------------
abstracts_gather  = readRDS("data_shiny/abstracts_gather.rds")


# user -------------------------------------------------------------
ui <- navbarPage(title = HTML("<img src='./DSPG_black-01.png' width='120px' style='margin-top:-10px;'/>"),
                 selected = "overview",
                 theme = shinytheme("lumen"),
                 tags$head(tags$style('.selectize-dropdown {z-index: 10000}')),
                 useShinyjs(),

                 #Tab1. Overview -----------------------------------------------------------
                 tabPanel(id= "overview","Overview", value = "overview",
                          fluidRow(style = "margin: 2px;",
                                   align = "center",
                                   # img(src = "uva-dspg-logo.jpg", class = "topimage", width = "20%", style = "display: block; margin-left: auto; margin-right: auto;")
                                   h1(strong("R&D Text Corpora Filtering and Data Mining"),
                                      br(""),
                                      h4(strong("Data Science for the Public Good Program")),
                                      img(src = "BII_logo.png", width = "250px"),
                                      #h4("University of Virginia"),
                                      #h4("Biocomplexity Insititute"),
                                      br()
                                   )
                          ),
                          fluidRow(style = "margin: 6px;",
                            column(6, style="padding-right:25px",
                                   h2(strong("Project Background")),
                                   p("This research builds upon an ongoing collaboration between the UVA Biocomplexity Institute Social and Decision Analytics Division (SDAD) and the National Center for Science and Engineering
                                             Statistics (NCSES)."),
                                   img(src = "BII_logo.png", width = "300px", style = "padding-right:50px; padding-left:30px"),
                                   img(src = "nsf_logo.jpg", width = "100px"),
                                   img(src = "ncses-logo.png", width = "100px"),
                                   br(), br(),
                                   fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                            h4(strong("Overall Goal: what can we learn from administrative data about federally funded research?")),
                                            p(strong("In this work we examine the use of administrative records to supplement or enhance data collected in NCSES surveys."))
                                   ),
                                   br(),
                                   h4(strong("Past Work")),
                                    p("This project builds upon work from last year's DSPG project:", a(href = "https://dspgtools.shinyapps.io/RnD-Emerging-Topics/", "R&D Abstracts: Emerging Topic Identification", target = "_blank"), ".  Specifically, we utilize the dataset created and some of the methods from last year's DSPG work."),

                                            #". Abstracts were cleaned and pre-processed through tokenization and lemmatization, stop word removal, and n-grams creation.")
                            ),
                            column(6, style = "padding-left:25px",
                                   h2(strong("Research Question")),
                                   p("In keeping with the overall goal of the work, we have a specific focus for this project."),
                                   fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                            h4(strong("How can we identify topics and topic trends around a particular theme in federally funded research?")), 
                                            h4(strong("Specifically, what AI-related topics are present in federally funded research?  What trends do these topics exhibit?"))
                                   ),
                                   
                                  
                                   h2(strong("Our Work - Brief Introduction")),
                                   p("We utilize data from Federal RePORTER, a database of federally funded grants, that we cleaned and processed in prior work.  Our problem can be broken down into two main pieces."),
                                   tags$ol(
                                     tags$li(strong("Filtering"), ": we filter our data to extract only those projects about AI."),
                                     tags$li(strong("Topic Modeling"), ": we then run a topic model on our AI-related projects to discover topics and their trends in the area of AI.")
                                   ),

                                  p("AI is a complex and hard to define theme, so this filtering problem is challenging!  There is no “gold-standard” solution to the filtering problem and we have no ground truth for our data on which projects are related to AI and which are not.
                                     In this project, we implement and explore three unsupervised filtering methods:"),
                                  tags$ul( 
                                  tags$li(strong("Term Matching"), ", as proposed by the Organisation for Economic Co-operation and Development (OECD)."),
                                   tags$li(strong("Term Matching + Latent Dirichlet Allocation (LDA)"), ", proposed by Eads et al."),
                                   tags$li(strong("Sentence BERT Embeddings"), ", which compare the similarity between the AI Wikipedia page and federally funded grant abstracts.")
                                  ),
                                   p("After retrieving abstracts that are related to AI, we perform topic modeling and identify federally funded topic trends within the field of AI. Future work includes measuring the performance of these three filtering methods."),
                                   p("This dashboard compiles our findings and allows users to explore the information interactively.")
                            )
                            ),
                                   
                          fluidRow(align = "center",
                                   p(tags$small(em('Last updated: August 2021')))
                                   )
                            ),

                # Tab2. Data and Methods -----------------------------------------------------------
                 tabPanel(id= "data_methods","Data & Methods", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Data and Methodology"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(6, style = "padding-left:25px",
                                          h3(strong("Data")),
                                          p("We examined research projects within ", a(href = "https://federalreporter.nih.gov/", "Federal RePORTER", target = "_blank"), ", a database of federally funded grants. The data includes project abstracts and information such as funding agency, start date, and total cost. During prior work we cleaned and processed this dataset by"),
                                          tags$ul(
                                            tags$li("filling in missing project start dates,"),
                                            tags$li("deduplicating records, and"),
                                            tags$li("cleaning and processing the project abstract text using natural language processing (NLP) techniques such as tokenization, lemmatization, stop word removal, and adding bigrams and trigrams.")
                                          ),
                                          br(),
                                          h4(strong("After processing, our dataset consisted of 690,814 projects."), style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                          br(),
                                          img(src = "all_data_agency.png", style="display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "500px"),       #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;"),
                                          br(), 
                                          p(strong("Note: "), "The National Institutes of Health (NIH) is included in the Department of Health and Human Services (HHS)."),
                                          br(),
                                          img(src = "all_data_start_year.png", style="display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "500px"),   #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;")
                                          
                                          ),
                                   column(6, style = "padding-left:25px",
                                          h3(strong("Methodology")),
                                          p("Finding federally funded topics and topic trends in AI is mainly a two-step problem."),
                                          tags$ol(
                                            tags$li(strong("Filtering"), ": we filter the data to extract only those projects about AI."),
                                            tags$li(strong("Topic Modeling"), ": we then run a topic model on our AI-related projects to discover topics and their trends in the area of AI.")
                                          ),
                                          fluidRow( style = "margin: 6px;",
                                                    #p("", style = "padding-top:10px;"),
                                                    h4(strong("Filtering Methods")),
                                                    p("We use three filtering methods in this project. Each method has a corresponding dashboard tab on which the method is described."),
                                                    tags$ul( 
                                                      tags$li(strong("Term Matching"), ", as proposed by the Organisation for Economic Co-operation and Development (OECD) [1]"),
                                                      tags$li(strong("Term Matching + Latent Dirichlet Allocation (LDA)"), ", proposed by Eads et al. [2]"),
                                                      tags$li(strong("Sentence BERT Embeddings"), ", which compare the similarity between the AI Wikipedia page and federally funded grant abstracts.")
                                                    ),
                                                    br(),
                                                    h4(strong("Topic Modeling")),
                                                    p("The goal of a topic model is to automatically extract topics from text data by clustering terms that appear together frequently in the text.  A topic is represented by one cluster of terms, where the terms are ordered by their “importance” to the topic. Generally the top five or ten words of a topic are used in analysis."),
                                                    fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                                             h5(strong("Topic Example")),
                                                             p("Here is a list of the five most important terms to a topic produced by one of our models."),
                                                             tags$ul(
                                                               tags$li("algorithm"), 
                                                               tags$li("learning"), 
                                                               tags$li("learn"),
                                                               tags$li("machine_learning"),
                                                               tags$li("theory")
                                                             ),
                                                             p("Based on these five words, we assume this topic is about machine learning.")
                                                    ),
                                                    br(),
                                                    p("In addition to a topic-term distribution which describes the most important terms per topic, a topic model also computes a document-topic distribution which gives the amount of each topic in each document in the data.  Note that a document can contain multiple topics."),
                                                    h5(strong("Non-Negative Matrix Factorization")),
                                                    p("We use Non-Negative Matrix Factorization (NMF) [3] to perform topic modeling on the filtered AI-related projects. NMF approximately factors the document-term matrix (A)
                                                      as the product of a document-topic matrix (W) and a topic-term matrix (H). NMF can also be thought of as an unsupervised soft clustering method, meaning that a term could appear in multiple topics.
                                                      "),
                                                    img(src = "nmf_image.png", style="display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "400px"),   #width = "400px", style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;"),
                                                    h5(strong("Latent Dirichlet Allocation")),
                                                    p("Latent Dirichlet Allocation (LDA) [4] is also a commonly used topic model. It is a probabilistic algorithm unlike NMF which is a linear algebraic method.  LDA is used in the filtering method of [2] that we explore in this project.  We use NMF rather than LDA for topic modeling on the filtered AI-related projects because in prior work we found that NMF performs better than LDA."), 
                                                    br(),
                                                    h4(strong("Topic Model Evaluation")),
                                                    
                                                    p("We use C", tags$sub("V"), "topic coherence [5] to evalute the performance of our topic models and compare across models.  (Throughout this dashboard we will refer to this measure only as “topic coherence”.)  Topic coherence is measured per topic; the overall model topic coherence score is the average of these scores per topic."), 
                                                    p(strong("For a given topic, topic coherence measures how frequently the most important words in the topic appear within close proximity of each other in the text, and includes some semantic information as well."), 
                                                            "Since we do not know the number of topics present in the text before running the topic model, we run each topic model using varying numbers of topics.  We choose the
                                                            number of topics that gives the highest coherence score as our optimal topic model.")
                                                    
                                          ),

                                          fluidRow( style = "margin: 6px;",
                                                   p("", style = "padding-top:10px;"),
                                                   h4(strong("Identifying Topic Trends")),
                                                          p("In order to identify topic trends in AI, we follow the method of [6] and use our topic model results on the filtered AI-projects.  Specifically, for each project we have a start date from which we extract the year. For each topic we calculate the mean topic weight over the set of projects with each given start year (i.e. the mean amount of the topic present across the AI-related project abstracts for a given start year).", strong("We then use linear regression to capture the trend of mean topic weight over time."), 
                                            "A positive correlation between the mean topic weight and time indicates that the topic prevalence in the corpus is increasing over time.  A negative correlation indicates that this topic is decreasing in prevalence over time.")
                                          ),
                                          
                                          fluidRow(style = "margin: 6px;",
                                            h4(strong("References")),
                                            p(tags$small("[1] OECD. (2019). Identifying government funding of AI-related R&D projects - An initial exploration based on US NIH and NSF project funding data.  Directorate for Science, Technology, and Innovation and Committee for Scientific and Technological Policy. Organisation for Economic Co-operation and Development (OECD). Paris, France.")),
                                            p(tags$small("[2] Eads, A., Schofield, A., Mahootian, F., Mimno, D., & Wilderom, R. (2021). Separating the wheat from the chaff: A topic and keyword-based procedure for identifying research-relevant text. Poetics, 86 (Article 101527).")),
                                            p(tags$small("[3] Lee, D., & Seung, H. (1999). Learning the parts of objects by non-negative matrix factorization. Nature, 401, 788-791.")),
                                            p(tags$small("[4] Blei, D., Ng, A., & Jordan, M. (2003). Latent Dirichlet allocation. Journal of Machine Learning Research, 3, 993-1022.")),
                                            p(tags$small("[5] Röder, M., Both, A., & Hinneburg, A. (2015). Exploring the space of topic coherence measures. WSDM '15: Proceedings of the Eighth ACM International Conference on Web Search and Data Mining (pp. 399-408). Association for Computing Machinery, New York, NY.")),
                                            p(tags$small("[6] Griffiths, T., & Steyvers, M. (2004). Finding scientific topics. Proceedings of the National Academy of Sciences, USA, 101(1), 5228-35.")),
                                            p(tags$small("[7] Reimers, N., & Gurevych, I. (2019). Sentence-BERT: Sentence EMBEDDINGS using Siamese Bert-Networks."))
                                            
                                            )

                                   )
                                   )
                          ),
                 # Tab3. Method 1. OECD, Cierra -----------------------------------------------------------
                 tabPanel("Filtering Method 1. Term Matching", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Term Matching"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4, #style = "border-right: 2px solid navy; padding: 10px 5px 5px 5px",
                                          h3(strong("Method")),
                                          p("To filter the corpus for AI, we used the method in [1] by the", a(href = "https://www.oecd.org/unitedstates/", "Organisation for Economic Co-operation and Development", target = "_blank"), "(OECD).
                                            OECD created a list of key terms which are broken into two groups: core terms and non-core terms."), 
                                          br(),
                                          h4(strong(" A document is considered AI-related if its abstract contains at least one core term or two non-core terms."), style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                          br(),
                                          h4(strong("Core Terms: unambiguously related to AI"), style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                          wellPanel(id="tPanel",style="overflow-y:scroll; max-height: 200px", # ; background: lightgray",
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
                                          br(),
                                          h4(strong("Non-core Terms: could be related to AI or another discipline"), style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                          wellPanel(id="tPanel",style="overflow-y:scroll; max-height: 200px", #; background: lightgray",
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
                                                            tags$li("word sense disambiguation"))),
                                          p(tags$small("[1] OECD. (2019). Identifying government funding of AI-related R&D projects - An initial exploration based on US NIH and NSF project funding data.  Directorate for Science, Technology, and Innovation and Committee for Scientific and Technological Policy. Organisation for Economic Co-operation and Development (OECD). Paris, France."))),
              
                                   
                                   column(8,
                                          h3(strong("Results")),
                                          h4(strong("In total 7,933 projects are classified as AI related with this method.")),
                                          tabsetPanel(id= "m1tabs",
                                            tabPanel(id= "m1.1","Funding Sources",
                                                    p(""),
                                                  img(src = "oecd_agency.png",  style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "450px"), #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;"), 
                                                  p(""),
                                                  img(src = "oecd_start_year.png",  style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "450px") #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;") 

                                            ),
                                            tabPanel(id= "m1.2","NMF Model Fitting",
                                                     p(""),
                                                     p("The highest Coherence Score was achieved with ", strong("Number of Topics = 20. "), "Based on the coherence model, 20 was the optimal number of topics."),
                                                     img(src = "oecd_coherence.png", style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "600px")
                                            ),
                                            tabPanel(id= "m1.3","Emerging Topics",
                                                     p(""),
                                                     p("Our interactive plots visualize the topic trends among identified AI-related abstracts."),
                                                     
                                                     tags$ul(
                                                       tags$li(strong("Mean Topic Weight"), " measures how much a topic is represented in our set of documents"), 
                                                       tags$li("The ", strong("n"), " value for each topic describes the number of documents with that topic weight above 0. In other words, n is the number of documents containing the specific topic.")
                                                     ),
                                                     
                                                     selectInput(
                                                       inputId = "k",
                                                       label = "Select Number of Topics:",
                                                       width = "50%",
                                                       choices = c('10 Topics', '20 Topics', '30 Topics'),
                                                       selected = '20 Topics'
                                                     ),
                                                     conditionalPanel("input.k == '10 Topics'",
                                                                      img(src = "oecd_10_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k == '20 Topics'",
                                                                      img(src = "oecd_20_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k == '30 Topics'",
                                                                      img(src = "oecd_30_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     br(),
                                                     fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                                       h4(strong("Takeaways:")),
                                                       tags$ul(
                                                        tags$li("Machine Learning (topic 2) and Robotics (topic 3) were among the topics with the most ",strong("increasing"), " mean topic weight."), 
                                                        tags$li("Machine Learning (topic 2) has the ", strong("highest n value")," indicating that a number of abstracts may mention or describe applications of machine learning."), 
                                                        tags$li("Some topics, like Document Retrieval (topic 13) were decreasing in mean topic weight, despite having a high n value."), 
                                                        tags$li("Computational Biology (topic 19) and Network Communication (topic 20) were among the topics with the most " ,strong("decreasing"), " mean topic weight.")
                                                        )
                                                     )
                                                     
                                            )
                                          )
                                   )
                                          )
                          ),


                # Method 2. Term Matching + LDA, Haleigh -----------------------------------------------------------
                tabPanel("Filtering Method 2. Term Matching + LDA", value = "socio",
                         fluidRow(style = "margin: 6px;",
                                  h1(strong("Term Matching and LDA"), align = "center"),
                                  p("", style = "padding-top:10px;"),
                                  column(4,
                                         h3(strong("Method")),
                                         p("We use the method of [2] by Eads et al. as our second approach to filtering our corpus for projects related to AI.",  strong("This method uses a combination of Latent Dirichlet Allocation (LDA), a topic model algorithm, and term matching in order to filter AI-related grant abstracts."), "This method is semiautomatic but requires a high-level of human intervention."),
                                         fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                                  h4(strong("Overview")),
                                                  tags$ol(
                                                    tags$li("Run an LDA topic model on the project abstracts. Determine which resulting topics are related to AI."), 
                                                    tags$li("Using the AI-related topics, create a “refined topic” that includes 200 terms that have the highest probabilities of appearing in the relevant topics rather than the non-relevant topics."), 
                                                    tags$li("Create a super keyword list by extending the list of terms in the “refined topic” to 1000 and then choosing only those terms that are very clearly about AI."),
                                                    tags$li("Determine if each project abstract is relevant to AI."),
                                                  )
                                         ),
                                         br(),
                                          fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",  
                                                  h4(strong("Filter")),
                                                  p(strong("A project abstract is relevant to AI if at least one of three conditions is true.")),
                                                  tags$ul(
                                                    tags$li("The proportion of the abstract made up of AI-related topics is at least 25%."),
                                                    tags$li("The abstract contains at least 25% of the terms in the “refined topic”."),
                                                    tags$li("The abstract contains at least one super keyword term.")
                                                    )
                                                  
                                         ),
                                         br(),
                                         h4(strong("Method Modifications")), #style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                         p("The signal for AI in our full corpus of project abstracts is not strong enough to be picked up by a topic model.  Thus before topic modeling, we filter our data to only include projects funded by the NSF, and within the subject area of Computer and Information Science and Engineering.  We do this to have a more focused corpus with a stronger AI presence within the data.  This process led to about 16,000 grant abstracts on which we found that an LDA topic model with 100 topics gave us several topics about AI.  We used the results of this model to create the “refined topic” and super keyword list."),
                                         p("We also modified the relevancy check for each abstract by only checking the amount of AI-related topics (4a.) in those abstracts included in the NSF, Computer and Information Science and Engineering corpus.  Testing this relevancy criterion on the full corpus remains as future work."),
                                         p(tags$small("[2] Eads, A., Schofield, A., Mahootian, F., Mimno, D., & Wilderom, R. (2021). Separating the wheat from the chaff: A topic and keyword-based procedure for identifying research-relevant text. Poetics, 86 (Article 101527)."))
                                        ),
                                  column(8,
                                         h3(strong("Results")),
                                         h4(strong("In total 12,694 projects are classified as AI related with this method.")),
                                         tabsetPanel(
                                           tabPanel("Funding Sources",
                                                    br(),
                                                    img(src = "eads_agency.png", style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "450px"),  #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;"),
                                                    br(),
                                                    img(src = "eads_start_year.png",  style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "450px") #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;")

                                           ),
                                           tabPanel("NMF Model Fitting",
                                                    p(""),
                                                    p(strong("Number of topics = 15 "), "achieved the highest coherence with topics. Based on the coherence model, 15 is the optimal number of topics."),
                                                    img(src = "nmf_fitting_eads.png",  style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "600px") #style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                           ),
                                           tabPanel("Emerging Topics",
                                                    p(""),
                                                    p("Our interactive plots visualize the topic trends among identified AI-related abstracts."),

                                                    tags$ul(
                                                      tags$li(strong("Mean Topic Weight"), " measures how much a topic is represented in our set of documents"), 
                                                      tags$li("The ", strong("n"), " value for each topic describes the number of documents with that topic weight above 0. In other words, n is the number of documents containing the specific topic.")
                                                    ),
                                                    selectInput(
                                                      inputId = "k2",
                                                      label = "Select Number of Topics:",
                                                      width = "50%",
                                                      choices = c('10 Topics', '15 Topics', '20 Topics', '30 Topics'),
                                                      selected = '15 Topics'
                                                    ),
                                                    conditionalPanel("input.k2 == '10 Topics'",
                                                                     img(src = "eads_10_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                    ),
                                                    conditionalPanel("input.k2 == '15 Topics'",
                                                                     img(src = "eads_15_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                    ),
                                                    conditionalPanel("input.k2 == '20 Topics'",
                                                                     img(src = "eads_20_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                    ),
                                                    conditionalPanel("input.k2 == '30 Topics'",
                                                                     img(src = "eads_30_topic_trends.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                    ),
                                                    br(),
                                                    fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                                      h4(strong("Takeaways:")),
                                                      tags$ul(
                                                        tags$li("Network Analysis (Topic 2)  and Robotics (Topic 4) are among the topics with a positive relationship between mean topic weight and the years in our data, meaning that they are emerging topics in our corpus."), 
                                                        tags$li("Speech Recognition (Topic 15) is decreasing the most over time."), 
                                                        tags$li("Despite decreasing mean topic weights, some topics still have a large presence in our AI corpus.  For example, see Topic 9 which has a decreasing trend over time, yet contains more abstracts than Topic 1, which has the steepest positive slope."), 
                                                        tags$li("Topic 7 has the most abstracts and lists the words 'statistical', 'algorithm', and 'theory', and has a fairly flat trend over time.  It is possible that many documents reference these terms in their methods.")
                                                      )
                                                    )

                                           )
                                         )
                                  )
                         )
                ),
                 #Tab5.  Method 3. Bert, Crystal -----------------------------------------------------------
                 tabPanel(id= "m3","Filtering Method 3. Embedding", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Sentence BERT Embedding"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4,
                                          h3(strong("Method")),
                                          
                                          h4(strong("Web Scraping on AI Wiki")),
                                          p("We scraped the" , a(href = "https://en.wikipedia.org/wiki/Artificial_intelligence", "Artificial Intelligence Wikipedia page", target = "_blank") , "and extracted the text.
                                            We believe that the AI Wikipedia page provides an accurate description of AI and a thorough list of AI subfields. "),
                                          br(),
                                          h4(strong("Sentence Embedding")),
                                          p("Sentence embeddings are a type of numeric representation for sentences that allows sentences with similar meanings to have similar embeddings. Bidirectional Encoder Representations from Transformers (BERT),
                                          is a transformer-based machine learning technique for natural language processing (NLP) pre-training developed by Google. Sentence-BERT (SBERT) [7] is a modification
                                          of the pretrained BERT model that uses network structures to derive semantically meaningful sentence embeddings."),

                                          p("We computed sentence embeddings using", a(href = "https://www.sbert.net/", "SBERT", target = "_blank"),  "; specifically, we used a pre-trained model",
                                            a(href = "https://www.sbert.net/docs/pretrained_models.html", "paraphrase-MiniLM-L6-v2", target = "_blank"),
                                            "to embed the AI Wikipedia page and Federal RePORTER project abstracts. This is a fast-running, high quality model. There are more accurate pre-trained models available, but they require more computing power."),
                                          fluidRow(
                                          column(6, h4(strong("AI Wikipedia Page Embedding"), style = "border: 4px solid navy; padding: 5px 5px 5px 5px")),
                                          column(5, h4(strong("Abstract Embedding"), style = "border: 4px solid navy; padding: 5px 5px 5px 5px")), 
                                          ),
                                        
                                          br(),
                                          h4(strong("Cosine Similarity Score")),
                                          p("Cosine similarity measures the similarity between two non-zero vectors (i.e. sentence embeddings). Two sentence embeddings that are the same would have a cosine similarity score of 1, while two independent/perpendicular sentence embeddings
                                            would have a score of 0. A higher cosine similarity score indicates a higher degree of similarity between the two sentences."),
                                          p("We compared the sentence embeddings of the AI Wikipedia page to those of Federal RePORTER project abstracts using cosine similarity. For each sentence in an abstract, we identified the top ten most similar sentences from the AI Wikipedia page and then averaged these ten cosine similarity scores to find the similarity score for the sentence."),
                                          

                                          fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                          h5(strong("Example 1. Sentence from a Federal RePORTER abstract")),
                                          p("The game of Go is an ancient board game which is considered by-far the most complex
                                            board game for computer software or artificial intelligence (AI) to solve."), #style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                          
                                          p("Sentence cosine-similarity score: 0.65")
                                          ),
                                          br(),
                                          fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                          h5(strong("Example 2. Sentence from a Federal RePORTER abstract")),
                                          p("The multiprotein complex y-secretase proteolytically cleaves the intramembrance of amyloid precursoprotein (APP), which
                                            in turn forms the plaques found in Alzheimer's disease (AD) patients"),   #style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),

                                          p("Sentence cosine-similarity score: 0.31")
                                          ),
                                          br(),
                                          
                                          p("To find the", strong("abstract similarity score"), "we averaged the sentence similarity scores for the sentences in the abstract.  The abstract similarity score reflects how similar the abstract is to the AI Wikipedia page." ),
                                          
                                          br(),
                                          h4(strong("Choosing a Cutoff Score")),
                                          p("We classify an abstract with a ", strong("abstract similarity score"), " that is 2.5 standard deviations above the mean as AI-related."),
         
                                          p(tags$small("[7] Reimers, N., & Gurevych, I. (2019). Sentence-BERT: Sentence EMBEDDINGS using Siamese Bert-Networks.")),
                                          br(),
                                          br(),
                                          br(),
                                          br()
                                          ),




                                   column(8,
                                          h3(strong("Results")),

                                          h4(strong("In total 7,658 projects are classified as AI related with this method.")),

                                          tabsetPanel(
                                            tabPanel("Funding Sources",
                                                      br(),
                                                      img(src = "bert_agency.png",  style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "450px"), #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;"),
                                                      br(),
                                                      img(src = "bert_start_year.png",  style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "450px") #style = "display:  center; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;")


                                            ),
                                            tabPanel("NMF Model Fitting",
                                                     p(""),
                                                     p(strong("Number of topics = 10")," achieved the highest coherence with topics. Based on the coherence model, 10 is the optimal number of topics."),
                                                     img(src = "nmf_fitting_bert.png",  style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;", width = "600px") #style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                            ),
                                            tabPanel("Emerging Topics",
                                                     p(""),
                                                     p("Our interactive plots visualize the topic trends among identified AI-related abstracts."),

                                                     tags$ul(
                                                       tags$li(strong("Mean Topic Weight"), " measures how much a topic is represented in our set of documents"), 
                                                       tags$li("The ", strong("n"), " value for each topic describes the number of documents with that topic weight above 0. In other words, n is the number of documents containing the specific topic.")
                                                     ),
                                                     selectInput(
                                                       inputId = "k3",
                                                       label = "Select Number of Topics:",
                                                       width = "50%",
                                                       choices = c('10 Topics', '20 Topics', '30 Topics'),
                                                       selected = '20 Topics'
                                                       ),
                                                     conditionalPanel("input.k3 == '10 Topics'",
                                                       img(src = "bert_trends_10topics.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k3 == '20 Topics'",
                                                       img(src = "bert_trends_20topics.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     conditionalPanel("input.k3 == '30 Topics'",
                                                                      img(src = "bert_trends_30topics.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                     ),
                                                     br(),
                                                     fluidRow(style = "border: 2px solid navy; padding: 5px 5px 5px 5px",
                                                      h4(strong("Takeaways:")),
                                                      tags$ul(
                                                       tags$li("Predictive medicine (topic 2) and image recognition (topic 5) were among the topics with the most increasing mean topic weight."), 
                                                       tags$li("Innovative social science (topic 8) and user interaction (topic 16) are the topics had the highest occurrence in the documents, indicating that many AI-related 
                                                               abstracts may be about the applications of AI."), 
                                                       tags$li("Neural networks (topic 20) has the most decreasing mean topic weight, but it occurred in many documents, indicating it's widely studied.")
                                                      )
                                                     )
                                                     

                                            )
                                          )
                                    )
                                   )
                          ),

              # Discussion tab -----------------------------------------------  
               tabPanel("Discussion", value = "socio",
                        fluidRow(style = "margin: 6px;",
                                 h1(strong("Discussion"), align = "center"),
                                 p("", style = "padding-top:10px;"),
                            
                                 column(8,
                                        h3(strong("Filtering Method Comparison")),
                                        tabsetPanel(
                                                    tabPanel("Funding Sources",
                                                             br(),
                                                             br(),
                                                             abstracts_gather%>%
                                                               group_by(method)%>%
                                                               rename("Filtering Method" ="method")%>%
                                                               summarize(N=n(), "Percent (%)" = round(N/690814*100, digits = 2))%>%
                                                               gt()%>%
                                                               tab_header(
                                                                 title = "Comparison of the Number of Projects that are Classified as AI"
                                                                 #subtitle = "Project Start Year From 2008 to 2018"),
                                                               ),

                                                             br(),
                                                             br(),
                                                             br(),

                                                             img(src = "all_agency.png", width = "550px", style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;"),  #"display:  center; margin-left: 50px ; margin-right: auto; border: 1px solid #C0C0C0;"),
                                                             br(), br(),

                                                             img(src = "all_start_year.png", width = "550px", style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;")  #"display:  center; margin-left: 50px; margin-right: auto; border: 1px solid #C0C0C0;")


                                                    ),
                                                    tabPanel("NMF Model Fitting",
                                                             br(),
                                                             h4(strong("The term matching filtering approach by OECD achieved the highest topic coherence."), style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                                             br(),  
                                                             img(src = "nmf_coherence_all.png", width = "700px", style = "display:  block; margin-left: auto; margin-right: auto; border: 1px solid #C0C0C0;")  #style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "800px")
                                                    )
                                                 )
                                        ),
                                 column(4,
                                        h3(strong("Future Work")),
                                        h4(strong("Evaluate Filtering Method Performance")),
                                        p("To evaluate the quality of these three filtering methods,
                                                  we plan to measure precision and recall."), 
                                          p(strong("Precision:"), "the percentage of documents returned as AI-related by a filtering method that are in fact AI-related.  This is a measure of true positives.", style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),
                                          p(strong("Recall:"), "the percentage of AI-related documents that a filtering method returned as AI-related.", style = "border: 2px solid navy; padding: 5px 5px 5px 5px"),    
                               
                                        p("This requires us to select a random sample of project abstracts and manually label them as AI-related or not AI-related. Then we would test each filtering method on the labeled subset."),
                                        br(),
                                        h4(strong("Further Filtering Method Comparison")),
                                        p("We plan to continue the filtering method comparison by computing the overlap between methods.  In other words, we will calculate which projects were returned as AI-related by all three methods, two methods, or a single method."),
                                        br(),
                                        h4(strong("Investigation of Other Themes")),
                                        p("We would like to extend this work to themes other than AI, such as bioeconomy.")
                                 )
                                )
                      ),

                 # contact -----------------------------------------------------------
                 tabPanel(id= "contact","Contact", value = "contact",
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
                                          p(strong('Crystal Zang'), "(University of Pittsburgh Graduate School of Public Health, Biostatistics);",
                                            strong('Cierra Oliveira'), "(Clemson University);",
                                            strong('Haleigh Tomlin'), "(Washington and Lee University)."),
                                          p("", style = "padding-top:10px;")
                                   ),
                                   column(6, align = "center",
                                          h4(strong("UVA SDAD Team Members")),
                                          img(src = "team-Kathryn.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Eric.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Joel.png", style = "display: inline; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-Stephanie.png", style = "display: inline; border: 1px solid #C0C0C0;", width = "150px"),
                                          p(a(href = "https://biocomplexity.virginia.edu/person/kathryn-linehan", 'Kathryn Linehan', target = '_blank'), "(Project Lead, Research Scientist);",
                                            a(href = "https://biocomplexity.virginia.edu/person/eric-oh", 'Eric Oh', target = '_blank'), "(Research Assistant Professor);",
                                            a(href = "https://biocomplexity.virginia.edu/person/joel-thurston", 'Joel Thurston', target = '_blank'), "(Senior Scientist).",
                                          a(href = "https://biocomplexity.virginia.edu/person/stephanie-shipp", 'Stephanie Shipp', target = '_blank'), "(Deputy Division Director, Research Professor);"),
                                          p("", style = "padding-top:10px;")
                                    )
                                    ),
                          fluidRow(style = "margin-left: 300px; margin-right: 300px;",
                                   h4(strong("Project Stakeholders")),
                                   p(strong('John Jankowski'), "(NCSES, Director of R&D Statistics Program);",
                                     strong('Audrey Kindlon'), "(NCSES, Survey Statistician)."),
                                   p("", style = "padding-top:10px;"),
                                   h4(strong("Acknowledgments")),
                                   p("We would like to thank Sallie Keller for helpful feedback on this project.")
                          )
                        )
)



# server -----------------------------------------------------------
server <- function(input, output, session) {

}

shinyApp(ui = ui, server = server)
