library(shiny)
library(tidyverse)
library(ggthemes)
library(RColorBrewer)
library(sjmisc)
library(shinythemes)
library(DT)
library(data.table)
library(rsconnect)
library(shinycssloaders)
library(readxl)
library(readr)
library(stringr)
library(shinyjs)
library(leaflet)

prettyblue <- "#232D4B"
navBarBlue <- '#427EDC'
options(spinner.color = prettyblue, spinner.color.background = '#ffffff', spinner.size = 3, spinner.type = 7)

colors <- c("#232d4b","#2c4f6b","#0e879c","#60999a","#d1e0bf","#d9e12b","#e6ce3a","#e6a01d","#e57200","#fdfdfd")

# data -----------------------------------------------------------

# user -------------------------------------------------------------
ui <- navbarPage(title = "I'm a title!",
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
                                   h1(strong("Addressing Barriers to Health in Patrick County, Virginia"),
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
                 
                 # socio -----------------------------------------------------------
                 tabPanel("Sociodemographics", value = "socio",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Patrick County Residents' Sociodemographic Characteristics"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4,
                                          h4(strong("Who does Patrick County Serve?")),
                                          p("We examined Patrick County population sociodemographic and socioeconomic characteristics to better understand the 
                                            residents that the county serves."),
                                          p("We retrieved American Community Survey (ACS) data to calculate this information at census block group and census 
                                            tract levels. ACS is an ongoing yearly survey conducted by the U.S Census Bureau that samples households to compile 1-year and 5-year datasets. We used 
                                            the most recently available 5-year estimates from 2014/18 to compute percent Patrick County residents in a given block group or tract by age, race, ethnicity, 
                                            employment, health insurance coverage, and other relevant characteristics."),
                                          p("Our interactive plots visualize census block-group level sociodemographic characteristics of Patrick County residents.")),
                                   column(8,
                                          h4(strong("Map of Resident Socioeconomic Characteristics by Census Tract or Block Group")),
                                          selectInput("sociodrop", "Select Variable:", width = "100%", choices = c(
                                            "Percent Population Age 65 and Older" = "age65",
                                            "Percent Population Age 18 and Younger" = "under18",
                                            "Percent Population Black" = "black",
                                            "Percent Population Hispanic" = "hispanic",
                                            "Percent Population Without Bachelor's Degree" = "noba",
                                            "Percent Population In Labor Force Unemployed" = "unempl",
                                            "Percent Population Without Health Insurance" = "nohealthins2",
                                            "Percent Population With Private Health Insurance" = "privateins",
                                            "Percent Population With Public Health Insurance" = "publicins",
                                            "Percent Population in Poverty" = "inpov",
                                            "Percent Population Receiving SNAP Benefits or Public Assistance" = "snap",
                                            "Total Population by Census Block Group" = "totalpop_bgrp",
                                            "Total Population by Census Tract" = "totalpop_trct")
                                          ),
                                          withSpinner(leafletOutput("socioplot")),
                                          p(tags$small("Data Source: American Community Survey 2014/18 5-Year Estimates."))
                                   ))
                                   ),
                 
                 # older -----------------------------------------------------------
                 tabPanel("Older Adults", value = "older",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Older Adults in Patrick County"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4,
                                          h4(strong("Who are the Patrick County Older Adults?")),
                                          p("The US population is aging, and in Patrick County, over 30% of residents are older adults aged 65 years and over. This represents more than 5,000
                                            individuals with varying health conditions that may benefit from locally accessible health care and social services resources. However, access to 
                                            health care resources is limited in rural areas, particularly for older adults in need of assistance with activities of daily life."),
                                          p("To help Patrick County better understand their older adult population, we used American Community Survey (ACS) data and obtained census tract 
                                            level information for the age group. ACS is an ongoing yearly survey conducted by the U.S Census Bureau that samples households to compile 
                                            1-year and 5-year estimates of population sociodemographic and socioeconomic characteristics. We used the most recently available 5-year data
                                            from 2014/18 to calculate the percentage of the Patrick County older adults with different types of disability, as well as provided information 
                                            on their living arrangements and socioeconomic status. We provided all information at census tract level and by gender."),
                                          p("These insights on the health and socioeconomic status of older adults in Patrick County can assist the county in identifying areas of high need 
                                            for health care resources.")
                                          ),
                                   column(8,
                                          h4(strong("Map of Older Adult Characteristics by Census Tract")),
                                          tabsetPanel(
                                            tabPanel("Older Adult Characteristics",
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
                                                     column(6,
                                                            selectInput("oldspecdrop", "2. Select Group:", width = "100%", choices = c(
                                                              "Total",
                                                              "Female" = "_f",
                                                              "Male" = "_m")
                                                            )),
                                                     withSpinner(leafletOutput("oldplot")),
                                                     p(tags$small("Data Source: American Community Survey 2014/18 5-Year Estimates."))
                                            ),
                                            tabPanel("Older Adult Household Characteristics",
                                                     p(""),
                                                     selectInput("hhdrop", "Select Variable:", width = "100%", choices = c(
                                                       "Percent Married Couple Households with one or more 60+ Member" = "hhsixty_married",
                                                       "Percent Households with one or more 60+ Members" = "hhsixty_total",
                                                       "Percent Single (no partner present) Households with one or more 60+ Member" = "hhsixty_nonfam",
                                                       "Percent Households with one or more Male 60+ Members" = "hhsixty_mhh",
                                                       "Households with one or more Female 60+ Members" = "hhsixty_fhh")),
                                                     withSpinner(leafletOutput("householdplot")),
                                                     p(tags$small("Data Source: American Community Survey 2014/18 5-Year Estimates."))
                                            )
                                          )
                                   )
                                          )
                 ),
                 
                 # wifi-----------------------------------------------------------
                 tabPanel("Connectivity", value = "connectivity",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Digital Connectivity in Patrick County"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(6,
                                          h4(strong("Computing Device Ownership and Internet Access Type")),
                                          p("Internet connection and computing devices are key for access to health information and participation in online health-related services like 
                                            telemedicine. Rural areas frequently lack broadband access, experience low internet speeds, and have fewer internet providers available 
                                            than urban areas. It is crucial to consider digital connectivity in improving health care access. We examined digital connectivity in Patrick County in two ways to 
                                            provide the county with insights on where increasing connectivity would facilitate communicating health information and improve online health service access."),
                                          p("We first examined access to computing devices and internet connection types in Patrick County. We used American Community Survey (ACS) data to 
                                            obtain this information at census block group level. ACS is an ongoing yearly survey conducted by the U.S Census Bureau that samples households 
                                            to compile 1-year and 5-year estimates of population sociodemographic and socioeconomic characteristics. We used the most 
                                            recently available 5-year data from 2014/18 to calculate the percentage of the Patrick County residents with access to devices
                                            and internet by census block group."),
                                          br(),
                                          selectInput("devicedrop", "Select Variable:", width = "100%", choices = c(
                                            "Percent Households with No Computer" = "nocomputer",
                                            "Percent Households with Laptop" = "laptop",
                                            "Percent Households with Smartphone" = "smartphone",
                                            "Percent Households with Tablet" = "tablet",
                                            "Percent Households without Internet" = "nointernet",
                                            "Percent Households with Satellite Internet" = "satellite",
                                            "Percent Households with Cellular Internet" = "cellular",
                                            "Percent Households with Broadband Internet" = "broadband")
                                          ),
                                          p(strong("Map of Access by Census Block Group")),
                                          withSpinner(leafletOutput("deviceplot")),
                                          p(tags$small("Data Source: American Community Survey 2014/18 5-Year Estimates."))),
                                   column(6,
                                          h4(strong("Free WiFi Hotspot Access")),
                                          p("To understand internet access at a more granular level, we examined access to free wi-fi hotspots in the county."),
                                          p("We obtained wifi hotspot locations using the Virginia Tech and CommonwealthConnect hotspot map. CommonwealthConnect identifies where people can connect to 
                                            the internet for free, decreasing constraints placed on families that do not have internet access at home. We retrieved free internet locations in Patrick 
                                            County from the data. We extracted locations of Patrick County residential properties from 2019 CoreLogic, a proprietary dataset for US real estate that 
                                            includes information on building characteristics. Finally, we used the TravelTime Application Programming Interface (API) to calculate 10- and 15-minute 
                                            car travel time isochrones—areas of equal travel time given a departure time and mode of transportation—from wifi hotspots. TravelTime API aggregates data 
                                            from Open Street Maps, transport timetables and speed profiles to generate isochrones. Isochrones allowed us to identify wifi gaps, or clusters of 
                                            residential properties that cannot reach a free internet location within a selected travel time range."),
                                          p("This information equips extension agents with knowledge on how best to reach their constituents, as well as identifies internet gaps that suggest where 
                                            new wi-fi hotspots could be optimally placed to provide internet access to more residents."),
                                          br(),
                                          tabsetPanel(
                                            tabPanel("Explore Hotspot Coverage",
                                                     p(""),
                                                     selectInput("wifidrop", "Select Free Wifi Location:", width = "100%", choices = c(
                                                       "Meadows of Dan Elementary School",
                                                       "Woolwine Elementary School",
                                                       "Patrick Springs Primary School",
                                                       "Blue Ridge Elementary School",
                                                       "Patrick County High School",
                                                       "Stuart Elementary School",
                                                       "Patrick County Branch Library",
                                                       "Hardin Reynolds Memorial School",
                                                       "Stuart Baptist Church",                        
                                                       "Patrick Henry Community College Stuart Campus")),
                                                     p(strong("Percent Residential Properties Covered")),
                                                     withSpinner(tableOutput("wifitable")),
                                                     p(strong("Map of Coverage")),
                                                     withSpinner(leafletOutput("wifiplot")),
                                                     p(tags$small("Data Sources: CommonwealthConnect, 2020; CoreLogic, 2019; TravelTime API."))
                                            ),
                                            tabPanel("Explore 'Deserts'",
                                                     p(""),
                                                     p(strong("Percent Residential Properties Covered")),
                                                     withSpinner(tableOutput("allwifitable")),
                                                     p(strong("Map of Free Wi-Fi Deserts")),
                                                     withSpinner(leafletOutput("allwifi")),
                                                     p(tags$small("Data Sources: CommonwealthConnect, 2020; CoreLogic, 2019; TravelTime API."))
                                            )
                                          )
                                          )
                                   )
                          ),
                 
                 # ems -----------------------------------------------------------
                 tabPanel("Health Care Access", value = "ems",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Health Care Access in Patrick County"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(4,
                                          h4(strong("Accessing Emergency Medical Service Stations")),
                                          p("Access to health care services in rural areas is limited by a lack of transportation and a shortage of healthcare professionals. Compared to urban 
                                            counterparts, rural residents must travel farther to obtain both preventive and specialty care. Patrick County’s general practitioner, dentist, and mental health
                                            provider-to-patient ratios fall below state averages, and the county recently experienced the closure of its only hospital. Its residents often rely on emergency
                                            medical services (EMS) stations to obtain care and transportation to other health care facilities."),
                                          p("To better understand health service access limitations in the county, we examined residents’ access to EMS stations. We obtained EMS locations using Homeland 
                                            Infrastructure Foundation-Level Data (HIFLD) collected by the Department of Homeland Security. HIFLD is a public source dataset with information on a range of 
                                            facilities; we used the data to retrieve EMS station latitude and longitude. We extracted locations of Patrick County residential 
                                            properties from 2019 CoreLogic, a proprietary dataset for US real estate that includes information on building characteristics. Finally, we used the TravelTime
                                            Application Programming Interface (API) to calculate 8-, 10-, and 12- minute drive time isochrones—areas of equal travel time given a departure time and 
                                            mode of transportation—from EMS stations. TravelTime API aggregates data from Open Street Maps, transport timetables and speed profiles to generate isochrones. 
                                            Isochrones allowed us to identify EMS coverage gaps, or clusters of residential properties that cannot be reached from an EMS location within a selected travel 
                                            time range. We selected 8-, 10-, and 12-minute thresholds as EMS are expected to reach distressed individuals within 8 minutes. However, this threshold is 
                                            frequently exceeded by 20% to 40% in rural areas.")
                                          ),
                                   column(8,
                                          tabsetPanel(
                                            tabPanel("Explore Coverage",
                                                     p(""),
                                                     selectInput("emsdrop", "Select EMS Location:", width = "100%", choices = c(
                                                       "Stuart Volunteer Fire Department" = "STUART VOLUNTEER FIRE DEPARTMENT",
                                                       "Moorefield Store Volunteer Fire Department" = "MOOREFIELD STORE VOLUNTEER FIRE DEPARTMENT",                                                         
                                                       "Blue Ridge Volunteer Rescue Squad" = "BLUE RIDGE VOLUNTEER RESCUE SQUAD",                                                                   
                                                       "Vesta Rescue Squad" = "VESTA RESCUE SQUAD",                                                                                           
                                                       "Ararat Rescue Squad" = "ARARAT RESCUE SQUAD",                                                                                          
                                                       "Five Forks Volunteer Fire and Rescue Station 1" = "COLLINSTOWN - CLAUDVILLE - DRYPOND - FIVE FORKS VOLUNTEER FIRE AND RESCUE DEPARTMENT STATION 1 - HEADQUARTERS",
                                                       "Five Forks Volunteer Fire and Rescue Station 2"= "COLLINSTOWN - CLAUDVILLE - DRYPOND - FIVE FORKS VOLUNTEER FIRE AND RESCUE DEPARTMENT STATION 2",
                                                       "Jeb Stuart Rescue Squad" = "JEB STUART RESCUE SQUAD",                                                                                      
                                                       "Smith River Rescue Squad" = "SMITH RIVER RESCUE SQUAD"                                                                                     
                                                     )),
                                                     p(strong("Percent Residents Covered")),
                                                     withSpinner(tableOutput("emstable")),
                                                     p(strong("Map of Coverage")),
                                                     withSpinner(leafletOutput("emsplot")),
                                                     p(tags$small("Data Sources: Homeland Infrastructure Foundation-Level Data, 2010; CoreLogic, 2019; TravelTime API."))
                                            ),
                                            tabPanel("Explore 'Deserts'",
                                                     p(""),
                                                     p(strong("Percent Residents Covered")),
                                                     withSpinner(tableOutput("allemstable")),
                                                     p(strong("Map of Coverage Deserts")),
                                                     withSpinner(leafletOutput("allems")),
                                                     p(tags$small("Data Sources: Homeland Infrastructure Foundation-Level Data, 2010; CoreLogic, 2019; TravelTime API.")))
                                          )
                                   )
                                          )
                                   ),
                 
                 # food -----------------------------------------------------------
                 tabPanel("Food Access", value =  "food",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Food Access in Patrick County"), align = "center"),
                                   p("", style = "padding-top:10px;"),
                                   column(5,
                                          h4(strong("Food Access in Rural Areas")),
                                          p("Social determinants of health shape food access, a key factor in negative health outcomes. Rural area residents frequently face difficulties in accessing 
                                            healthy and nutritious food, and experience high rates of chronic illnesses like heart disease and diabetes, resulting in higher mortality rates and lower
                                            life expectancy compared to urban areas. Facilitating  access to nutritious and high-quality foods can lead to decreases in chronic disease prevalence. 
                                            Many Patrick County residents suffer from conditions like diabetes and obesity, and providing healthy food may support disease prevention."),
                                          p("We analyzed multiple data sources to give Patrick County actionable information on their residents’ food access that can inform county efforts ensuring equitable food access for all."),
                                          p("First, we examined", strong("food access at multiple distance thresholds by age and socioeconomic status."), "We used the 2017 United States Department of 
                                            Agriculture (USDA) Food Access Research Atlas, a central database created by the Economic Research Service that provides access indicators for different social groups.
                                            We created census tract-level maps that identify Patrick County areas where residents may have difficulty accessing nutritious foods, and highlight geographies 
                                            where this is the case for particularly vulnerable groups like low-income individuals and older adults."),
                                          p("Second, to better understand how residents must travel to obtain food, we constructed isochrones—shapes covering places within reach in the 
                                            same time frame given a start location and a mode of transportation—from Patrick County", strong("residential properties to locations of grocery stores 
                                                                                                                                             and farmers’ markets."), "We used Google Maps to identify these locations' latitude and longitude. We extracted locations of 
                                            Patrick County residential properties from 2019 CoreLogic, a proprietary dataset for US real estate with information on building characteristics. 
                                            Finally, we used the TravelTime Application Programming Interface (API) to calculate 10- and 15-minute car travel times from grocery locations. TravelTime 
                                            API aggregates data from Open Street Maps, transport timetables and speed profiles to generate isochrones. This allowed us to identify food deserts, or clusters 
                                            of properties that cannot reach a location with healthy food within a selected travel time range. These areas in the county could benefit from programs 
                                            facilitating access to produce."),
                                          p("Finally, Patrick County offers", strong("access to free food"), "at multiple locations. For community members that struggle with food security, these locations can 
                                            offer temporary assistance. We used GoogleMaps to locate food banks, food pantries, and community meal sites, geocoded their addresses, and mapped
                                            these resources along with notes on their target audiences.")
                                          ),
                                   column(7,
                                          tabsetPanel(
                                            tabPanel("Food Access",
                                                     p(""),
                                                     selectInput("usdadrop", "Select Variable:", width = "100%", choices = c(
                                                       "Percent Population with Low Food Access at 1 Mile" = "lapop1share",  
                                                       "Percent Population with Low Food Access at 10 Miles" = "lapop10share",
                                                       "Percent Children with Low Food Access at 1 Mile" = "lakids1share",
                                                       "Percent Children with Low Food Access at 10 Miles" = "lakids10share",
                                                       "Percent Low Income Population with Low Food Access at 1 Mile" = "lalowi1share",
                                                       "Percent Low Income Population with Low Food Access at 10 Miles" = "lalowi10share",
                                                       "Percent Older Adults with Low Food Access at 1 Mile" = "laseniors1share",
                                                       "Percent Older Adults with Low Food Access at 10 Miles" = "laseniors10share")
                                                     ),
                                                     p(strong("Map of Access at Census Tract Level")),
                                                     withSpinner(leafletOutput("usdaplot")),
                                                     p(tags$small("Data Source: USDA Food Access Research Atlas, 2017"))
                                            ),
                                            tabPanel("Grocery and Farmers' Market Coverage",
                                                     p(""),
                                                     selectInput("grocdrop", "Select Location:", width = "100%", choices = c(
                                                       "Mountain Meadow Farm and Craft Market",
                                                       "Lowes Foods of Stuart",
                                                       "Patrick County Local Farmers Market",
                                                       "Stuart Farmers Market",                
                                                       "W & W Produce",
                                                       "Walmart Supercenter",
                                                       "Poor Farmers Farm")),
                                                     p(strong("Percent Households Covered")),
                                                     withSpinner(tableOutput("groctable")),
                                                     p(strong("Map of Coverage")),
                                                     withSpinner(leafletOutput("grocplot")),
                                                     p(tags$small("Data Source: Google Maps; TravelTime API; CoreLogic, 2019."))
                                            ),
                                            tabPanel("Food Deserts",
                                                     p(""),
                                                     p(strong("Percent Households Covered")),
                                                     withSpinner(tableOutput("allgrctable")),
                                                     p(strong("Map of Food Deserts")),
                                                     withSpinner(leafletOutput("allgroc")),
                                                     p(tags$small("Data Source: Google Maps; TravelTime API; CoreLogic, 2019."))
                                            ),
                                            tabPanel("Food Security Resources",
                                                     p(""),
                                                     p(strong("Map of Food Security Resources")),
                                                     withSpinner(leafletOutput("othermap")),
                                                     p(tags$small("Data Source: Google Maps."))
                                            )
                                          )
                                   )
                                          )
                                          ),
                 # data -----------------------------------------------------------
                 tabPanel("Data and Measures", value = "data",
                          fluidRow(style = "margin: 6px;",
                                   h1(strong("Data and Measures"), align = "center"),
                                   br()
                          ),
                          tabsetPanel(
                            tabPanel("Data Sources",
                                     h3("", align = "center"),
                                     br(""),
                                     column(4, 
                                            img(src = "data-hifld.png", style = "display: inline; float: left;", width = "100px"),
                                            p(strong("Homeland Infrastructure Foundation-Level Data."), "Homeland Infrastructure Foundation-Level Data (HIFLD) is a collection of public 
                                              source datasets at property level provided by the Department of Homeland Security. Since 2002, this HIFLD has provided quarterly 
                                              updated layers on topics from education to energy, including on health care facilities. We used HIFLD emergency medical services 
                                              station data at the latitude and longitude geographic level in our analyses."),
                                            br(""),
                                            img(src = "data-gmaps.png", style = "display: inline; float: left;", width = "130px"),
                                            p(strong("Google Maps."), "Google Maps is a comprehensive web mapping service created by Google. Its goal is to provide an interactive map
                                              of all the geographical contents of the world. This resource has a variety of uses, ranging from examining all service locations within 
                                              a city to finding the quickest route between locations. It provides data at latitude and longitude level. We used Google Maps to locate 
                                              all supermarkets, convenience stores, and farmers’ markets in Patrick County, and subsequently employed the information in calculating 
                                              grocery access and coverage isochrones.")
                                            ),
                                     column(4,
                                            img(src = "data-acs.png", style = "display: inline; float: left;", width = "200px"),
                                            p(strong("American Community Survey."), "The American Community Survey (ACS) is an ongoing yearly survey conducted by the U.S Census 
                                              Bureau. ACS samples households to compile 1-year and 5-year datasets providing information on population sociodemographic and 
                                              socioeconomic characteristics including employment, disability, and health insurance coverage. We used AC 2014/18 5-year 
                                              estimates to obtain census tract and census block group-level to explore Patrick County resident characteristics."),
                                            br(""),
                                            img(src = "data-connect.png", style = "display: inline; float: left;", width = "150px"),
                                            p(strong("CommonwealthConnect."), "The Virginia Tech CommonwealthConnect Wi-Fi Hotspot Map is an interactive map of free, publicly 
                                              available wi-fi hotspots in Virginia. Its goal is to provide an easily accessible map of areas where individuals can connect to the 
                                              internet for free, decreasing the constraints placed on families that do not have internet access at home. We used the 2020 wi-fi 
                                              hotspot map data to retrieve hotspot locations in Patrick County and subsequently employed the information in calculating hotspot 
                                              coverage isochrones."),
                                            br(""),
                                            img(src = "data-corelogic.png", style = "display: inline; float: left;", width = "120px"),
                                            p(strong("CoreLogic."), "CoreLogic is a supplier of proprietary US real estate and specialized business data at the property level. 
                                              This company provides data spanning over 50 years at the latitude and longitude level. Information available in the dataset includes 
                                              property characteristics, mortgage, foreclosures and performance. We used 2019 CoreLogic data to obtain the locations of all residential
                                              properties in Patrick County.")
                                            ),
                                     column(4,
                                            img(src = "data-traveltime.png", style = "display: inline; float: left;", width = "140px"),
                                            p(strong("TravelTime."), "TravelTime Application Programming Interface (API) aggregates data from OpenStreetMap, transport timetables and
                                              speed profiles to generate isochrones. An isochrone is a shape covering all locations that can be reached within the same timeframe 
                                              given a start location, departure time, and a mode of transportation. We used the TravelTime API to produce isochrones of 10- and 
                                              15-minute drive time interval from supermarkets, farmers' markets, and free wi-fi hotspots, and of 8-, 10-, and 12-minute drive 
                                              time intervals from all emergency medical service stations in Patrick County."),
                                            br(""),
                                            img(src = "data-ers.png", style = "display: inline; float: left;", width = "120px"),
                                            p(strong("Food Access Research Atlas."), "The United State Department of Agriculture Food Access Research Atlas is a data resource 
                                              created by the Economic Research Service that provides information on food access indicators at census tract level. The data allows 
                                              individuals to understand food access in communities based on factors like age and socioeconomic status. We used the 2017 Food Access
                                              Research Atlas to examine Patrick County residents’ food access at multiple distance thresholds and by resident characteristics.")
                                            )
                                            ),
                            tabPanel("Measures",  
                                     h3(strong(""), align = "center"),
                                     selectInput("topic", "Select Topic:", width = "100%", choices = c(
                                       "All Measures",
                                       "Sociodemographic Measures",
                                       "Older Adult Population Measures",
                                       "Connectivity Measures",
                                       "Food Access Measures",
                                       "Health Care Access Measures")
                                     ),
                                     withSpinner(DTOutput("datatable"))
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
                                          img(src = "team-morgan.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-tasfia.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-isabel.png", style = "display: inline; border: 1px solid #C0C0C0;", width = "150px"),
                                          p(a(href = 'https://www.linkedin.com/in/morgan-stockham/', 'Morgan Stockham', target = '_blank'), "(Claremont Graduate University, Applied Microeconomics);",
                                            a(href = 'https://www.linkedin.com/in/tasfia-chowdhury-89005a1b2/', 'Tasfia Chowdhury', target = '_blank'), "(Indiana University Bloomington, Political Science);",
                                            a(href = 'https://www.linkedin.com/in/igomez-3099/', 'Isabel Gomez', target = '_blank'), "(Smith College, Statistical and Data Science)."),
                                          p("", style = "padding-top:10px;")
                                   ),
                                   column(6, align = "center",
                                          h4(strong("UVA SDAD Team Members")),
                                          img(src = "team-teja.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-brandon.png", style = "display: inline; margin-right: 5px; border: 1px solid #C0C0C0;", width = "150px"),
                                          img(src = "team-sallie.jpg", style = "display: inline; border: 1px solid #C0C0C0;", width = "150px"),
                                          p(a(href = "https://www.linkedin.com/in/tejapristavec/", 'Teja Pristavec', target = '_blank'), "(Project Lead, Research Assistant Professor);",
                                            a(href = "https://biocomplexity.virginia.edu/brandon-kramer", 'Brandon Kramer', target = '_blank'), "(Postdoctoral Research Associate);",
                                            a(href = 'https://biocomplexity.virginia.edu/sallie-keller', 'Sallie Keller', target = '_blank'), "(Division Director and Distinguished Professor)."),
                                          p("", style = "padding-top:10px;")
                                   )
                          ),
                          fluidRow(style = "margin-left: 300px; margin-right: 300px;",
                                   h4(strong("Project Stakeholders")),
                                   p(a(href = 'https://www.linkedin.com/in/nancy-bell-aa293810/', 'Nancy Bell', target = '_blank'), "(Virginia Department of Health);",
                                     a(href = 'https://www.linkedin.com/in/terri-alt-3138b4101/', 'Terri Alt', target = '_blank'), "(Virginia Cooperative Extension, Patrick County at Virginia Tech)."),
                                   p("", style = "padding-top:10px;"),
                                   h4(strong("Acknowledgments")),
                                   p("We would like to thank Healthy Patrick County, an association of concerned Patrick County residents, and Brandon Kramer for their input to this project.")
                          )
                          ),
                 inverse = T)



# server -----------------------------------------------------------
server <- function(input, output, session) {
  # Run JavaScript Code
 # runjs(jscode)
  
  # socio plots: done -----------------------------------------------------
  
  var <- reactive({
    input$sociodrop
  })
  
}

shinyApp(ui = ui, server = server)