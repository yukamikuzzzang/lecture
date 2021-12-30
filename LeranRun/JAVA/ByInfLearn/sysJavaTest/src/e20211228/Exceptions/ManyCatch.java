package e20211228.Exceptions;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;

public class ManyCatch {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int i, j;
        ArrayList<String> list = null;

        int[] iArr = {0, 1, 2, 3, 4};

        System.out.println("Exception BEFORE");

        try {
            System.out.println("input i :");
            i = scanner.nextInt();
            System.out.println("input j :");
            j = scanner.nextInt();

            System.out.println("i / j = " + (i / j));

            for (int k = 0; k < 6; k++) {
                System.out.println("iArr[" + k + "] : " + iArr[k]);
                //if(k >= 4) break;
            }

            System.out.println("list.size() : " + list.size());

        } catch (InputMismatchException e) {
            e.printStackTrace();
        } catch (ArrayIndexOutOfBoundsException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Exception AFTER");
    }
}
