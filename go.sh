#!/bin/bash
touch results.csv && sudo docker run -v $PWD/queries:/example-queries -v $PWD/results.csv:/results.csv gosom/google-maps-scraper -depth 1 -input /example-queries -results /results.csv -exit-on-inactivity 1m -email
# Read the first line from the file 'queries'
first_line=$(head -n 1 queries)
# capture the first line of 'queries' 
first_line=$(head -n 1 queries | tr ' ' '_')

# Ensure the 'results' directory exists
mkdir -p results

# Rename and move the results.csv to the 'results' directory with the new name
mv results.csv "results/${first_line}.csv"

# Use csvcut to keep only columns C, E, I, and AF (indices 3, 5, 9, 32)
csvcut -c 3,5,9,32 "results/${first_line}.csv" > "results/temp_${first_line}.csv"
mv "results/temp_${first_line}.csv" "results/${first_line}.csv"
