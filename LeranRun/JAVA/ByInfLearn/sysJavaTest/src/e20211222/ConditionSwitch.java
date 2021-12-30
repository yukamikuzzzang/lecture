package e20211222;

import java.util.Scanner;

public class ConditionSwitch {
    public static void main(String[] args){
        System.out.println("점수를 입력하세요.");
        //사용자로부터 데이터를 받겠다! Scanner 객체사용
        Scanner inputNum = new Scanner(System.in);
        //객체 생성시 new(객체생성자)를 써줌.

        int score = inputNum.nextInt();

        switch (score){
            case 90:
                System.out.println("score is 90");
                break;

            case 80:
                System.out.println("score is 80");
                break;

            case 70:
                System.out.println("score is 70");
                break;

            case 60:
                System.out.println("score is 60");
                break;

            case 50:
                System.out.println("score is 50");
                break;

            default:
                System.out.println("score == 몰?루");
                break;
        }
//        inputNum.close();

        System.out.println("점수를 입력하세요.(수/우/미)");
        score = inputNum.nextInt();
        switch (score){
            case 100:
            case 90:
                System.out.println("수");
                break;

            case 80:
                System.out.println("우");
                break;

            case 70:
                System.out.println("미");
                break;

            default:
                System.out.println("try Again!!");
                break;
        }
        inputNum.close();
    }
}
