# COVID-19 Dashboard

This dashboard visualises COVID-19 data for England, allowing users to interactively select different metrics and refresh data from the UK Health Security Agency (UKHSA) API.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the Dashboard](#running-the-dashboard)
- [Usage](#usage)
- [Deployment](#deployment)
  - [Deploying on GitHub](#deploying-on-github)
  - [Deploying with Binder](#deploying-with-binder)
- [Licensing and Acknowledgments](#licensing-and-acknowledgments)
- [Contact](#contact)

## Overview

This dashboard allows users to:

- View COVID-19 statistics for England using data from a local `.json` file.
- Interactively select different metrics to display (e.g., New Cases, Cumulative Cases, New Deaths, Cumulative Deaths).
- Refresh the data by fetching the latest information from the UKHSA API.
- Visualise the data through interactive plots.

## Features

- **Data Wrangling and Visualisation**: Processes and displays data from a local JSON file upon startup.
- **Interactive Controls**: Provides dropdown menus and buttons using `ipywidgets` for interactive data exploration.
- **API Integration**: Fetches current COVID-19 data from the UKHSA API upon user request.
- **User-Friendly Interface**: Easy to navigate and interact with, suitable for users with no programming background.

## Getting Started

### Prerequisites

- Python 3.7 or higher
- Jupyter Notebook or JupyterLab
- The following Python libraries:
  - `pandas`
  - `numpy`
  - `matplotlib`
  - `requests`
  - `ipywidgets`
  - `voila`

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/elena1211/covid19-dashboard.git
   ```

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/elena1211/CovidDashboard.git
   ```

2. Navigate to the project directory:

   ```bash
   cd CovidDashboard
   ```

3. Install dependencies:

   ```bash
   pip install pandas numpy matplotlib requests ipywidgets voila
   ```

## Running the Dashboard

1. Start Jupyter Notebook

   ```bash
   jupyter notebook
   ```

2. Open the Dashboard Notebook

In the Jupyter interface, open the CovidDashboard.ipynb notebook.

3. Run the Notebook

Run all cells in the notebook to start the dashboard.

4. Using Voila (Optional for a Cleaner Interface)

Voila turns Jupyter notebooks into standalone web applications.

```bash
voila CovidDashboard.ipynb
```

This will open the dashboard in your default web browser without the code cells, providing a cleaner interface.

## Usage

- **Metric Selection**

Use the dropdown menu labeled "Select Metric:" to choose which COVID-19 metric to display.

- **Refresh Data**

Click the "Refresh Data" button to fetch the latest data from the UKHSA API. The plot will update accordingly.

- **Interacting with the Plot**

Hover over the plot to see specific data points. The plot automatically updates based on your selections.

## Deployment

### Deploying on GitHub

1. Create a GitHub Repository

If you haven't already, create a new repository on GitHub named CovidDashboard and push your project code to it.

2. Push Your Code

   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/elena1211/CovidDashboard.git
   git push -u origin master
   ```

## Deploying with Binder

Binder allows you to turn your GitHub repository into a shareable, interactive notebook.

1. Set Up requirements.txt

Create a requirements.txt file listing all the Python packages your notebook depends on:

```bash
pandas
numpy
matplotlib
requests
ipywidgets
voila
```

2. Create a runtime.txt File

Specify the Python version (e.g., python-3.8):

```bash
python-3.8
```

3. Use Binder

- **Go to MyBinder.org.**
- **Enter your GitHub repository URL: https://github.com/elena1211/CovidDashboard.git.**
- **Under "Path to a notebook file", enter CovidDashboard.ipynb.**
- **Click "Launch".**
- **Binder will provide you with a shareable link to your dashboard.**
  Alternatively, you can create a direct link:

  ```bash
  https://mybinder.org/v2/gh/elena1211/CovidDashboard/HEAD?urlpath=voila%2Frender%2FCovidDashboard.ipynb
  ```

  This tells Binder to render your notebook using Voila.

## Licensing and Acknowledgments

### License

This project is licensed under the GNU General Public License v3.0 or later.

[GNU GPLv3.0 License](https://www.gnu.org/licenses/gpl-3.0.en.html)

## Acknowledgments

- **Data Sources**

This dashboard is based on UK Government data published by the UK Health Security Agency (UKHSA). Data is accessed via the UKHSA API.

- **DIY Disease Tracking Dashboard Kit**

This project is based on the DIY Disease Tracking Dashboard Kit by Fabrizio Smeraldi.

- **Licensing Compliance**

Released under the GNU GPLv3.0 or later, in compliance with the licensing requirements specified in the assignment.

## Contact

For any questions or feedback, please contact:

- **Name: Yi-Ying (Elena) Chiang**
- **Email: elena791211@gmail.com**
- **GitHub: elena1211**
