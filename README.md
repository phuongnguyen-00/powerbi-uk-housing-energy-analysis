###############################################
# UK Housing Energy Efficiency & CO₂ Emission #
#        Interactive Power BI Dashboard       #
###############################################

## Author: Phuong Hoang Nguyen
## Date: September 2025

#########################
## PROJECT DESCRIPTION ##
#########################

This project presents an interactive Power BI dashboard that visualises the relationship between 
property characteristics, carbon dioxide emissions, and energy efficiency across the UK. The dashboard 
allows users to explore geographic emission patterns, compare efficiency trends over time, and analyse 
multi-dimensional relationships across variables such as property type, tenure, region, and CO₂ output.

The dataset used in this project originates from open housing and environmental data sources. 
The full Power Query (M) script used for data cleaning and transformation is provided so the 
entire workflow can be reproduced with any compatible dataset.

#######################
## TECHNOLOGIES USED ##
#######################
- Power BI Desktop  
- Power Query (M Language)  
- Data Modelling (DAX-free project)  
- Power BI Visualisation framework  
- GitHub for version control and documentation

#########################
## DIRECTORY STRUCTURE ##
#########################

### - Data Visualization Dashboard.PNG
####     Exported PNG image of dashboard view

### - Data Visualization.pbix
####     Main Power BI file

### - MasterData_Cleaning.m
####     Full Power Query M script used to clean, transform, and prepare the dataset, including:
- Automated SharePoint file retrieval
- Column type cleaning
- Feature creation (e.g., emission categories)
- Dataset filtering and renaming
- Final model-ready output table

### - README.md
####     This file, containing the project description and structure

##############################
## DASHBOARD FUNCTIONALITIES ##
##############################
- CO₂ emission comparison by region and property type  
- Geographic visualisation using a bubble map  
- Energy efficiency trend analysis (2013–2023)  
- Multi-dimensional scatter chart exploring correlations  
- Interactive slicers for region and property type  
- Colour-blind safe palette and accessibility-driven design
