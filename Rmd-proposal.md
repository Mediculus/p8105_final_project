P8105 Data Science I - Finals Project Proposal
================
02 November 2019

# Tentative Title

Our tentative title is: Exploring The Use of Fragility Index outside of
Oncology Drug Development

# Team Members

  - “Bryan Bunning - UNI: bjb2178”
  - “Gavin Ko - UNI: wk2343”
  - “Yuanzhi (Fisher) Yu - UNI: yy3019”
  - “Zongchao Liu - UNI: zl2860”
  - “Kevin S.W. - UNI: ksw2137”

# Motivation

Fragility index has been suggested to be a simple metric of a trials’
robustness, which may pair well with other metrics like p-values. Our
motivation for studying fragility index arises from our interest in how
it differs based on different characteristics. Multiple prior journals
have showed that it requires just a few patients to alter their
outcomes. It is of concern to us that these studies require billions of
dollars sunk but outcomes can be “easily” rendered obsolete based on so
few participant outcomes.

Our question of interest is whether fragility index is associated with a
disease type. Specifically, we want to test the difference in fragility
index for cancer related therapies to non-oncology immunologic
monoclonal antibodies such as allergy, diabetes, and asthma. As a prior
belief, we hypothesize that the median fragility Index of trials
targeting cancers will be less than trials targeting auto-immune chronic
diseases.

# Intended Final Products

  - Dataset of clinical trials with baseline information and our
    filtering strategy
  - Figures/graphs highlighting our data compared to previously
    published information
  - Statistical test comparing median fragility index based on different
    characteristics
  - Website that collates our findings with landing page, background,
    graphs, data, methods, and FI calculator.

# Anticipated data sources

  - Search engines: Google Scholar, Pubmed, clinicaltrials.gov  
  - After trials are selected, will scrape data from clinicaltrials.gov
    using its API to get csv format and use R for analysis

# Plan for Analysis/Visualization and Challenges

# Planned Timeline

  - Data scraping and processing: ~7 days (11/9/2019)
  - Data analysis, review, graphical construction: ~10 days
  - Web building: ~4 days
  - Debugging: all the time
