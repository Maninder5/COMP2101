#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label
echo "Enter a number:"
read first
echo "Enter a number:"
read second
echo "Enter a number:"
read third
sum=$((first + second + third))
product=$((first * second * third))


echo "SUM: $sum"
echo "PRODUCT: $product"
