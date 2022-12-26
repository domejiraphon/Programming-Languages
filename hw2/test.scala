object Demo {
   def main(args: Array[String]) {
      var i:Int =1 
      var j:Int = 0 
      mystery(i, i+1, i*4, j, j)
   }
   
   def addInt( a:Int, b:Int ) : Int = {
      var sum:Int = 0
      sum = a + b

      return sum
   }
   
   def mystery (a1:Int, a2:Int, a3:Int, a4:Int, a5:Int): Int = {
     var sum:Int = 0
     for( a <- 1 to 10){
         println( "Value of a: " + a );
      }
      return sum
   }
}