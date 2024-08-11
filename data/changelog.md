## Changelog
This file contains notable changes made during data cleaning.

Version 1.0 (2024-08-08)

### Changes to the original data table "bike_rides"
* Deleted 7919 rows with missing spatial information and strange ride durations.
* Deleted 23092 rows with riding duration greater than 24 hours.
* Coordinate values rounded to three decimal places to avoid grouping inconsistencies.

### New
* Added table "date_time" which contains useful information about the rides dates, time and duration.
* Added table “staions” whick contains information about bike stations, and their traffic.
