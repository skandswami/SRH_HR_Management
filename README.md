Commands to install Flask environment:

(Considering Python and pip is already installed)

1.) pip install virtualenv
2.) virtualenv env
3.) source env/bin/activate(this course me different in a Windows machine, you need to specify the path to your activate file in the env folder, the command source look like source <path to your activate folder>)
Still having troubles, use this https://www.youtube.com/watch?v=GHvj1ivQ7ms&t=363s tutorial.

4.) flask run (to run the application)

5.) If there are errors related to imported packages, use command “pip install "<packagename>”
### Note
It is advisable to Create a User for your database(HR_SERVER) as HR_SERVER with password as HR_SERVER.
Then we wont need change connection strings at all.