module Sandbox

import IO;
import String;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;

void helloWorld() {
   	println("Hello world, this is my first Rascal program");
}

public int fac3(int N)  { 
  if (N == 0) 
    return 1;
  return N * fac3(N - 1);
}

public int fact (int n) {
    if (n <= 1) {
	return 1;
    } else {
	return n * fact (n-1);
    }
}

list[int] even3(int max) {
  result = for (i <- [0..max], i % 2 == 0)
    append i;
  return result;
}

list[int] even4(int max) {
  return for (i <- [0..max], i % 2 == 0)
           append i;
}

public void fizzbuzz() {
   for(int n <- [1 .. 101]){
      fb = ((n % 3 == 0) ? "Fizz" : "") + ((n % 5 == 0) ? "Buzz" : "");
      println((fb == "") ?"<n>" : fb);
   }
}

public void fizzbuzz2() {
  for (n <- [1..101]) 
    switch(<n % 3 == 0, n % 5 == 0>) {
      case <true,true>  : println("FizzBuzz");
      case <true,false> : println("Fizz");
      case <false,true> : println("Buzz");
      default: println(n);
    }
}

public void fizzbuzz3() {
  for (n <- [1..101]) {
    if (n % 3 == 0) print("Fizz");
    if (n % 5 == 0) print("Buzz");
    else if (n % 3 != 0) print(n);
    println("");
  }
}

str bottles(0)     = "no more bottles"; 
str bottles(1)     = "1 bottle";
default str bottles(int n) = "<n> bottles"; 

public void sing(){ 
  for(n <- [99 .. 0]){
       println("<bottles(n)> of beer on the wall, <bottles(n)> of beer.");
       println("Take one down, pass it around, <bottles(n-1)> of beer on the wall.\n");
  }  
  println("No more bottles of beer on the wall, no more bottles of beer.");
  println("Go to the store and buy some more, 99 bottles of beer on the wall.");
}

public int countInLine1(str S){
  int count = 0;
  for(/[a-zA-Z0-9_]+/ := S){
       count += 1;
  }
  return count;
}

public int countInLine2(str S){
  int count = 0;
  
  // \w matches any word character
  // \W matches any non-word character
  // <...> are groups and should appear at the top level.
  while (/^\W*<word:\w+><rest:.*$>/ := S) { 
    count += 1; 
    S = rest; 
  }
  return count;
}


// capitalize: convert first letter of a word to uppercase

public str capitalize(str word)  
{
   if(/^<letter:[a-z]><rest:.*$>/ := word){
     return toUpperCase(letter) + rest;
   } else {
     return word;
   }
}

// Capitalize all words in a string

// Version 1: capAll1: using a while loop

public str capAll1(str S)        
{
 result = "";
 while (/^<before:\W*><word:\w+><after:.*$>/ := S) { 
    result = result + before + capitalize(word);
    S = after;
  }
  return result;
}

// Version 2: capAll2: using visit

public str capAll2(str S)        
{
   return visit(S){
   	case /^<word:\w+>/i => capitalize(word)
   };
}