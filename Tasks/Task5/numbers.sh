#!/bin/bash

echo "This script categorizes a number into different ranges"

echo "Enter a number:"
read number

if ((number < 10)); then
    echo "$number is less than 10."
elif ((number >= 10 && number <= 50)); then
    echo "$number is between 10 and 50."
elif ((number > 50)); then
    echo "$number is greater than 50."
fi