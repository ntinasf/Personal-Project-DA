## Intro<br><hr>
This is a personal data analysis project inspirede by this [module](https://www.coursera.org/learn/google-data-analytics-capstone) of the Google Data Analytics certicate.
<br>The purpose of this project is to conduct an end-to-end data analysis procedure for a fictional company named *Cyclistic*.<br><br>

## Objective<br><hr>
The task at hand is to identify how do annual members (*members*) and casual riders (*casuals*) use Cyclistic bikes differently.<br>
The findings of this analysis can help the company maximize its' annual memberships.<br><br>

## Data<br><hr>
The data source can be found [here](https://divvy-tripdata.s3.amazonaws.com/index.html). These are open source data made available by Motivate International Inc. under this[license](https://divvybikes.com/data-license-agreement). Note that rider's personally identifiable information is prohibited for privacy reasons.<br><br>

### Storage<br><hr>
The datasets in their source are organized in zip files that contain trip data, each for a particular month.<br>
For this task we used the available data from July 2023 until June 2024. The files where dowloaded and extracted into the [data](https://github.com/ntinasf/Personal-Project-DA/tree/main/data) folder, and then they were merged into a unified csv file using the *merge_data.py* python script.<br>

### Data cleaning and tranformation<br><hr>
For this step the unified csv file was uploaded to BigQuery. The specific steps followed for cleaning and examining the data are included in the *data_cleaning.sql* file along with the corresponding *changelog.md* file.  Finally, two new csv files were created that will allow us to draw valuable insights.<br>
**Note :** The files mentioned above are all included in the [data](https://github.com/ntinasf/Personal-Project-DA/tree/main/data) folder, except from the csv files for storage reasons.<br><br>

### Data analysis<br><hr>
The new tables named *stations.csv* and *date_time.csv* were downloaded from BigQuery and then analyzed using a Jupyter Notebook running python (v3.11.9). For more details and source code refer to [analysis.ipynb](https://github.com/ntinasf/Personal-Project-DA/blob/main/analysis.ipynb).
