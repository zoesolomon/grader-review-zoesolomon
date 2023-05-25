# run with the format "bash grade.sh <github link> <file name>"

CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

set -e

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
cp -r lib grading-area



# Check that the student code has the correct file submitted. If they didn’t, 
#detect and give helpful feedback about it. This is not done by the provided code, 
# you should figure out where to add it Useful tools here are if and -e/-f. 
# You can use the exit command to quit a bash script early.

file=$2

if [ -f student-submission/"$file".java ]; then
    echo "Correct file submitted!"
else
    echo "Incorrect file submitted. Please submit file titled $file"
    exit 1
fi

# Get the student code, the .java file with the grading tests, and any other files 
# the script needs into the grading-area directory. The grading-area directory is 
# created for you, but you should move the files there.
# Useful tools here might be cp (also look up the -r option to cp)

cp -f student-submission/"$file".java ./grading-area
cd grading-area


# Compile your tests and the student’s code from the appropriate directory with the
# appropriate classpath commands. If the compilation fails, detect and give helpful
# feedback about it. You should add this 
# Aside from the necessary javac, useful tools here are output redirection and error
# codes ($?) along with if
# This might be a time where you need to turn off set -e. Why?

set +e

# javac student-submission/"$file"

javac -cp "$CPATH" "$file.java"

if [ $? -eq 0 ]; then
    echo "file compiles!"
else
    echo "complilation error"
fi 

java -cp "$CPATH" org.junit.runner.JUnitCore "$file"

    


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
