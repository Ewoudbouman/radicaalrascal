package t3;

/**
 * Source: 
 * Scenario-Based Comparison of Clone Detection Techniques
 * Figure 1. Taxonomy of Editing Scenarios for Different Clone Types
 */
public class CopyThreeB {
	
    public static void main(String[] args)
    {
    }
    
    void sumProd(int n) {
    	double sum=0.0; //C1
    	double prod =1.0;
    	for (int i=1; i<=n; i++)
	    	{sum=sum + i;
	    	prod = prod * i;
	    	foo(prod); }}
    
    public double foo(double a) {
    	return 1.0;
    }
}