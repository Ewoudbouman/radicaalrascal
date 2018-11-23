/* 23 lines 16 code 4 comments 3 blanks source: github.com/Aaronepower/tokei */

/*
 * Simple test class
 */
public class sloctest
{
    int j = 0; // Not counted
    public static void main(String[] args)
    {
        Foo f = new Foo();
        f.bar();
        
    }
}

class Foo
{
    public void bar()
    {
      System.out.println("FooBar"); //Not counted
    }
}