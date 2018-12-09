package t2;

/**
 * Source: 
 * Scenario-Based Comparison of Clone Detection Techniques
 * Figure 1. Taxonomy of Editing Scenarios for Different Clone Types
 */
public class CopyTwoD {
	
    public static void main(String[] args)
    {
    }
    
    void sumProd(int n){
    	double sum=0.0; //C1
    	double prod =1.0; 
    	for (int i=1; i<=n; i++)
	    	{sum=sum + (i*i);
	    	prod = prod*(i*i);
	    	foo(sum, prod); }}     
    
    public double foo(double a, double b) {
    	return 1.0;
    }    
}