# Platform Science API Testing Assignment using Behave BDD Framework


The project will help to run API Automation using Behave BDD Framework. The Behave BDD Framework is a cucumber-clone for Python.

## Features

- Run API automation using behave.
- Generate Allure report, which gives a good GUI representation of test execution output.


## Software Installation
Below instructions will help you download and install required software on Windows machine to run the project -

1) Python
    - Download and install the Python 3.x as per the instructions mentioned on- https://www.ics.uci.edu/~pattis/common/handouts/pythoneclipsejava/python.html
    - Go to Control Panel ->System Variable and set path for Python and Python ->Scripts folder.
    - Open Command prompt and run python --version to verify the installation. 

2) Allure
    - Open link - https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/
    - And download the latest version .zip file
    - Unzip and copy the folder to desired directory
    - Go to Control Panel ->System Variable and set path for allure bin folder

## Set up the project to run

#### Download repository
- git clone https://github.com/anjalibansal28/PlatformScience

#### Activate the Virtual Envrionment
- Go to command prompt and navigate to the project folder using command - cd {project_folder_path}
- Run .\venv\Scripts\activate

#### Install python libraries
On the command prompt after activating the venv, run the below commands - 
- pip install behave
- pip install allure-behave
- pip install urllib3
- pip install certifi

#### Verification of the libraries
- Run command - pip list, all the newly installed libraries should be listed.

## Execute the Project
- Run the Docker container - pltsci-sdet-assignment. 
- The Docker should be up and running.
- After python libraries verification on the command prompt run **behave -f allure_behave.formatter:AllureFormatter -o reports/**
- This should run all the tests, giving the total number of Steps Passed, Failed, skipped etc. information in the terminal window.

## View the report
- On the terminal run **allure serve reports**

Allure Report should be populated in your browser. Below is a screenshot for the same - 

![Allure_Report_PS](https://user-images.githubusercontent.com/69657345/128636881-b07296e9-9946-43bb-afee-fd300aae8e6d.PNG)
