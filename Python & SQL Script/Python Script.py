import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
from datetime import time
#Avoid to give unnecessary warnings or errors
import warnings
warnings.filterwarnings('ignore')



df = pd.read_csv("/content/drive/MyDrive/Coffee Shop Sales (3) CSV.csv", delimiter=';')


#Display the current table
display(df)


#Show the number of columns and rows
df.shape


df.describe()


df.dtypes


#Remove any non-numeric characters (like currency symbols and spaces) in the unit price column
df['unit_price'] = df['unit_price'].replace(r'[^\d.,]', '', regex=True)


#Replace comma with dot if comma is used as decimal separator in the unit price column
df['unit_price'] = df['unit_price'].str.replace(',', '.', regex=False)


#Convert to float safely in the unit price column
df['unit_price'] = pd.to_numeric(df['unit_price'], errors='coerce').fillna(0.0)


#Round to 2 decimals (if needed) in the unit price column
df['unit_price'] = df['unit_price'].round(2)



df.describe()



display(df)




#Chcking the sum of the unit price column
total_unit_price = df['unit_price'].sum()
print(total_unit_price)



#Calculation to obtain Total sales
df['total_sales'] = df['transaction_qty'] * df['unit_price']


display(df)



#Check the columns of the table
df.columns



#Checking for any duplicates in the table
df.duplicated().sum()



#Creating time buckets
df["transaction_time"] = pd.to_datetime(df["transaction_time"], errors='coerce')
times = df["transaction_time"].dt.time
peakmorningrush = (times >= time(6, 0, 0)) & (times <= time(8, 59, 59))
midmorning  = (times >= time(9, 0, 0)) & (times <= time(11, 59, 59))
afternoon = (times >= time(12, 0, 0)) & (times <= time(15, 59, 59))
peakafternoonrush = (times >= time(16, 0, 0)) & (times <= time(17, 59, 59))
evening = ~peakmorningrush & ~midmorning & ~afternoon & ~peakafternoonrush
conditions = [peakmorningrush, midmorning, afternoon, peakafternoonrush, evening]
choices = ['peak morning rush', 'mid morning', 'afternoon', 'peak afternoon rush', 'evening']
df['Time Buckets'] = np.select(conditions, choices, default='Unknown')



display(df)


#Convert the transaction date column to datetime format
df["transaction_date"] = pd.to_datetime(df["transaction_date"], errors='coerce')



#Extract year and month into a new Month ID Column
df["Month_ID"] = df["transaction_date"].dt.strftime("%Y%m")



display(df)



df['weekday'] = pd.to_datetime(df['transaction_date'], errors='coerce').dt.day_name()



display(df)


#Checking the sum of the total_Sales column
total_sales = df['total_sales'].sum()
print(total_sales)
import matplotlib.pyplot as plt

# Group by Month_ID and sum total sales
monthly_sales = df.groupby('Month_ID')['total_sales'].sum().reset_index()

# Plotting using seaborn (alternative)
plt.figure(figsize=(10, 6))
sns.barplot(data=monthly_sales, x='Month_ID', y='total_sales')
plt.xlabel("Month ID")
plt.ylabel("Total Sales")
plt.title("Total Sales by Month")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()



# Product Popularity Visualization
top_products = df.groupby('product_category')['total_sales'].sum().sort_values(ascending=False).head(10)
plt.figure(figsize=(10, 6))
sns.barplot(x=top_products.values, y=top_products.index, palette='viridis')
plt.xlabel('Total Sales')
plt.ylabel('Product Name')
plt.title('Top 10 Most Popular Products')
plt.show()



import matplotlib.pyplot as plt
import seaborn as sns  

# Group by store_location and sum total sales
sales_by_location = df.groupby('store_location')['total_sales'].sum()

# Plotting using seaborn with custom color
plt.figure(figsize=(10, 6))
sns.barplot(x=sales_by_location.index, y=sales_by_location.values, color='#FFD700')  # Change color here
plt.xlabel("Store Location")
plt.ylabel("Total Sales")
plt.title("Total Sales by Store Location")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()



monthly_sales = df.groupby('Month_ID')['total_sales'].sum().reset_index()


plt.figure(figsize=(10, 6))
sns.lineplot(data=monthly_sales, x='Month_ID', y='total_sales', marker='o')

plt.title('Total Sales by Month')
plt.xlabel('Month')
plt.ylabel('Total Sales')
plt.xticks(rotation=45)
plt.grid(True)
plt.tight_layout()
plt.show()


import matplotlib.pyplot as plt

# Group by store_location and sum total sales
sales_by_location = df.groupby('store_location')['total_sales'].sum()


# Plot pie chart
plt.figure(figsize=(8, 8))
plt.pie(
    sales_by_location,
    labels=sales_by_location.index,
    autopct='%1.1f%%',         # show percentages
    startangle=140,
    shadow=True
)

plt.title('Total Sales by Store Location')
plt.axis('equal')  # Equal aspect ratio ensures pie is a circle
plt.show()



sales_by_weekday_location = (
    df.groupby(['weekday', 'store_location'])['total_sales']
    .sum()
    .reset_index()
)



#Reorder weekdays for proper sorting
weekday_order = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
sales_by_weekday_location['weekday'] = pd.Categorical(sales_by_weekday_location['weekday'], categories=weekday_order, ordered=True)
sales_by_weekday_location = sales_by_weekday_location.sort_values('weekday')



#Plottin the graph
plt.figure(figsize=(12, 6))
sns.barplot(
    data=sales_by_weekday_location,
    x='weekday',
    y='total_sales',
    hue='store_location',
    palette='Set2'
)

plt.title('Total Sales by Day of the Week and Store Location')
plt.xlabel('Day of the Week')
plt.ylabel('Total Sales')
plt.xticks(rotation=45)
plt.legend(title='Store Location')
plt.tight_layout()
plt.grid(True)
plt.show()


# Calculate total sales by time bucket
sales_by_time_bucket = df.groupby('Time Buckets')['total_sales'].sum()


# Plotting using matplotlib
plt.figure(figsize=(10, 6))  # Adjust figure size if needed
plt.bar(sales_by_time_bucket.index, sales_by_time_bucket.values)
plt.xlabel("Time Bucket")
plt.ylabel("Total Sales")
plt.title("Total Sales by Time Bucket")
plt.xticks(rotation=45, ha="right")  # Rotate x-axis labels for better readability
plt.tight_layout()  # Adjust layout to prevent labels from overlapping

# Define the desired order of time buckets
desired_order = ['peak morning rush', 'mid morning', 'afternoon', 'peak afternoon rush', 'evening']

# Plotting using matplotlib
plt.figure(figsize=(10, 6))
plt.bar(desired_order, sales_by_time_bucket[desired_order])
plt.xlabel("Time Bucket")
plt.ylabel("Total Sales")
plt.title("Total Sales by Time Bucket")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()




import matplotlib.pyplot as plt

# Group by product_detail and sum total sales
sales_by_product = df.groupby('product_detail')['total_sales'].sum().reset_index()


# Sort by total sales in descending order and select top 10
top_10_products = sales_by_product.sort_values(by='total_sales', ascending=False).head(10)

# Plotting using matplotlib with custom color
plt.figure(figsize=(12, 6))
plt.bar(top_10_products['product_detail'], top_10_products['total_sales'], color='skyblue')  # Change color here
plt.xlabel("Product Detail")
plt.ylabel("Total Sales")
plt.title("Top 10 Products by Total Sales")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()



# Extract hour of the day and weekday
df['hour'] = df['transaction_time'].dt.hour

# Group by hour and weekday and count sales
sales_by_hour_weekday = df.groupby(['hour', 'weekday'])['total_sales'].count().reset_index()

# Pivot the data for heatmap
sales_heatmap = sales_by_hour_weekday.pivot(index='weekday', columns='hour', values='total_sales')

# Reorder weekdays for proper sorting
weekday_order = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
sales_heatmap = sales_heatmap.reindex(weekday_order)

# Plot the heatmap
plt.figure(figsize=(12, 6))
sns.heatmap(sales_heatmap, cmap='viridis', annot=True, fmt='d')
plt.title('Total Sales Count by Hour and Weekday')
plt.xlabel('Hour of the Day')
plt.ylabel('Weekday')
plt.show()





