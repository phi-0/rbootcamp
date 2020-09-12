This README file gives a short overview of the folder structure and the files contained within.


Lessis_Himmelberger.zip
|
|_ README.txt                                   [This README file]
|
|_ RBootcamp_Analysis_Rental_Bikes.PDF          [A PDF version of the knitr RBootcamp_Analysis_Rental_Bikes.html]
|
|_ \db                                          [Contains the serialised data frame object created after the initial load and transformation steps]
|   |
|   |__ data.RDS                                [The serialised data object used as the basis for our analysis]
|
|_ \scripts                                     [Contains the scripts used as well as their output]
|   |
|   |__ \img                                    [A subfolder containing images used in the RMarkdown output HTML/PDF]
|   |
|   |__ \RBootcamp_Analysis_cache               [A folder containing cached data object files of the knitr HTML creation]
|   |   |
|   |   |__ html                                [The subfolder containing the actual data object files for each chunk]
|   |
|   |__ \RBootcamp_Analysis_files               [A folder containing cache image files of graphs for the knitr HTML creation]
|   |   |
|   |   |__ html                                [The subfolder containing the actual image files for each chunk]
|   |
|   |__ RBootcamp_Analysis_Rental_Bikes.rmd     [The RMarkdown analysis file. This contains the logic for all steps performed and forms the basis for the creation of the HTML knitr output file]
|   |
|   |__ RBootcamp_Analysis_Rental_Bikes.html    [The HTML file created based on the .RMD script above using knitr]
|
|_ \source                                      [A folder containing the source data files. NOTE: This folder is not tracked/synced via git]
|
|_ \function_lists                              [Contains the R function lists for both authors]
|   |
|   |__ R-Function_List_Himmelberger.pdf        [R Function List PDF printout Pascal Himmelberger]
|   |
|   |__ R-Function_List_Lessis.pdf              [R Function List PDF printout Konstantinos Lessis]