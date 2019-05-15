void barchart1() {
  barChart = new BarChart(this);
  // Load in data from a file 

  barChart.setData(globalGDP); //<>//

  // Axis appearance
  textFont(createFont("Arial", 10), 10);
  barChart.setMinValue(0);
  barChart.setMaxValue(chartYAxisRange);
  barChart.showValueAxis(true);
  barChart.setValueFormat("$###,###");
  barChart.setBarLabels(year);
  barChart.showCategoryAxis(true);

  // Bar colours and appearance
  barChart.setBarColour(color(200, 80, 80, 150));
  barChart.setBarGap(4);

  // Bar layout
  barChart.transposeAxes(false);
}

void loadData() {

  data = loadStrings("USAGDP.csv");
  year = new String[data.length-1];
  GDP = new float[data.length-1];
  for (int i=0; i<data.length-1; i++)
  {
    String[] tokens = data[i+1].split(",");
    year[i] = tokens[0]; 
    GDP[i] = Float.parseFloat(tokens[1]);
     globalGDP[i] = 0;
  }
}