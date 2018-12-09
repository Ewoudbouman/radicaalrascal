package t2;

/**
 * Source: 
 * Scenario-Based Comparison of Clone Detection Techniques
 * Figure 1. Taxonomy of Editing Scenarios for Different Clone Types
 */
public class CopyTwoC {
	
    public static void main(String[] args)
    {
    }
    
    void sumProd(int n){
    	int sum=0; //C1
    	int prod =1; 
    	for (int i=1; i<=n; i++)
	    	{sum=sum + i;
	    	prod = prod * i;
	    	foo(sum, prod); }}     
    
    public double foo(double a, double b) {
    	return 1.0;
    }    
}