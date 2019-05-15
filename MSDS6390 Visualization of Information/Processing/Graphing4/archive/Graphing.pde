import org.gicentre.utils.stat.*;    // For chart classes.
 
// Simple scatterplot compating income and life expectancy.
 
XYChart scatterplot;
 
// Loads data into the chart and customises its appearance.
void setup()
{
  size(500,250);   
  textFont(createFont("Arial",11),11);
 
  // Both x and y data set here.  
  scatterplot = new XYChart(this);
  
  // Load in data from a file 
  // (first line of file contains column headings).
  String[] data = loadStrings("CountryData.csv");
  String[] country = new String[data.length-1];
  float[] year  = new float[data.length-1];
  float[] GDP  = new float[data.length-1];
  float[] LifeExp = new float[data.length-1];
  float[] population = new float[data.length-1];
      
  for (int i=0; i<data.length-1; i++)
  {
    String[] tokens = data[i+1].split(",");
    country[i]  = tokens[0];   
    year[i] = Float.parseFloat(tokens[1]); 
    GDP[i] = Float.parseFloat(tokens[2]); 
    LifeExp[i] = Float.parseFloat(tokens[3]); 
    population[i] = Float.parseFloat(tokens[4]); 
  }
  
  scatterplot.setData(GDP,LifeExp);
  
  // Axis formatting and labels.
  scatterplot.showXAxis(true); 
  scatterplot.showYAxis(true); 
  scatterplot.setXFormat("$###,###");
  scatterplot.setXAxisLabel("\nGDP per capita "+  
                            "(inflation adjusted $US)");
  scatterplot.setYAxisLabel("Life expectancy at birth (years)\n");
 
  // Symbol styles
  scatterplot.setPointColour(color(180,50,50,100));
  scatterplot.setPointSize(5);
}
 
// Draws the scatterplot.
void draw()
{
  background(255);
  for (int y = 1800; y < 2000; y+=10) {
    scatterplot.draw(20,20,width-40,height-40);
  }
}