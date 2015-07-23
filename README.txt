Extra task. Create a Maven configuration pom.xml for the project. It should include a test runner and working build config.

Sorry, but i'm not familiar with maven.


Extra task. Write method that takes two sorted arrays of integers (can be of any range, numbers can repeat, sizes of arrays can be different) and returns array of n + m length which is sorted in the same order. Do not use any type of built-in sorting.

Code you can find in the class:
    com.exadel.test.ArraysTest


Extra question. Explain what does this code do, how it works and what’ s wrong with it:

var xmlData:XML =
                <root>
                                <node myVal="1">data</node>
                                <node myVal="2"> data </node>
                                <node myVal="3"> data </node>
                                <node myVal="4"> data </node>
                                <node myVal="5"> data </node>
                </root>;

xmlData.children().(@myVal % 2 && trace(@myVal));

Answers:
1. What does this code do:
    Code outputs odd numbers (1,3,5)

2. How it works:
    It creates variable with type XML and name xmlData.
    Then goes through all root elements and checks condition.
    Condition: we apply function "parseFloat" to node's attribute "myVal", then get remainder of the division by 2
        if it not equal to "0", then invokes "trace" statement which outputs attribute's value.


3. What’ s wrong with it:
   xml is not optimal data structure for embedded values
   code isn't clean, there is a lot of code behind operations
   expected that all myVal's values are numbers, but that mentioned nowhere