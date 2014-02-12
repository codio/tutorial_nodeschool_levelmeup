#!/bin/bash 
 
# Check parameters 
if [[ "$#" -ne 3 ]]; then 
    echo "3 parameters required" 
    exit 0 
fi 
 
# Translate lesson name into correct name for Workshopper projects 
if [ $2 == "all_your_base" ]; then 
    STR="ALL YOUR BASE" 
elif [ $2 == "get_your_level_on" ]; then 
    STR=" Get Your Level On!" 
elif [ $2 == "basics_get" ]; then 
    STR="Basics: GET" 
elif [ $2 == "basics_put" ]; then 
    STR=" Basics: PUT" 
elif [ $2 == "basics_batch" ]; then 
    STR="Basics: BATCH" 
elif [ $2 == "streaming" ]; then 
    STR="Streaming" 
elif [ $2 == "horse_js_count" ]; then 
    STR="@horse_js Count" 
elif [ $2 == "horse_js_tweets" ]; then 
    STR="@horse_js Tweets" 
elif [ $2 == "keywise" ]; then 
    STR="Keywise" 
elif [ $2 == "short_scrabble_words" ]; then 
    STR="Short Scrabble Words" 
elif [ $2 == "sublevel" ]; then 
    STR="Sublevel" 
elif [ $2 == "multilevel" ]; then 
    STR="Multilevel" 
else 
    echo UNKNOWN: Make sure you have your code file selected before running/verifying 
    exit 0 
fi 
echo SELECTED FILE IS : $STR 
 
#Select the workshopper lesson 
levelmeup select $STR > /dev/null 
 
# Run or Verify? 
if [ $1 == "run" ]; then 
    levelmeup run $3/$2.js 
elif [ $1 == "verify" ]; then 
    levelmeup verify $3/$2.js 
else  
    echo "BAD COMMAND" 
fi