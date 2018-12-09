package t3;

/**
 * Source: 
 * Scenario-Based Comparison of Clone Detection Techniques
 * Figure 1. Taxonomy of Editing Scenarios for Different Clone Types
 */
public class CopyThreeA {
	
    public static void main(String[] args)
    {
    }
    
    void sumProd(int n) {
    	double sum=0.0; //C1
    	double prod =1.0;
    	for (int i=1; i<=n; i++)
	    	{sum=sum + i;
	    	prod = prod * i;
	    	foo(sum, prod, n); }}
    
    public double foo(double a, double b, int n) {
    	return 1.0;
    }
}