package e20211222;

import java.util.Scanner;

/*7강*/
public class Array {
    public static void main (String[] args){
        //배열 선언 단계
        int[] arr1 = new int[5]; //index 0~4
        arr1[0] = 100;
        arr1[1] = 200;
        arr1[2] = 300;
        arr1[3] = 400;
        arr1[4] = 500;

        System.out.println("arr1[0] :"+ arr1[0]);
        System.out.println("arr1[1] :"+ arr1[1]);
        System.out.println("arr1[2] :"+ arr1[2]);
        System.out.println("arr1[3] :"+ arr1[3]);
        System.out.println("arr1[4] :"+ arr1[4]);

        //배열 선언과 초기화를 동시에
        int[] arr2 = {10, 20, 30, 40, 50};
        /*
        int[] arr2 = new int[5];
        arr2[0] = 10;
        arr2[1] = 20;
        arr2[2] = 30;
        arr2[3] = 40;
        arr2[4] = 50;
        */
        System.out.println("arr2[0] :"+ arr2[0]);
        System.out.println("arr2[0] :"+ arr2[1]);
        System.out.println("arr2[0] :"+ arr2[2]);
        System.out.println("arr2[0] :"+ arr2[3]);
        System.out.println("arr2[0] :"+ arr2[4]);

        //허용되지 않은 인덱스를 출력하면 Exception(예외) 발생
        //System.out.println(arr1[5]);
        //Exception in thread "main" java.lang.ArrayIndexOutOfBoundsException: Index 5 out of bounds for length 5 at e20211222.Array.main(Array.java:35)

        //배열을 이용한 학사관리
        String[] name = {"박찬호","이승엽","박병호","이병규","류현진"};
        int[] score = new int[5];
        Scanner scanner = new Scanner(System.in);
        //사용자로부터 입력받기를 기다리는 함수
        System.out.printf("%s의 점수를 입력하시오. : ",name[0]);
        score[0] = scanner.nextInt();
        System.out.printf("%s의 점수를 입력하시오. : ",name[1]);
        score[1] = scanner.nextInt();
        System.out.printf("%s의 점수를 입력하시오. : ",name[2]);
        score[2] = scanner.nextInt();
        System.out.printf("%s의 점수를 입력하시오. : ",name[3]);
        score[3] = scanner.nextInt();
        System.out.printf("%s의 점수를 입력하시오. : ",name[4]);
        score[4] = scanner.nextInt();

        System.out.printf("%s 점수: \t%.2f\n", name[0], (double)score[0]);
        System.out.printf("%s 점수: \t%.2f\n", name[1], (double)score[1]);
        System.out.printf("%s 점수: \t%.2f\n", name[2], (double)score[2]);
        System.out.printf("%s 점수: \t%.2f\n", name[3], (double)score[3]);
        System.out.printf("%s 점수: \t%.2f\n", name[4], (double)score[4]);

        double ave = (double)(score[0] + score[1] + score[2] + score[3] + score[4]) / 5;
        System.out.printf("\n평 점 : \t%.2f", ave);

        scanner.close();
        System.out.println();
    }
}
