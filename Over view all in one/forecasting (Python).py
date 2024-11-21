# This script processes a Superstore Sales dataset, focusing on sales data for a specific category ('Technology').
# It first loads and prepares the data, converting the 'Order Date' to a datetime format.
# The script then aggregates sales by month for the chosen category and applies the Holt-Winters Exponential Smoothing method 
# for forecasting future sales. If there are at least 24 months of data, it generates a 12-month forecast.
# The results, including the actual and forecasted sales, are plotted for visualization. 
# If there is insufficient data for forecasting, the script informs the user and does not generate a forecast.

import pandas as pd
from google.colab import files

# Upload the dataset
Data = files.upload()
  
# Load the dataset into a pandas dataframe
df = pd.read_csv('/content/Superstore Sales Dataset.csv')
print(df.head())

# Convert 'Order Date' column to datetime format
df['Order Date'] = pd.to_datetime(df['Order Date'], format='%d/%m/%Y')

# Import necessary libraries for time series forecasting and plotting
from statsmodels.tsa.holtwinters import ExponentialSmoothing
import matplotlib.pyplot as plt

# Filter the dataset for a specific category (Technology in this case)
category_name = 'Technology'
df_category = df[df['Category'] == category_name]

# Aggregate sales data by month for the chosen category
df_monthly_sales = df_category.groupby(pd.Grouper(key='Order Date', freq='M')).sum()['Sales']

# Apply Holt-Winters Exponential Smoothing if there is enough data
if len(df_monthly_sales) >= 24:
    model = ExponentialSmoothing(df_monthly_sales, trend='add', seasonal='add', seasonal_periods=12).fit()
    forecast = model.forecast(steps=12)
else:
    print("Not enough data for seasonal modeling.")
    forecast = None  

# Plot actual sales and forecasted sales (if available)
plt.figure(figsize=(10, 6))
plt.plot(df_monthly_sales, label='Actual sales', marker='o')

if forecast is not None:
    plt.plot(forecast, label='Expected sales', marker='o', linestyle='--', color='red')
else:
    print("Cannot plot forecast due to insufficient data.")

plt.title(f'Sales forecast for the  {category_name}')
plt.xlabel('Date')
plt.ylabel('Sales')
plt.legend()
plt.show()

# Print the dataframe columns
print(df.columns)
