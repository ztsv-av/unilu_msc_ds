Good afternoon, Professors, and everyone present. Thank you for the opportunity to present my master’s thesis internship report.

My name is Anton, and I completed a six-month internship as a Business Analyst at Amazon, working within the EU Supply Chain division.

Today, I’ll walk you through the main projects I worked on — focusing on maximum inbound capacity modeling and validation, and a side project on backlog analysis — and show how these contributed to improving planning and decision-making across Amazon’s European network.

----

First, I want to talk a little bit about Amazon. Amazon is not only the amazon.com website, it controls many businesses, such as prime video, twitch, alexa, audible, etc. The branch of amazon we will focus today on is the supply chain, the one responsible for delivering items to customers when they place an order on the amazon website.

----

Amazon’s Supply Chain in Europe handles between 20 to 40 million units every week. Here is the general overview of the supply chain end-to-end pipeline. First, amazon orders inventory from vendors to sell on their website, The items are then first preprocessed at cross-dock sites (known as IXDs) and then go to the warehouses, or Fullfilment Centers (FCs), where they are stored until a customer places an order. Once the order is placed, Amazon handles picking, packing and delivery to the customer. There is also a system called Fulfilment By Amazon, or FBA, where sellers sell their products on Amazon (instead of Amazon itself, like in the Retail process) and allow Amazon handle basically everything, including storing, picking, packing and shipping.

----

So what does a business analyst do at Amazon supply chain division? As business analysts, our role is to bridge data and operations: we extract and clean data, analyze it, build dashboards, develop optimization algorithms and machine learning models for planning and forecasting (such as forecasting sold units, for example).

----

The core problem we addressed during the internship is inefficiency in site utilization. Without reliable data and accurate models of maximum processing capacity of amazon facilities (IXDs, FCs), planning teams risk over-utilization, which leads to bottlenecks and delays, or under-utilization, which wastes resources and increases costs.

The key challenges were the lack of reliable data, and the difficulty of accurately modeling maximum processing capacity, due to the complexity of the processing pipelines inside the Amazon facilities.

----

To address this, we set three objectives: First, validate the maximum processing capacity models developed by another team. Second, build monitoring dashboards that not only compare planned volumes against modeled maximum capacities, but also allow scenario analysis — for example, adjusting inputs to the maximum capacities models to see how different planning assumptions affect site utilization. And third, prepare the foundation for optimization task to balance inbound volumes across the whole EU supply chain network.

----

During the internship, these were the main tools I used:

I used SQL daily for data extraction, transformation, preprocessing. 30K lines of SQL code is a rough approximation of how much SQL I wrote during the internship.
I also used QuickSight for data visualization and dashboard creation.
Python data preprocessing and some analysis.
And finally some basic statistics.

----

Let’s now talk about the work completed during the internship. The first side project that I worked on is called Optimal Backlog Identification

----


The first project is called Optimal Backlog Range Identification. Let’s first define backlog. 

Backlog is the amount of inbound inventory waiting to be processed at a site. It is usually measured in backlog days, which represent how long it would take a site to clear the current backlog at its processing rate.

The goal of the project was to find the range in which a site works in the most optimal way. In simple terms, too little backlog underutilizes the site, while too much backlog overloads it.

As an example in this figure, the range between 1.5 to 2.5 backlog days is the optimal zone where site reaches its maximum throughput and works efficiently.

----

We started by analyzing receipts vs backlog days relationship (receipts is how many units were received and processed at a specific day, and what was the end of the day backlog).
We hypothesized a parabola or plateau relationship between these two variables.
The idea was that at low backlog, receipts increase with backlog (positive correlation).
At high backlog, capacity becomes bottleneck → receipts plateau or decline.
So, we wanted to see this relationship between the variables.

----

First, we started with data preprocessing.
We applied quantile filtering to remove noise and extreme values, where we grouped by warehouse and weekday, and kept data between the 5th and 95th percentiles.

Then, we tested several methods:
Correlation analysis → unstable results
Quadratic fit → sometimes worked, not consistent
LOESS smoothing → captured local patterns, but suffered from noisy data.

Our final approach was a hybrid method: we LOESS smoothing (to further reduce noise and capture the trend) and then applied quadratic fit to the LOESS line.

----

We first performed this method on the per Warehouse grouping. For each examined warehouse, we had results which resembled our hypotheses. The dashed line in blue is the LOESS smoothing, the green line is the quadratic fit on the LOESS line, and the red zone is the optimal backlog range. Semi-transparent blue and green zones correspond to 95% confidence intervals for LOESS smoothing and quadratic fit, respectively, calculated using bootstrap resampling. 

To estimate the optimal backlog range (the red zone), rather than just a single point (the peak of the parabola), we first calculated the slope of the quadratic fit, then normalized it to the [0, 1] range, and finally identified intervals where the slope remained below a defined threshold (we used a slope threshold of 0.15, which typically corresponded to a zone of approximately 0.5 backlog days). This range was interpreted as the “optimal zone” where the site operated efficiently, i.e., avoiding both underutilization and overloading.

----

Then, we performed the same analysis, but grouping data per weekday. Again, we noticed the same parabola-shaped relationship, and could deduce the optimal backlog range.


----

Now, when we grouped by warehouse and weekday together, we unfortunately did not achieve consistent results, as we believe due to the lack of data. The resulting relationship (as you can see in this figure) was sometimes anm always decreasing function.

----

We tried another method, where instead of grouping by warehouse and weekday at the same time, we would retrieve the resulting ranges from the separate groupings, and then create an intersection of these ranges. By doing this, we could retrieve the optimal backlog ranges per warehouse and per weekday. The results, again, were not always consistent. 

----

We then had a meeting with IBET team, who is responsible for inbound operations, where we presented our work and findings. IBET said that ranges for most of the sites match what they had in their own analysis.
They also asked us to check our method using by quarter grouping, to check the seasonal variation.
Our quarter grouping findings suggested that the method yields good results (by good I mean supporting the hypothesis or any useful result) when we had enough data, but quarter-level splits sometimes yielded inconsistent results and contradicted hypothesis (e.g. the one at the bottom right, where we see a down facing parabola)
So, the conclusion of our work was that it was a promising method, but needed more data and more robust data preprocessing. Perhaps some tweaks in the method too.
Unfortunately, we couldn’t work more on this project, due to time limitations, which is why we moved on the next project.

----

The second and main project we worked on was the inbound maximum processing capacity project (or MPC for short).

----

MPC was the main project of the internship.
First, I would like to start with a quote of my manager, Ivano: “The success of the supply chain depends on the inbound: if we place inventory in the right facilities, we can deliver fast – and accurate maximum processing capacity models tell us where to place it”
The project was structured in 3 main phases: 1st is validation of the MPC models; 2nd is the building of the utilization monitoring and scenario planning dashboards; and 3rd is the EU network optimization task.

----

The project started with the IXD facilities.
Here is the general IXD inventory processing pipeline overview:
1. The inventory is received from vendors & sellers (New Vendor Fright, NVF) (3 receive funnels, fluid case, pallet mixed asin, pallet mono asin). Funnel is basically packaging type,
2. Inventory comes in cases (boxes) and pallets (wooden platforms with stacked boxes)
Single ASIN means a lot of units of a single product on a pallet.

----


Moving on to the validation part.
We needed to validate the current state of the MPC models.
We used peak 2024 data (October - December) as the data to compare against.
We validated the total inbound capacity, sortation, and all the inbound receive processes (pallet, fluid).

In the validation:
1. Checked average utilization across all processes for the top 5 inbound volume days.
2. Measured the number of max capacity breaches, meaning where historical volume was greater than the maximum capacity.
3. And compared daily P95 percentile of historical volumes against MPC values.

---

Here is the summary view of how one of the validation parts looked like.
The first on the left is the capacity ratio average for top 5 inbound volume days. As you can see, for example for DTM2, capacity average uitlization is 119%, meaning the MPC stated values were too low.

74 days for the breaches.

Note that metrics involving 95% confidence intervals, such as relative error, were computed using z−scores when the number of data points was 30 or more (z = 1.96), and t−distribution values when fewer data points were available (e.g., t = 2.064 for 25 points, t = 2.093 for 20 points). Use z because the number of points is enough and central limit theorem starts working. Use t because it accounts for the extra uncertainty from estimating the popilation standart deviation with the sample standart deviation. It has heavier tails, making confidence intervals wider, good when not enough points.

----

The reason we perform validation is to make sure the modeled capacities align with reality, that the models take accurate inputs and produce accurate outputs.
Here is the example result of our validation for the IXD model:
Identified incorrect assumptions in sortation subprocesses (manual, 20LB, 5LB)
Corrected model inputs (stations, hourly rates) in collaboration with ACES team
Reduced relative error: for total sortation by 18% and achieved final total site capacity error of 7%

----

Another side note on the data extraction. All the dashboards developed required us to create complex data extraction pipelines using queries. 
The data used was extracted from different tables and different databases, which required us to join and reconcile information across multiple sources.
Of course, we needed to first find the source of the information, then make sure its trustworthy, and only then add it to the data extraction and preprocessing pipeline.

----

Now, for the planned capacity utilization monitoring dashboard.
The goal was to show the planned versus modeled MPC for each site. This way, planners could see the overutilization and underutilization in the whole EU IXD network.
We also allowed testing different scenarios, where we created controls that planners could use to change the MPC model inputs, such as the pallet share. The MPC model depends on many inputs, and the pallet share is one of the inputs that greatly affects the capacity value.

----

So, these were one of the views developed for the IXD utilization monitoring dashboard.
This view is for receive and sort capacity utilization. We show the summary view, and the deep dive view. In the deep dive view, additionally to the capacity utilization percentage, we show what is the planned inbound and maximum inbound capacity, in units. As said before, there are multiple controls not shown here that allow changing the inputs to the MPC model, which in turn change the maximum capacity values, changing the utilization percentage.

----

Let’s now move to the FC part.
It was the same as with the IXD: first, validation, then utilization dashboards.
However, FCs have a higher complexity: they have 5 more receive funnels, which makes the validation, and capacity modeling more difficult. These 5 funnels come from IXD preprocessed inventory.
We will skip the validation part, due to time limitation, but the process was similar to the IXD one.

----

Moving to the utilization dashboard. For the FCs, we developed 3 views:
1. 1st is the general overview of the FC MPC utilization, splitting also into TSI and NVF capacity views.
2. The second and third ones allowed checking for different planning scenarios.
3. The second focused on MPC based on fullness levels. The fullness measures how full the stowing and picking bins are. The fuller they are, the more time it takes to stow/pick, reducing the rate, reducing the max capacity.
4. The third and final view based designed to check the MPC based on different units per tote values. This view required quite a bit of modeling on our part.
Let’s delve deeper into them.

----

We will skip the first view, as it was very similar to the IXD view shown before, just for FC total capacity, TSI and NVF capacities.
The fullness view allowed to change the fullness level, which in turn would increase or decrease the MPC, since the fullness affects the pick and stow rates. See the figure how MPC drops.
We can see how MPC drops significantly as fullness increases.

----

The last view is the units per tote view, or UPT view.
In this view we wanted to allow users to change the assumed UPT value in the model.
On the slide you see the general overview of the FC inventory processing pipeline.

----

This process is sequential. The MPC value depends on the output of the STOW. The STOW depends on the output of SPIRALS, and it in turn depends on the DISTRIBUTION SORTER. So we start with the DS, as it is the first process in our pipeline. First, we calculate the new DS capacity by diving the DS capacity by assumed in the model UPT value and multiplying with the new UPT value, to align the model with the user selected UPT. Then we check … If its less, we move on the second step.

----

Why is that? Let’s take an example. Let’s assume conveyor output is 100K. New DS output is 120K. It can process 120K units, but there are only 100K units. Thus, the output is 100K, i.e. the minimum between the two.

----

We repeat this process for SPIRALS and STOW. And we repeat this whole pipeline for all the funnels that we have, which there are 8 of them (go back).

----

So, the result of this is a very simple dashboard view. We showed what is the selected UPT value. What is the according MPC value and the utilization.

----

Now let's move on to the summmary and conclusion.

Overall, the inbound capacity project achieved the three objectives. We validated and improved ACES models, built IXD and FC dashboards with scenario analysis, and laid the foundation for optimization.
The work is now used as a source of truth across multiple teams, scheduled for deployment in peak 2025 to support better planning and reduce over- and under-utilization.

The backlog project showed potential methods to identify optimal backlog thresholds, but needs further development.

----

To conclude, this internship allowed me to contribute in two key areas.
First, the backlog project, where we developed a method to identify optimal backlog range.
And second, the capacity project, a EU wide initiative which is scheduled for full deployment in the next few month.
On a personal level, I learned the importance of choosing simple and interpretable solutions over unnecessarily complex ones, strengthened my skills in SQL, data validation, data pipelines, and data visualization, and gained experience in communication.

----

I’d like to thank my manager at Amazon, Ivano, for his guidance throughout this internship. My mentor, Piyush, for his support and for working closely with me every day. And of course, professors at the University of Luxembourg, for their guidance and for giving me the opportunity to complete this master’s program.

----

Thank you for your time and attention. I would be happy to take any questions now.
