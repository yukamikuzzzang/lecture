package e20211222;

import java.util.Scanner;

public class C_Loop {
    public static void main(String[] args){
        System.out.println("Input Number : ");

        Scanner scanner = new Scanner(System.in);
        int inputNum = scanner.nextInt();

        //for문
        for(int i = 1;i < 10; i++){
            System.out.printf("%d * %d = %d\n", inputNum, i, inputNum * i);
        }

        //while문
        int i = 1;
        while(i < 10){
            System.out.printf("%d * %d = %d\n", inputNum, i, inputNum * i);
            i++;
        }

        //do while문
        i = 10;
        do{
            System.out.println("무조건 1번은 실행합니다.");
            i++;
        } while(i > 13);   //거짓
    }
}
