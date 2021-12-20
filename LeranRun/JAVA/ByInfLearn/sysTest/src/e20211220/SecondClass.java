package e20211220;

public class SecondClass {
    public static void main(String[] args){
        //서식 문자
        System.out.println("오늘의 기온은 10도 입니다.");
        System.out.printf("오늘의 기온은 %d도 입니다.\n", 9);

        int num1 = 20;
        System.out.println("오늘의 기온은" + num1 + "도 입니다.");
        System.out.printf("오늘의 기온은 %d도 입니다.\n",num1);

        //정수
        int num2 = 20;
        System.out.printf("num2(10진수): %d\n", num2);
        System.out.printf("num2(8진수): %o\n", num2);
        System.out.printf("num2(16진수): %x\n", num2);

        //문자
        char c1 = 'b';
        char c2 = 'B';

        System.out.printf("소문자 \'%c\'의 대문자는 \'%c\'입니다.\n",'a','A');
        //System.out.println("소문자 \'%c\'의 대문자는 \'%c\'입니다.",'a','A');
        //위에 꺼 안됨.. println엔 관련된 포맷은 없나봄.
        //printf 포맷을 사용하기 위해 쓰는 출력문. % 쓰려면 printf
        System.out.printf("소문자 \'%c\'의 대문자는 \'%c\'입니다.\n",c1, c2);

        //문자열
        System.out.printf("\'%s\'을 대문자로 바꾸면 \'%s\'입니다.\n","java","JAVA");

        //실수형
        double d = 1.123456d; //d(더블형 변수라는 뜻)
        System.out.printf("d = %f\n",d);

        //서식문자 정렬 기능
        System.out.printf("%d\n",123);
        System.out.printf("%d\n",1234);
        System.out.printf("%d\n",12345);
        
        System.out.println("");
        
        System.out.printf("%5d\n",123);
        System.out.printf("%5d\n",1234);
        System.out.printf("%5d\n",12345);
        
        //서식문자 소수점제한 기능
        System.out.printf("%f\n",1.23);
        System.out.printf("%.0f\n",1.23);
        System.out.printf("%.1f\n",1.23);
        System.out.printf("%.2f\n",1.23);
        System.out.printf("%.3f\n",1.23);
    }
}
