#!/usr/bin/env bash

echo -n "Enter the name of your new app (i.e. walter, brema) and press enter? "
read answer

regex="^([a-z]{2,10})$"
if [[ $answer =~ $regex ]]; then
  echo "The name of your new app is: $answer"
  sleep 1
else
  echo "ERROR: Your app name '$answer' does not match syntax requirements!";
  echo "  *** Must match this regex: $regex"
  exit 1
fi

NAME=$answer

file_list=(Makefile 
           Dockerfile 
           build.gradle
           src/main/java/com/erebos/myapp/rest/DefaultController.java
           src/main/java/com/erebos/myapp/MyAppApplication.java
           src/main/java/com/erebos/myapp/rest/SwaggerConfig.java
           settings.gradle)

check_if_file_exists()
{
    file=$1
    if [ ! -f $file ]; then
       echo "File '$file' does not exit!"
       exit 1
    fi
}


replace_string_in_file()
{
    FILE=$1
    STRING_REPLACE=$2
    ORIGIN_STRING=$3
    check_if_file_exists $FILE
    sed "s/$ORIGIN_STRING/$STRING_REPLACE/g" $FILE > $FILE.new
    mv $FILE.new $FILE && rm -rf $FILE.new
}

first_char_to_uppercase()
{
    STRING=$1
    echo `echo ${STRING:0:1} | tr  '[a-z]' '[A-Z]'`${STRING:1}
}

for file in "${file_list[@]}"
  do
    replace_string_in_file $file $NAME myapp
  done

NAME_IN_UPPERCASE=$(first_char_to_uppercase $NAME)

# rename main java class file
mv src/main/java/com/erebos/myapp/MyAppApplication.java src/main/java/com/erebos/myapp/${NAME_IN_UPPERCASE}Application.java

# rename main class
replace_string_in_file src/main/java/com/erebos/myapp/${NAME_IN_UPPERCASE}Application.java $NAME_IN_UPPERCASE MyApp

# rename  folder
mv src/main/java/com/erebos/myapp src/main/java/com/erebos/$NAME

# remove clone of blueprint
rm -rf .git

# create new git repo for the new app
git init
git add .
git commit -m "initial commit for $NAME"
git log -n 1

echo "### DONE SUCESSFULLY! ###"
echo " >>> You can execute command 'make' now to build and run image loacally!"

