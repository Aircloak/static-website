## Datasets

Aircloak provides the following datasets. All datasets are publicly available and are used in the original form (not cleaned) with the exception that a `lastname` column has been added to each dataset. The `lastname` is synthetic generated from the distribution of last names published by the US census bureau. This column has been added to give each dataset another kind of text data field that might be interesting to attack.

In the following descriptions, we refer to online documents that more-or-less describe the meaning of the data in the columns. Some of these descriptions are less than perfect, but understanding of the column meaning is not important for an attack. Other than the column that contains the unique User ID, Aircloak Insights does not differentiate between columns, for instance whether a column is sensitive or not, or whether a column contains personally identifying information. Likewise neither does the α,κ score distinguish between columns.

**The scihub dataset:**
This lists downloads from the scientific paper pirating website sci-hub.io for the month of September 2015. It has 8 columns and roughly 600K distinct users (downloader IP address, hashed) and 5M rows (downloads). Columns include user ID, document ID, timestamp, and location (city and country, and corresponding latitude and longitude).

**The taxi dataset:**
This is one day of taxi rides for all of NYC (January 8, 2013). It has 22 columns and roughly 25K distinct users (drivers) and 500K rows (rides). The med (medallion) identifies the car, and the hack identifies the driver. The dataset is configured to protect the hack. Links to documents describing most of the other column definitions can be found at http://www.nyc.gov/html/tlc/html/about/trip_record_data.shtml.

**The banking database:**
User data and banking transactions for a real bank in the Czech Republic (this data is already slightly pre-anonymized, but retains the structure of the original data). It has 7 tables with between 4 and 18 columns for roughly 5000 distinct users (customers). There are roughly 1.25M transactions, 800 loans, and 8000 orders, among other things. A description of the data is linked from http://lisp.vse.cz/pkdd99/.

**The census datasets:**
Actual US census data (pre-sampled by the Census Bureau, but otherwise not anonymized). There are 112 columns with roughly 3M individuals from 1.4M households. We have configured two datasets from this data. One dataset protects the individuals. The other protects the household.  Column definitions can be found via this page: https://usa.ipums.org/usa-action/variables/group.
