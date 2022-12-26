import java.util.*; // import the Scanner class 
import java.io.*;

public class FileAdder {
  public static int adder(String[] elements) {
    int total = 0;
    for (String s : elements) {
      if (s == null){
        break;
      }
      try {
        total += Integer.parseInt(s);
      }
      catch (NumberFormatException e) {
        String error = String.format("Ignoring bad input: %s", s);
        System.out.println(error);
      }
    }
    return total;
  }
  public static String[] readFile() {
    Scanner fileNameReader = new Scanner(System.in);
    System.out.println("Enter a file name: ");
    String fileName = fileNameReader.nextLine();
    String[] arr = new String[1000];
    try {
      Scanner fileReader = new Scanner(new File(fileName));
      int i=0;
      while ( fileReader.hasNextLine() ) {
        arr[i] = fileReader.nextLine();
        i++;
      }
      fileReader.close();
    }
    catch(FileNotFoundException err) {
      String error = String.format("Error --File %s not found", fileName);
      System.out.println(error);
      System.exit(0);
      err.printStackTrace();
    }
    return arr;
  }

  public static void main(String[] args) {
    String[] fileContents = FileAdder.readFile();
    int total = FileAdder.adder(fileContents);
    System.out.println("The total is " + total);
  }
}