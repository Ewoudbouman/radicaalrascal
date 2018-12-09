package t2;

/**
 * Source: 
 * Scenario-Based Comparison of Clone Detection Techniques
 * Figure 1. Taxonomy of Editing Scenarios for Different Clone Types
 */
public class CopyTwoA {
	
    public static void main(String[] args)
    {
    }
    
    void sumProd(int n){
    	double s=0.0; //C1
    	double p =1.0;
    	for (int j=1; j<=n; j++)
			{s=s + j;
			p = p * j;
			foo(s, p); }}     
    
    public double foo(double a, double b) {
    	return 1.0;
    }    
}