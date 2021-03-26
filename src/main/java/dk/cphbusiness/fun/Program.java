package dk.cphbusiness.fun;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Program {

  public static void main(String[] args) {
    List<Integer> list = new ArrayList<>();
    list.add(7);
    list.add(8);
    list.add(9);
    list.add(13);

    var sum = list.stream()
        .filter(x -> x%2 == 1)
        .map(x -> 2*x)
        .reduce(0, (acc, x) -> acc + x);

//      (0, 14) -> 14
//      (14, 18) -> 32
//      (32, 26) -> 58

    System.out.println("Sum is "+sum);

//        .collect(Collectors.toList());

//    for (int i : l2) {
//      System.out.println(i);
//      }
    }

  }
