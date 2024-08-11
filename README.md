## Bike-sharing case study<br>

## Intro<br><hr>
This is a personal data analysis project inspired by this [module](https://www.coursera.org/learn/google-data-analytics-capstone) of the [Google Data Analytics certificate](https://www.coursera.org/professional-certificates/google-data-analytics).
<br>The purpose of this project is to conduct an end-to-end data analysis procedure for a fictional company named *Cyclistic*.<br><br>

### Objective<br><hr>
The task at hand is to identify how do annual members (*members*) and casual riders (*casuals*) use Cyclistic bikes differently.<br>
The findings of this analysis can help the company increase its' annual memberships through strategic marketing.<br><br>

### Data<br><hr>
The data source can be found [here](https://divvy-tripdata.s3.amazonaws.com/index.html). These are open source data made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement). Note that using rider's personally identifiable information is prohibited for privacy reasons.<br>
For this task we used the available data from July 2023 until June 2024. The files where downloaded and extracted into the [data](https://github.com/ntinasf/Personal-Project-DA/tree/main/data) folder, and then merged into a unified csv file through the *merge_data.py* python script.<br><br>

### Data cleaning and tranformation<br><hr>
For this step the unified csv file was uploaded to BigQuery. The specific steps followed for examining and cleaning the data are included in the *data_cleaning.sql* file along with the corresponding *changelog.md* file. Two new csv files were created that will help us draw valuable insights.<br>The first, named *date_time.csv* holds information about time, date and duration of each ride. The second, named *stations.csv* holds information about stations and their traffic. 

### Data analysis<br><hr>
The new tables were downloaded from BigQuery and then analyzed using a Jupyter Notebook running python (v3.11.9). For more details, visualizations and source code refer to [analysis.ipynb](https://github.com/ntinasf/Personal-Project-DA/blob/main/analysis.ipynb).<br><br>

### Findings and recommendations<br><hr>
#### *How do members compare to casuals ?*<br>
| Members | Casuals |
| --- | --- |
| Riding preference peaks on weekdays | Riding preference peaks on weekend |

![alt text](<../repos/Personal Project DA/images/day.png>)
![alt text](<../repos/Personal Project DA/images/preference.png>)
<br><br>
| Members | Casuals |
| --- | --- |
| Rely on bikes for utilitarian reasons (eg. go to/return from work) |  Use bikes mainly for leisure activities in the afternoon|

![alt text](<../repos/Personal Project DA/images/hour.png>)
<br><br>

| Members | Casuals |
| --- | --- |
| Top destinations include office parks and downtown destinations (dark green circles)| Top destinations are mostly tourist places and coastal areas (big circles) |

![alt text](<../repos/Personal Project DA/images/stations.png>)
<br><br>

| Members | Casuals |
| --- | --- |
| Prefer shorter rides (mainly between 5 and 15 min) | Prefer longer rides (mainly between 7 and 23 min) |

![alt text](<../repos/Personal Project DA/images/duration.png>)
<br><br>

#### *Recommendations*<br>
* Attract new members by offering discounts for longer rides, especialy during weekends.
* Promote bicycle usage for daily commutes and not just for leisure activities.
* Promotions should be targeted towards popular casuals' destinations, and stations where the two groups behave similarly. 
